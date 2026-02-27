USE AirWeb
GO

CREATE OR ALTER PROCEDURE etl.ICIS_CaseFile_Delete
AS

/**************************************************************************************************

Author:     Vidyanand Dhande
Overview:   Stage Case File & Enforcement Action deletions for ICIS-Air

Tables written to:
  - NETWORKNODEFLOW.dbo.CaseFile
  - NETWORKNODEFLOW.dbo.CaseFile2CMLink
  - NETWORKNODEFLOW.dbo.EnforcementAction
  - NETWORKNODEFLOW.dbo.EnforcementActionMilestone
  - NETWORKNODEFLOW.dbo.CaseFile2DAEALink

Modification History:
When        Who                 What
----------  ------------------  -------------------------------------------------------------------
Previously  DWaldron            Initially created in Oracle
2016-06-28  VDhande             Migrated to SQL Server
2024-09-17  DWaldron            Reformatted
2026-02-04  DWaldron            Complete rewrite for the new Air Web App (epa-dx#2)
2026-02-27  DWaldron            Delete pathway activities when NFA letters are deleted (air-web/502)

***************************************************************************************************/

    SET XACT_ABORT, NOCOUNT ON;
BEGIN TRY
    BEGIN TRANSACTION;

    -- Gather data
    select etl.EpaActionId(c.FacilityId, c.ActionNumber) as CaseFileId,
           c.Id                                          as AirWebId
    into #CaseFileDeletions
    from dbo.CaseFiles c
    where c.IsDeleted = 1
      and c.ActionNumber is not null
      and exists (select 1
                  from NETWORKNODEFLOW.dbo.AirFacility
                  where AirFacilityID = etl.EpaFacilityId(c.FacilityId))
      and c.DataExchangeStatus = 'D';

    select etl.EpaActionId(e.FacilityId, e.ActionNumber) as EnforcementActionId,
           e.Id                                          as AirWebId
    into #EnforcementActionDeletions
    from dbo.EnforcementActions e
    where e.IsDeleted = 1
      and e.ActionNumber is not null
      and e.ActionType in (N'NovNfaLetter', N'NoticeOfViolation', N'ProposedConsentOrder',
                           N'ConsentOrder', N'AdministrativeOrder')
      and exists (select 1
                  from NETWORKNODEFLOW.dbo.AirFacility
                  where AirFacilityID = etl.EpaFacilityId(e.FacilityId))
      and e.DataExchangeStatus = 'D';

    select CaseFileId,
           e.Id as AirWebId
    into #NoFurtherActionDeletions
    from dbo.EnforcementActions e
    where e.IsDeleted = 1
      and e.ActionNumber is not null
      and e.ActionType in (N'NovNfaLetter', N'NoFurtherActionLetter')
      and exists (select 1
                  from NETWORKNODEFLOW.dbo.AirFacility
                  where AirFacilityID = etl.EpaFacilityId(e.FacilityId))
      and e.DataExchangeStatus = 'D';

    -- Delete records from NETWORKNODEFLOW
    delete t
    from NETWORKNODEFLOW.dbo.CaseFile t
    where exists (select 1
                  from #CaseFileDeletions u
                  where u.CaseFileId = t.CaseFileId);

    delete t
    from NETWORKNODEFLOW.dbo.CaseFile2CMLink t
    where exists (select 1
                  from #CaseFileDeletions u
                  where u.CaseFileId = t.CaseFileId);

    delete t
    from NETWORKNODEFLOW.dbo.EnforcementAction t
    where exists (select 1
                  from #EnforcementActionDeletions u
                  where u.EnforcementActionId = t.EnforcementActionId);

    delete t
    from NETWORKNODEFLOW.dbo.EnforcementActionMilestone t
    where exists (select 1
                  from #EnforcementActionDeletions u
                  where u.EnforcementActionId = t.EnforcementActionId);

    delete t
    from NETWORKNODEFLOW.dbo.CaseFile2DAEALink t
    where exists (select 1
                  from #EnforcementActionDeletions u
                  where u.EnforcementActionId = t.EnforcementActionId)
       or exists (select 1
                  from #CaseFileDeletions u
                  where u.CaseFileId = t.CaseFileId);

    delete t
    from NETWORKNODEFLOW.dbo.OTHERPATHWAYACTIVITYDATA t
    where exists (select 1
                  from #NoFurtherActionDeletions u
                  where u.CaseFileId = t.CASEFILEID);

    -- Update DX status
    update u
    set DataExchangeStatus     = 'X',
        DataExchangeStatusDate = sysdatetimeoffset()
    from dbo.CaseFiles u
    where exists (select 1
                  from #CaseFileDeletions t
                  where t.AirWebId = u.Id);

    update u
    set DataExchangeStatus     = 'X',
        DataExchangeStatusDate = sysdatetimeoffset()
    from dbo.EnforcementActions u
    where exists (select 1
                  from #EnforcementActionDeletions t
                  where t.AirWebId = u.Id);

    update u
    set DataExchangeStatus     = 'X',
        DataExchangeStatusDate = sysdatetimeoffset()
    from dbo.EnforcementActions u
    where exists (select 1
                  from #NoFurtherActionDeletions t
                  where t.AirWebId = u.Id
                    and DataExchangeStatus = 'D');

    COMMIT TRANSACTION;
    RETURN 0;
END TRY
BEGIN CATCH
    IF @@trancount > 0
        ROLLBACK TRANSACTION;
    DECLARE
        @ErrorMessage nvarchar(4000) = ERROR_MESSAGE(),
        @ErrorSeverity int = ERROR_SEVERITY();
    RAISERROR (@ErrorMessage, @ErrorSeverity, 1);
    RETURN -1;
END CATCH
GO

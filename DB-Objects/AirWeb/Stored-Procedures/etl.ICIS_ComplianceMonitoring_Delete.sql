USE AirWeb
GO

CREATE OR ALTER PROCEDURE etl.ICIS_ComplianceMonitoring_Delete
AS

/**************************************************************************************************

Author:     Vidyanand Dhande
Overview:   Stage Compliance Monitoring deletions for ICIS-Air

Tables written to:
  - NETWORKNODEFLOW.dbo.ComplianceMonitoring

Plus data exchange status reset in:
  - AirWeb.dbo.ComplianceWork

Modification History:
When        Who                 What
----------  ------------------  -------------------------------------------------------------------
Previously  DWaldron            Initially created in Oracle
2016-06-28  VDhande             Migrated to SQL Server
2026-02-04  DWaldron            Complete rewrite for the new Air Web App (epa-dx#2)

***************************************************************************************************/

    SET XACT_ABORT, NOCOUNT ON;
BEGIN TRY

    BEGIN TRANSACTION;

    select etl.EpaActionId(f.FacilityId, f.ActionNumber) as ComplianceMonitoringId,
           f.Id                                          as AirWebId
    into #FceDeletions
    from dbo.Fces f
    where f.IsDeleted = 1
      and f.ActionNumber is not null
      and f.DataExchangeStatus = 'D'
      and exists (select 1
                  from NETWORKNODEFLOW.dbo.AirFacility
                  where AirFacilityID = etl.EpaFacilityId(f.FacilityId));

    select etl.EpaActionId(c.FacilityId, c.ActionNumber) as ComplianceMonitoringId,
           c.Id                                          as AirWebId
    into #CmDeletions
    from dbo.ComplianceWork c
    where c.IsDeleted = 1
      and c.ActionNumber is not null
      and c.ComplianceWorkType in
          (N'AnnualComplianceCertification', N'Inspection', N'Report', N'SourceTestReview')
      and exists (select 1
                  from NETWORKNODEFLOW.dbo.AirFacility
                  where AirFacilityID = etl.EpaFacilityId(c.FacilityId))
      and c.DataExchangeStatus = 'D';

    delete t
    from NETWORKNODEFLOW.dbo.ComplianceMonitoring t
    where exists (select 1
                  from #FceDeletions u
                  where u.ComplianceMonitoringId = t.ComplianceMonitoringId)
       or exists (select 1
                  from #CmDeletions u
                  where u.ComplianceMonitoringId = t.ComplianceMonitoringId);

    delete t
    from NETWORKNODEFLOW.dbo.CaseFile2CMLink t
    where exists (select 1
                  from #CmDeletions u
                  where u.ComplianceMonitoringId = t.ComplianceMonitoringId);

    update u
    set DataExchangeStatus     = 'X',
        DataExchangeStatusDate = sysdatetimeoffset()
    from dbo.Fces u
    where exists (select 1
                  from #FceDeletions t
                  where t.AirWebId = u.Id);

    update u
    set DataExchangeStatus     = 'X',
        DataExchangeStatusDate = sysdatetimeoffset()
    from dbo.ComplianceWork u
    where exists (select 1
                  from #CmDeletions t
                  where t.AirWebId = u.Id);

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

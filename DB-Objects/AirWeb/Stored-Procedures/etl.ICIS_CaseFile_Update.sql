USE AirWeb
GO

CREATE OR ALTER PROCEDURE etl.ICIS_CaseFile_Update
as

/**************************************************************************************************

Author:     Doug Waldron
Overview:   Stage Case File & Enforcement Action updates for ICIS-Air

Tables written to:
  - NETWORKNODEFLOW.dbo.CaseFile
  - NETWORKNODEFLOW.dbo.CASEFILECODE
  - NETWORKNODEFLOW.dbo.AIRVIOLATIONDATA
  - NETWORKNODEFLOW.dbo.CaseFile2CMLink
  - NETWORKNODEFLOW.dbo.EnforcementAction
  - NETWORKNODEFLOW.dbo.EnforcementActionAirFacility
  - NETWORKNODEFLOW.dbo.CaseFile2DAEALink
  - NETWORKNODEFLOW.dbo.ENFORCEMENTACTIONCODE
  - NETWORKNODEFLOW.dbo.AirDAFinalOrder
  - NETWORKNODEFLOW.dbo.AirDAFinalOrderAirFacility
  - NETWORKNODEFLOW.dbo.EnforcementActionMilestone
  - NETWORKNODEFLOW.dbo.OTHERPATHWAYACTIVITYDATA

Plus data exchange status reset in:
  - AirWeb.dbo.EnforcementCaseFiles
  - AirWeb.dbo.EnforcementActions

Modification History:
When        Who                 What
----------  ------------------  -------------------------------------------------------------------
Previously  DWaldron            Initially created in Oracle
2016-06-29  VDhande             Migrated to SQL Server
2017-05-24  DWaldron            Add code to populate Final Order Identifier (DX-14)
2017-10-31  DWaldron            Update Case File-Enforcement Action/CM linkages any time a case
                                file gets updated (ensures broken linkages get fixed) (DX-39)
2017-11-02  DWaldron            Allow multiple Compliance Monitoring linkages for Case Files (IAIP-442)
2018-12-01  DWaldron            Fix missing FinalOrderIdentifier in Enf Actions: This only affected
                                Case Files where final order exists when Case File first inserted. (DX-73)
2024-09-17  DWaldron            Reformatted
2024-09-20  DWaldron            Handle Proposed COs as if they were NOVs (icis-air#85)
2026-01-30  DWaldron            Complete rewrite for the new Air Web App (epa-dx#2)
2026-02-27  DWaldron            Only submit "reportable" Case Files (air-web#502)
2026-03-09  DWaldron            Fix enforcement action type codes (epa-dx#92)
2026-03-16  DWaldron            Rename the Case Files table (epa-dx#95)

***************************************************************************************************/

    SET XACT_ABORT, NOCOUNT ON;
BEGIN TRY
    BEGIN TRANSACTION;

    --============================================================================================
    -- Case Files

    select CaseFileId,
           AirFacilityId,
           CaseFileName,
           SensitiveDataIndicator,
           AdvisementMethodDate,
           AdvisementMethodTypeCode,
           ViolationTypeCode,
           FrvDeterminationDate,
           HpvDayZeroDate,
           GaFacilityId as CaseFileUserDefinedField3,
           AirPrograms,
           PollutantIds,
           AirWebId
    into #CaseFileUpdates
    from etl.VW_ICIS_CaseFile
    where DataExchangeStatus = 'U'
      and IsReportable = 1;

    -- Update existing Case Files
    update t
    set SensitiveDataIndicator   = u.SensitiveDataIndicator,
        AdvisementMethodTypeCode = u.AdvisementMethodTypeCode,
        AdvisementMethodDate     = u.AdvisementMethodDate
    from NETWORKNODEFLOW.dbo.CaseFile t
        inner join #CaseFileUpdates u
            on u.CaseFileId = t.CaseFileId;

    -- Insert new Case Files
    insert into NETWORKNODEFLOW.dbo.CaseFile
    (CaseFileId, CaseFileName, LeadAgencyCode, AirFacilityId, SensitiveDataIndicator,
     AdvisementMethodTypeCode, AdvisementMethodDate, CaseFileUserDefinedField3, TransactionID)
    select u.CaseFileId,
           u.CaseFileName,
           'ST2'   as LeadAgencyCode,
           u.AirFacilityId,
           u.SensitiveDataIndicator,
           u.AdvisementMethodTypeCode,
           u.AdvisementMethodDate,
           u.CaseFileUserDefinedField3,
           newid() as TransactionID
    from #CaseFileUpdates u
    where not exists (select 1
                      from NETWORKNODEFLOW.dbo.CaseFile t
                      where t.CaseFileId = u.CaseFileId);

    -- Delete and reinsert case file Program and Pollutant codes
    delete t
    from NETWORKNODEFLOW.dbo.CASEFILECODE t
    where exists (select 1
                  from #CaseFileUpdates u
                  where u.CaseFileId = t.CASEFILEID);

    insert into NETWORKNODEFLOW.dbo.CASEFILECODE
        (CASEFILECODEID, CASEFILEID, CODENAME, CODEVALUE)
    select newid()       as CASEFILECODEID,
           CaseFileId    as CASEFILEID,
           'ProgramCode' as CODENAME,
           value         as CODEVALUE
    from #CaseFileUpdates
        cross apply openjson(AirPrograms);

    insert into NETWORKNODEFLOW.dbo.CASEFILECODE
        (CASEFILECODEID, CASEFILEID, CODENAME, CODEVALUE)
    select newid()            as CASEFILECODEID,
           CaseFileId         as CASEFILEID,
           'AirPollutantCode' as CODENAME,
           value              as CODEVALUE
    from #CaseFileUpdates
        cross apply openjson(PollutantIds);

    -- Delete and reinsert case file Air Violation codes
    delete t
    from NETWORKNODEFLOW.dbo.AIRVIOLATIONDATA t
    where exists (select 1
                  from #CaseFileUpdates u
                  where u.CaseFileId = t.CASEFILEID);

    insert into NETWORKNODEFLOW.dbo.AIRVIOLATIONDATA
    (AIRVIOLATIONDATAID, CASEFILEID, AIRVIOLATIONTYPECODE, AIRVIOLATIONPROGRAMCODE, AIRVIOLATIONPOLLUTANTCODE,
     FRVDETERMINATIONDATE, HPVDAYZERODATE)
    select newid()              as AIRVIOLATIONDATAID,
           CaseFileId           as CASEFILEID,
           ViolationTypeCode    as AIRVIOLATIONTYPECODE,
           ProgramCode          as AIRVIOLATIONPROGRAMCODE,
           PollutantCode        as AIRVIOLATIONPOLLUTANTCODE,
           FrvDeterminationDate as FRVDETERMINATIONDATE,
           HpvDayZeroDate       as HPVDAYZERODATE
    from #CaseFileUpdates
        -- ↓ Pollutant Code max length is 10 from XML Schema
        outer apply openjson(PollutantIds) with (PollutantCode nvarchar(10) '$')
        -- ↓ Program Code max length is 9 from XML Schema
        outer apply openjson(AirPrograms) with (ProgramCode nvarchar(9) '$');

    --============================================================================================
    -- Case File to Compliance Event Linkage

    -- Insert/delete case file to compliance monitoring linkages
    select CaseFileId, ComplianceMonitoringId, AirWebId, DataExchangeStatus
    into #CaseFileToCmUpdates
    from etl.VW_ICIS_CaseFileComplianceEvents
    where DataExchangeStatus = 'U';

    delete t
    from NETWORKNODEFLOW.dbo.CaseFile2CMLink t
    where t.CaseFileId in (select CaseFileId from #CaseFileToCmUpdates)
      and not exists (select 1
                      from #CaseFileToCmUpdates u
                      where t.CaseFileId = u.CaseFileId
                        and t.ComplianceMonitoringId = u.ComplianceMonitoringId);

    insert into NETWORKNODEFLOW.dbo.CaseFile2CMLink (CaseFileId, ComplianceMonitoringId, TransactionId)
    select CaseFileId,
           ComplianceMonitoringId,
           newid() as TransactionId
    from #CaseFileToCmUpdates u
    where not exists (select 1
                      from NETWORKNODEFLOW.dbo.CaseFile2CMLink t
                      where t.CaseFileId = u.CaseFileId
                        and t.ComplianceMonitoringId = u.ComplianceMonitoringId);

    --============================================================================================
    -- Enforcement Actions

    select EnforcementActionId,
           AirFacilityId,
           EnforcementActionTypeCode,
           EnforcementActionName,
           GaFacilityId as EAUserDefinedField3,
           AchievedDate,
           AirPrograms,
           PollutantIds,
           CaseFileId,
           AirWebId
    into #InformalEaUpdates
    from etl.VW_ICIS_InformalEnforcementAction
    where DataExchangeStatus = 'U';

    select EnforcementActionId,
           AirFacilityId,
           ActionType,
           EnforcementActionName,
           GaFacilityId as EAUserDefinedField3,
           FinalOrderIssuedEnteredDate,
           AirEnforcementActionResolvedDate,
           CashCivilPenaltyRequiredAmount,
           ExecutedDate,
           AppealedDate,
           AirPrograms,
           PollutantIds,
           CaseFileId,
           AirWebId
    into #FormalEaUpdates
    from etl.VW_ICIS_FormalEnforcementAction
    where DataExchangeStatus = 'U';

    select EnforcementActionId, ActionType, AirPrograms, PollutantIds, CaseFileId, AirFacilityId, AirWebId
    into #AllEaUpdates
    from (select EnforcementActionId,
                 ActionType,
                 AirPrograms,
                 PollutantIds,
                 CaseFileId,
                 AirFacilityId,
                 AirWebId
          from #FormalEaUpdates
          union
          select EnforcementActionId,
                 'NOV',
                 AirPrograms,
                 PollutantIds,
                 CaseFileId,
                 AirFacilityId,
                 AirWebId
          from #InformalEaUpdates) t;

    -- Update existing Enforcement Actions
    update t
    set EnforcementActionName = u.EnforcementActionName,
        AchievedDate          = u.AchievedDate
    from NETWORKNODEFLOW.dbo.EnforcementAction t
        inner join #InformalEaUpdates u
            on u.EnforcementActionId = t.EnforcementActionId;

    update t
    set EnforcementActionName = u.EnforcementActionName
    from NETWORKNODEFLOW.dbo.EnforcementAction t
        inner join #FormalEaUpdates u
            on u.EnforcementActionId = t.EnforcementActionId;

    -- Insert new Enforcement Actions
    insert into NETWORKNODEFLOW.dbo.EnforcementAction
    (EnforcementActionId, EnforcementActionTypeCode, EnforcementActionName, AchievedDate, EAUserDefinedField3,
     LeadAgencyCode, Type, TransactionID)
    select u.EnforcementActionId,
           u.EnforcementActionTypeCode,
           u.EnforcementActionName,
           u.AchievedDate,
           u.EAUserDefinedField3,
           'ST4'         as LeadAgencyCode,
           N'DAInFormal' as Type,
           newid()       as TransactionID
    from #InformalEaUpdates u
    where not exists (select 1
                      from NETWORKNODEFLOW.dbo.EnforcementAction t
                      where t.EnforcementActionId = u.EnforcementActionId);

    insert into NETWORKNODEFLOW.dbo.EnforcementAction
    (EnforcementActionId, EnforcementActionTypeCode, EnforcementActionName, Forum, EAUserDefinedField3,
     LeadAgencyCode, Type, TransactionID)
    select u.EnforcementActionId,
           iif(u.ActionType = N'ConsentOrder', N'SCAAAO', N'CIV') as EnforcementActionTypeCode,
           u.EnforcementActionName,
           iif(u.ActionType = N'ConsentOrder', N'AFR', N'JDC')    as Forum,
           u.EAUserDefinedField3,
           'ST4'                                                  as LeadAgencyCode,
           'DAFormal'                                             as Type,
           newid()                                                as TransactionID
    from #FormalEaUpdates u
    where not exists (select 1
                      from NETWORKNODEFLOW.dbo.EnforcementAction t
                      where t.EnforcementActionId = u.EnforcementActionId);

    -- Insert enforcement action facilities
    -- (No update or delete needed because enforcement actions facility can't be changed.)
    insert into NETWORKNODEFLOW.dbo.EnforcementActionAirFacility (EnforcementActionId, AirFacilityId)
    select u.EnforcementActionId, u.AirFacilityId
    from #AllEaUpdates u
    where not exists (select 1
                      from NETWORKNODEFLOW.dbo.EnforcementActionAirFacility t
                      where t.EnforcementActionId = u.EnforcementActionId);

    -- Insert Case File to Enforcement Action linkage
    -- (No update or delete needed because case file/enforcement action linkage can't be changed.)
    insert into NETWORKNODEFLOW.dbo.CaseFile2DAEALink (CaseFileId, EnforcementActionId, TransactionId)
    select CaseFileId, EnforcementActionId, newid() as TransactionId
    from #AllEaUpdates u
    where not exists (select 1
                      from NETWORKNODEFLOW.dbo.CaseFile2DAEALink t
                      where t.EnforcementActionId = u.EnforcementActionId);

    -- Delete and reinsert Enforcement Action Programs and Pollutants
    delete t
    from NETWORKNODEFLOW.dbo.ENFORCEMENTACTIONCODE t
    where exists (select 1
                  from #AllEaUpdates u
                  where u.EnforcementActionId = t.ENFORCEMENTACTIONID
                    and t.CODENAME in ('ProgramsViolatedCode', 'AirPollutantCode'));

    insert into NETWORKNODEFLOW.dbo.ENFORCEMENTACTIONCODE
    (ENFORCEMENTACTIONCODEID, ENFORCEMENTACTIONID, CODENAME, CODEVALUE)
    select newid()                as ENFORCEMENTACTIONCODEID,
           EnforcementActionId    as ENFORCEMENTACTIONID,
           'ProgramsViolatedCode' as CODENAME,
           value                  as CODEVALUE
    from #AllEaUpdates
        cross apply openjson(AirPrograms);

    insert into NETWORKNODEFLOW.dbo.ENFORCEMENTACTIONCODE
    (ENFORCEMENTACTIONCODEID, ENFORCEMENTACTIONID, CODENAME, CODEVALUE)
    select newid()             as ENFORCEMENTACTIONCODEID,
           EnforcementActionId as ENFORCEMENTACTIONID,
           'AirPollutantCode'  as CODENAME,
           value               as CODEVALUE
    from #AllEaUpdates
        cross apply openjson(PollutantIds);

    -- Insert Enforcement Action Type Code
    -- (No update or delete needed because Enforcement Action Type can't be changed)
    insert into NETWORKNODEFLOW.dbo.ENFORCEMENTACTIONCODE
    (ENFORCEMENTACTIONCODEID, ENFORCEMENTACTIONID, CODENAME, CODEVALUE)
    select newid()                                              as ENFORCEMENTACTIONCODEID,
           EnforcementActionId                                  as ENFORCEMENTACTIONID,
           'EnforcementActionTypeCode'                          as CODENAME,
           iif(ActionType = N'ConsentOrder', N'SCAAAO', N'CIV') as CODEVALUE
    from #AllEaUpdates u
    where not exists (select 1
                      from NETWORKNODEFLOW.dbo.ENFORCEMENTACTIONCODE t
                      where t.ENFORCEMENTACTIONID = u.EnforcementActionId
                        and t.CODENAME = 'EnforcementActionTypeCode');

    -- Insert/update Final Orders
    update t
    set FinalOrderIssuedEnteredDate      = u.FinalOrderIssuedEnteredDate,
        AirEnforcementActionResolvedDate = u.AirEnforcementActionResolvedDate,
        CashCivilPenaltyRequiredAmount   = u.CashCivilPenaltyRequiredAmount
    from NETWORKNODEFLOW.dbo.AirDAFinalOrder t
        inner join #FormalEaUpdates u
            on u.EnforcementActionId = t.EnforcementActionId;

    insert into NETWORKNODEFLOW.dbo.AirDAFinalOrder
    (AirDAFinalOrderId, EnforcementActionId, FinalOrderTypeCode, FinalOrderIssuedEnteredDate,
     AirEnforcementActionResolvedDate, CashCivilPenaltyRequiredAmount, FinalOrderIdentifier)
    select newid()                                             as AirDAFinalOrderId,
           EnforcementActionId,
           iif(u.ActionType = N'ConsentOrder', N'AFO', N'CDO') as FinalOrderTypeCode,
           u.FinalOrderIssuedEnteredDate,
           u.AirEnforcementActionResolvedDate,
           u.CashCivilPenaltyRequiredAmount,
           -- ↓ GA only issues one final order for any Case File:
           1                                                   as FinalOrderIdentifier
    from #FormalEaUpdates u
    where not exists (select 1
                      from NETWORKNODEFLOW.dbo.AirDAFinalOrder t
                      where t.EnforcementActionId = u.EnforcementActionId);

    -- Insert Final Order Facilities
    -- (No update or delete needed Final Order Facility can't be changed)
    insert into NETWORKNODEFLOW.dbo.AirDAFinalOrderAirFacility (AirDAFinalOrderId, AirFacilityId)
    select f.AirDAFinalOrderId, u.AirFacilityId
    from NETWORKNODEFLOW.dbo.AirDAFinalOrder f
        inner join #AllEaUpdates u
            on u.EnforcementActionId = f.EnforcementActionId
    where not exists (select 1
                      from NETWORKNODEFLOW.dbo.AirDAFinalOrderAirFacility t
                      where t.AirDAFinalOrderId = f.AirDAFinalOrderId);

    -- Insert/update Enforcement Action Milestones.
    -- Milestones are only used for Formal Judicial Enforcement Actions (i.e., Administrative Orders)
    -- * RSAGJ - Date AO Executed
    -- * CMF - Date AO Appealed
    update t
    set MilestoneActualDate = u.ExecutedDate
    from NETWORKNODEFLOW.dbo.EnforcementActionMilestone t
        inner join #FormalEaUpdates u
            on u.EnforcementActionId = t.EnforcementActionId
            and t.Type = 'RSAGJ';

    update t
    set MilestoneActualDate = u.AppealedDate
    from NETWORKNODEFLOW.dbo.EnforcementActionMilestone t
        inner join #FormalEaUpdates u
            on u.EnforcementActionId = t.EnforcementActionId
            and t.Type = 'CMF';

    insert into NETWORKNODEFLOW.dbo.EnforcementActionMilestone
        (EnforcementActionId, MilestoneActualDate, Type, TransactionID)
    select u.EnforcementActionId,
           u.ExecutedDate as MilestoneActualDate,
           'RSAGJ'        as Type,
           newid()        as TransactionID
    from #FormalEaUpdates u
    where u.ActionType = N'AdministrativeOrder'
      and u.ExecutedDate is not null
      and not exists (select 1
                      from NETWORKNODEFLOW.dbo.EnforcementActionMilestone t
                      where t.EnforcementActionId = u.EnforcementActionId
                        and t.Type = 'RSAGJ');

    insert into NETWORKNODEFLOW.dbo.EnforcementActionMilestone
        (EnforcementActionId, MilestoneActualDate, Type, TransactionID)
    select u.EnforcementActionId,
           u.AppealedDate as MilestoneActualDate,
           'CMF'          as Type,
           newid()        as TransactionID
    from #FormalEaUpdates u
    where ActionType = N'AdministrativeOrder'
      and u.AppealedDate is not null
      and not exists (select 1
                      from NETWORKNODEFLOW.dbo.EnforcementActionMilestone t
                      where t.EnforcementActionId = u.EnforcementActionId
                        and t.Type = 'CMF');

    --============================================================================================
    -- Other Pathway Activities

    -- Delete and reinsert "Other Pathway Activities"
    -- Other Pathway Activities are only entered for No Further Action letters.
    -- * Both 'ADDR' and 'RSLV' are added using the date the NFA was sent.
    select CaseFileId, IssueDate, AirWebId
    into #NoFurtherAction
    from etl.VW_ICIS_NoFurtherActionLetters
    where DataExchangeStatus = 'U';

    delete t
    from NETWORKNODEFLOW.dbo.OTHERPATHWAYACTIVITYDATA t
    where exists (select 1
                  from #NoFurtherAction u
                  where u.CaseFileId = t.CASEFILEID);

    insert into NETWORKNODEFLOW.dbo.OTHERPATHWAYACTIVITYDATA
    (OTHERPATHWAYACTIVITYDATAID, CASEFILEID, OTHERPATHWAYCATEGORYCODE, OTHERPATHWAYTYPECODE, OTHERPATHWAYDATE)
    select newid()      as OTHERPATHWAYACTIVITYDATAID,
           u.CaseFileId as CASEFILEID,
           t.Code       as OTHERPATHWAYCATEGORYCODE,
           'NAN'        as OTHERPATHWAYTYPECODE,
           u.IssueDate  as OTHERPATHWAYDATE
    from #NoFurtherAction u
        cross apply (select 'ADDR' as Code union select 'RSLV' as Code) t;

    --============================================================================================
    -- Reset data exchange status indicators

    update u
    set DataExchangeStatus     = 'P',
        DataExchangeStatusDate = sysdatetimeoffset()
    from AirWeb.dbo.EnforcementCaseFiles u
    where exists (select 1
                  from #CaseFileUpdates t
                  where t.AirWebId = u.Id)
       or exists (select 1
                  from #CaseFileToCmUpdates t
                  where t.AirWebId = u.Id);

    update u
    set DataExchangeStatus     = 'P',
        DataExchangeStatusDate = sysdatetimeoffset()
    from AirWeb.dbo.EnforcementActions u
    where exists (select 1
                  from #AllEaUpdates t
                  where t.AirWebId = u.Id)
       or exists (select 1
                  from #NoFurtherAction t
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

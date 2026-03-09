USE AirWeb
GO

CREATE OR ALTER PROCEDURE etl.ICIS_ComplianceMonitoring_Update
AS

/**************************************************************************************************

Author:     Doug Waldron
Overview:   Stage Compliance Monitoring updates for ICIS-Air

Tables written to:
  - NETWORKNODEFLOW.dbo.ComplianceMonitoring
  - NETWORKNODEFLOW.dbo.ComplianceMonitoringCode
  - NETWORKNODEFLOW.dbo.AirStackTestData
  - NETWORKNODEFLOW.dbo.TVACCReviewData

Plus data exchange status reset in:
  - AirWeb.dbo.ComplianceWork
  - AirWeb.dbo.Fces

Modification History:
When        Who                 What
----------  ------------------  -------------------------------------------------------------------
Previously  DWaldron            Initially created in Oracle
2016-12-28  VDhande             Migrated to SQL Server
2018-08-02  DWaldron            Exclude closed air program codes (DX-86)
2019-02-13  DWaldron            Include SIP air program with CM event if no others exist (DX-107)
2026-02-03  DWaldron            Complete rewrite for the new Air Web App (epa-dx #2)
2026-03-09  DWaldron            Fix ACC deviations indicator (epa-dx #92)

***************************************************************************************************/

    SET XACT_ABORT, NOCOUNT ON;
BEGIN TRY
    BEGIN TRANSACTION;

    select ComplianceMonitoringId,
           AirFacilityID,
           InspectionTypeCode,
           ActivityName,
           ComplianceMonitoringDate,
           'DA'         AS MonitoringType,
           GaFacilityId as InspectionUserDefinedField3,
           DbFormatAirsNumber,
           AirWebId
    into #FceUpdates
    from etl.VW_ICIS_ComplianceMonitoring_FCE
    where DataExchangeStatus = 'U';

    select ComplianceMonitoringId,
           AirFacilityID,
           InspectionTypeCode,
           ActivityName,
           ComplianceMonitoringDate,
           'DA'         AS MonitoringType,
           GaFacilityId as InspectionUserDefinedField3,
           DbFormatAirsNumber,
           AirWebId
    into #ComplianceMonitoringUpdates
    from etl.VW_ICIS_ComplianceMonitoring_PCE
    where DataExchangeStatus = 'U';

    select ComplianceMonitoringId,
           AirFacilityID,
           InspectionTypeCode,
           ActivityName,
           ComplianceMonitoringDate,
           'DA'         AS MonitoringType,
           AirPollutantCode,
           GaFacilityId as InspectionUserDefinedField3,
           DbFormatAirsNumber,
           ConductorTypeCode,
           ObservedAgencyTypeCode,
           ReportReceivedDate,
           StackTestStatusCode,
           ResultsReviewedDate,
           AirWebId
    into #StrUpdates
    from etl.VW_ICIS_ComplianceMonitoring_STR
    where DataExchangeStatus = 'U';

    select ComplianceMonitoringId,
           AirFacilityID,
           InspectionTypeCode,
           ActivityName,
           ComplianceMonitoringDate,
           'TVACC'      as MonitoringType,
           GaFacilityId as InspectionUserDefinedField3,
           TVACCReviewedDate,
           case
               when FacilityReportDeviationsIndicator = 1 then 'Y'
               when FacilityReportDeviationsIndicator = 0 then 'N'
               end      as FacilityReportDeviationsIndicator,
           DbFormatAirsNumber,
           AirWebId
    into #AccUpdates
    from etl.VW_ICIS_ComplianceMonitoring_ACC
    where DataExchangeStatus = 'U';

    select ComplianceMonitoringId,
           AirFacilityID,
           InspectionTypeCode,
           ActivityName,
           ComplianceMonitoringDate,
           MonitoringType,
           AirPollutantCode,
           InspectionUserDefinedField3,
           DbFormatAirsNumber,
           AirWebId
    into #AllCmUpdates
    from (select ComplianceMonitoringId,
                 AirFacilityID,
                 InspectionTypeCode,
                 ActivityName,
                 ComplianceMonitoringDate,
                 MonitoringType,
                 AirPollutantCode,
                 InspectionUserDefinedField3,
                 DbFormatAirsNumber,
                 AirWebId
          from #StrUpdates
          union
          select ComplianceMonitoringId,
                 AirFacilityID,
                 InspectionTypeCode,
                 ActivityName,
                 ComplianceMonitoringDate,
                 MonitoringType,
                 null,
                 InspectionUserDefinedField3,
                 DbFormatAirsNumber,
                 AirWebId
          from #AccUpdates
          union
          select ComplianceMonitoringId,
                 AirFacilityID,
                 InspectionTypeCode,
                 ActivityName,
                 ComplianceMonitoringDate,
                 MonitoringType,
                 null,
                 InspectionUserDefinedField3,
                 DbFormatAirsNumber,
                 AirWebId
          from #ComplianceMonitoringUpdates
          union
          select ComplianceMonitoringId,
                 AirFacilityID,
                 InspectionTypeCode,
                 ActivityName,
                 ComplianceMonitoringDate,
                 MonitoringType,
                 null,
                 InspectionUserDefinedField3,
                 DbFormatAirsNumber,
                 AirWebId
          from #FceUpdates) t;

    --============================================================================================
    -- General Compliance Monitoring data

    update t
    set ComplianceMonitoringDate = u.ComplianceMonitoringDate,
        InspectionTypeCode       = u.InspectionTypeCode,
        ActivityName             = u.ActivityName,
        AirPollutantCode         = u.AirPollutantCode
    from NETWORKNODEFLOW.dbo.ComplianceMonitoring t
        inner join #AllCmUpdates u
            on u.ComplianceMonitoringId = t.ComplianceMonitoringId;

    insert into NETWORKNODEFLOW.dbo.ComplianceMonitoring
    (ComplianceMonitoringId, ActivityTypeCode, ComplianceMonitoringDate, InspectionTypeCode, ActivityName,
     AirFacilityID, AirPollutantCode, InspectionUserDefinedField3, LeadAgencyCode, MonitoringType,
     TransactionID)
    select ComplianceMonitoringId,
           'INS'   as ActivityTypeCode,
           ComplianceMonitoringDate,
           InspectionTypeCode,
           ActivityName,
           AirFacilityID,
           AirPollutantCode,
           InspectionUserDefinedField3,
           'STA'   as LeadAgencyCode,
           MonitoringType,
           newid() as TransactionID
    from #AllCmUpdates u
    where not exists (select 1
                      from NETWORKNODEFLOW.dbo.ComplianceMonitoring t
                      where t.ComplianceMonitoringId = u.ComplianceMonitoringId);

    --============================================================================================
    -- Program Codes

    select u.ComplianceMonitoringId,
           u.DbFormatAirsNumber,
           c.ICIS_PROGRAM_CODE as CodeValue
    into #CmPrograms
    from #AllCmUpdates u
        left join AIRBRANCH.dbo.ICIS_PROGRAM_CODES c
            on c.STRAIRSNUMBER = u.DbFormatAirsNumber
            and c.OperatingStatusCode in ('OPR', 'SEA'); -- "Operational" and "Seasonal"

    delete t
    from NETWORKNODEFLOW.dbo.ComplianceMonitoringCode t
    where exists (select 1
                  from #CmPrograms u
                  where u.ComplianceMonitoringId = t.ComplianceMonitoringId
                    and t.CodeName = 'ProgramCode');

    insert into NETWORKNODEFLOW.dbo.ComplianceMonitoringCode (ComplianceMonitoringId, CodeName, CodeValue)
    select u.ComplianceMonitoringId,
           'ProgramCode'                                                   as CodeName,
           iif(c.ICIS_PROGRAM_CODE is null, 'CAASIP', c.ICIS_PROGRAM_CODE) as CodeValue
    from #AllCmUpdates u
        left join AIRBRANCH.dbo.ICIS_PROGRAM_CODES c
            on c.STRAIRSNUMBER = u.DbFormatAirsNumber
            and c.OperatingStatusCode in ('OPR', 'SEA');

    --============================================================================================
    -- Stack Tests

    update t
    set StackTestStatusCode    = u.StackTestStatusCode,
        ConductorTypeCode      = u.ConductorTypeCode,
        ObservedAgencyTypeCode = u.ObservedAgencyTypeCode,
        ReportReceivedDate     = u.ReportReceivedDate,
        ResultsReviewedDate    = u.ResultsReviewedDate
    from NETWORKNODEFLOW.dbo.AirStackTestData t
        inner join #StrUpdates u
            on u.ComplianceMonitoringId = t.ComplianceMonitoringId;

    insert into NETWORKNODEFLOW.dbo.AirStackTestData
    (ComplianceMonitoringId, StackTestStatusCode, ConductorTypeCode, ObservedAgencyTypeCode,
     ReportReceivedDate, ResultsReviewedDate)
    select ComplianceMonitoringId,
           StackTestStatusCode,
           ConductorTypeCode,
           ObservedAgencyTypeCode,
           ReportReceivedDate,
           ResultsReviewedDate
    from #StrUpdates u
    where not exists (select 1
                      from NETWORKNODEFLOW.dbo.AirStackTestData t
                      where t.ComplianceMonitoringId = u.ComplianceMonitoringId);

    --============================================================================================
    -- ACCs

    update t
    set TVACCReviewedDate                 = dateadd(dd, 1, u.TVACCReviewedDate),
        FacilityReportDeviationsIndicator = u.FacilityReportDeviationsIndicator
    from NETWORKNODEFLOW.dbo.TVACCReviewData t
        inner join #AccUpdates u
            on u.ComplianceMonitoringId = t.ComplianceMonitoringId;

    insert into NETWORKNODEFLOW.dbo.TVACCReviewData
    (TVACCReviewedDate, FacilityReportDeviationsIndicator, ReviewerAgencyCode, ComplianceMonitoringId)
    select TVACCReviewedDate as TVACCReviewedDate,
           FacilityReportDeviationsIndicator,
           'STA'             as ReviewerAgencyCode,
           ComplianceMonitoringId
    from #AccUpdates u
    where not exists (select 1
                      from NETWORKNODEFLOW.dbo.TVACCReviewData t
                      where t.ComplianceMonitoringId = u.ComplianceMonitoringId);

    --============================================================================================
    -- Reset data exchange status indicators

    update u
    set DataExchangeStatus     = 'P',
        DataExchangeStatusDate = sysdatetimeoffset()
    from AirWeb.dbo.Fces u
    where exists (select 1
                  from #FceUpdates t
                  where t.AirWebId = u.Id);

    update u
    set DataExchangeStatus     = 'P',
        DataExchangeStatusDate = sysdatetimeoffset()
    from AirWeb.dbo.ComplianceWork u
    where exists (select 1
                  from #ComplianceMonitoringUpdates t
                  where t.AirWebId = u.Id)
       or exists (select 1
                  from #StrUpdates t
                  where t.AirWebId = u.Id)
       or exists (select 1
                  from #AccUpdates t
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

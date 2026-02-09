USE AirWeb
GO

CREATE OR ALTER VIEW etl.VW_ICIS_ComplianceMonitoring_STR
AS

/**************************************************************************************************

Author:     Doug Waldron
Overview:   This view organizes Compliance Monitoring and Stack Test information for use by
            etl.ICIS_ComplianceMonitoring_Update.

Modification History:
When        Who                 What
----------  ------------------  -------------------------------------------------------------------
2026-02-03  DWaldron            Split from etl.VW_ICIS_ComplianceMonitoring (epa-dx#2)

***************************************************************************************************/

select etl.EpaActionId(c.FacilityId, c.ActionNumber)            as ComplianceMonitoringId,
       etl.EpaFacilityId(c.FacilityId)                          as AirFacilityID,
       'CST'                                                   as InspectionTypeCode,
       concat('GA EPD Stack Test Report Review ID ', c.Id)      as ActivityName,
       convert(date, i.DATTESTDATEEND)                          as ComplianceMonitoringDate,
       l.ICIS_POLLUTANT_CODE                                    as AirPollutantCode,
       concat('Facility ID ', c.FacilityId)                     as GaFacilityId,
       iif(i.STRTESTINGFIRM = '00102', 'STE', 'OOR')            as ConductorTypeCode,
       iif(i.STRWITNESSINGENGINEER = 0, null, 'STA')            as ObservedAgencyTypeCode,
       convert(date, i.DATRECEIVEDDATE)                         as ReportReceivedDate,
       case
           when i.STRCOMPLIANCESTATUS = '01' then 'PEN'
           when i.STRCOMPLIANCESTATUS = '02' then 'PSS'
           when i.STRCOMPLIANCESTATUS = '03' then 'PSS'
           when i.STRCOMPLIANCESTATUS = '04' then 'PNA'
           when i.STRCOMPLIANCESTATUS = '05' then 'FAI'
           end                                                  as StackTestStatusCode,
       iif(i.DATCOMPLETEDATE < '1970-01-01', null, convert(date, i.DATCOMPLETEDATE))
                                                                as ResultsReviewedDate,
       AIRBRANCH.iaip_facility.DbFormatAirsNumber(c.FacilityId) as DbFormatAirsNumber,
       c.Id                                                     as AirWebId,
       c.DataExchangeStatus
from dbo.ComplianceWork c
    inner join AIRBRANCH.dbo.ISMPREPORTINFORMATION i
        on i.STRREFERENCENUMBER = c.ReferenceNumber
    left join AIRBRANCH.dbo.LK_ICIS_POLLUTANT l
        on l.LGCY_POLLUTANT_CODE = i.STRPOLLUTANT
where c.IsDeleted = 0
  and c.ActionNumber is not null
  and c.IsClosed = 1
  and c.ComplianceWorkType = N'SourceTestReview'
  and exists (select 1
              from NETWORKNODEFLOW.dbo.AirFacility
              where AirFacilityID = etl.EpaFacilityId(c.FacilityId));

GO

USE AirWeb
GO

CREATE OR ALTER VIEW etl.VW_ICIS_ComplianceMonitoring_ACC
AS

/**************************************************************************************************

Author:     Doug Waldron
Overview:   This view organizes Compliance Monitoring and ACC information for use by
            etl.ICIS_ComplianceMonitoring_Update.

Modification History:
When        Who                 What
----------  ------------------  -------------------------------------------------------------------
2026-02-03  DWaldron            Split from etl.VW_ICIS_ComplianceMonitoring (epa-dx#2)

***************************************************************************************************/

select etl.EpaActionId(c.FacilityId, c.ActionNumber)            as ComplianceMonitoringId,
       etl.EpaFacilityId(c.FacilityId)                          as AirFacilityID,
       'TVA'                                                    as InspectionTypeCode,
       concat('GA EPD Title V ACC Review ID ', c.Id)            as ActivityName,
       c.ClosedDate                                             as ComplianceMonitoringDate,
       concat('Facility ID ', c.FacilityId)                     as GaFacilityId,
       dateadd(dd, 1, c.ClosedDate)                             as TVACCReviewedDate,
       c.ReportsDeviations                                      as FacilityReportDeviationsIndicator,
       AIRBRANCH.iaip_facility.DbFormatAirsNumber(c.FacilityId) as DbFormatAirsNumber,
       c.Id                                                     as AirWebId,
       c.DataExchangeStatus
from dbo.ComplianceWork c
where c.IsDeleted = 0
  and c.ActionNumber is not null
  and c.IsClosed = 1
  and c.ComplianceWorkType = N'AnnualComplianceCertification'
  and exists (select 1
              from NETWORKNODEFLOW.dbo.AirFacility
              where AirFacilityID = etl.EpaFacilityId(c.FacilityId));

GO

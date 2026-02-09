USE AirWeb
GO

CREATE OR ALTER VIEW etl.VW_ICIS_ComplianceMonitoring_FCE
AS

/**************************************************************************************************

Author:     Doug Waldron
Overview:   This view organizes FCE information for use by etl.ICIS_ComplianceMonitoring_Update.

Modification History:
When        Who                 What
----------  ------------------  -------------------------------------------------------------------
2026-02-03  DWaldron            Split from etl.VW_ICIS_ComplianceMonitoring (epa-dx#2)

***************************************************************************************************/

select etl.EpaActionId(f.FacilityId, f.ActionNumber)                      as ComplianceMonitoringId,
       etl.EpaFacilityId(f.FacilityId)                                    as AirFacilityID,
       iif(f.OnsiteInspection = 1, 'FOO', 'FFO')                          as InspectionTypeCode,
       concat('GA EPD Full Compliance Evaluation, O',
              iif(f.OnsiteInspection = 1, 'n', 'ff'), '-Site, ID ', f.Id) as ActivityName,
       f.CompletedDate                                                    as ComplianceMonitoringDate,
       concat('Facility ID ', f.FacilityId)                               as GaFacilityId,
       AIRBRANCH.iaip_facility.DbFormatAirsNumber(f.FacilityId)           as DbFormatAirsNumber,
       f.Id                                                               as AirWebId,
       f.DataExchangeStatus
from dbo.Fces f
where f.IsDeleted = 0
  and f.ActionNumber is not null
  and exists (select 1
              from NETWORKNODEFLOW.dbo.AirFacility
              where AirFacilityID = etl.EpaFacilityId(f.FacilityId));

GO

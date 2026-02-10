USE AirWeb
GO

CREATE OR ALTER VIEW etl.VW_ICIS_ComplianceMonitoring_PCE
AS

/**************************************************************************************************

Author:     Doug Waldron
Overview:   This view organizes Compliance Monitoring information for use by
            etl.ICIS_ComplianceMonitoring_Update.

Modification History:
When        Who                 What
----------  ------------------  -------------------------------------------------------------------
2024-09-17  DWaldron            Reformatted
2026-02-03  DWaldron            Complete rewrite for the new Air Web App (epa-dx#2)

***************************************************************************************************/

select etl.EpaActionId(c.FacilityId, c.ActionNumber)            as ComplianceMonitoringId,
       etl.EpaFacilityId(c.FacilityId)                          as AirFacilityID,
       iif(c.ComplianceWorkType = N'Inspection', 'PCE', 'PFF')  as InspectionTypeCode,
       iif(c.ComplianceWorkType = N'Inspection', concat('GA EPD State Compliance Inspection ID ', c.Id),
           concat('GA EPD Compliance Report Review ID ', c.Id)) as ActivityName,
       iif(c.ComplianceWorkType = N'Inspection', convert(date, c.InspectionEnded),
           c.ReceivedDate)                                      as ComplianceMonitoringDate,
       concat('Facility ID ', c.FacilityId)                     as GaFacilityId,
       AIRBRANCH.iaip_facility.DbFormatAirsNumber(c.FacilityId) as DbFormatAirsNumber,
       c.Id                                                     as AirWebId,
       c.DataExchangeStatus
from dbo.ComplianceWork c
where c.IsDeleted = 0
  and c.ActionNumber is not null
  and c.IsClosed = 1
  and c.ComplianceWorkType in (N'Inspection', N'Report')
  and exists (select 1
              from NETWORKNODEFLOW.dbo.AirFacility
              where AirFacilityID = etl.EpaFacilityId(c.FacilityId));

GO

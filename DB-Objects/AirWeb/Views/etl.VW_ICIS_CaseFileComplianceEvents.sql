USE AirWeb
GO

CREATE OR ALTER VIEW etl.VW_ICIS_CaseFileComplianceEvents
AS

/**************************************************************************************************

Author:     Doug Waldron
Overview:   This view organizes information for Case File Compliance Events for use by the
            etl.ICIS_CaseFile_Update stored procedure.

Modification History:
When        Who                 What
----------  ------------------  -------------------------------------------------------------------
2026-01-29  DWaldron            Initial version (epa-dx#2)
2026-02-27  DWaldron            Only submit "reportable" Compliance Events (air-web#502)
2026-03-16  DWaldron            Rename the Case Files table (epa-dx#95)

***************************************************************************************************/

select etl.EpaActionId(f.FacilityId, f.ActionNumber) as CaseFileId,
       etl.EpaActionId(c.FacilityId, c.ActionNumber) as ComplianceMonitoringId,
       f.Id                                          as AirWebId,
       f.DataExchangeStatus
from dbo.CaseFileComplianceEvents v
    inner join dbo.EnforcementCaseFiles f
        on f.Id = v.CaseFileId
    inner join dbo.ComplianceWork c
        on c.Id = v.CaseFileId
where f.IsDeleted = 0
  and f.ActionNumber is not null
  and c.IsDeleted = 0
  and c.ActionNumber is not null
  and c.IsClosed = 1
  --// Could probably be simplified as `<> N'Inspection'`
  and c.ComplianceWorkType in
      (N'AnnualComplianceCertification', N'Inspection', N'Report', N'SourceTestReview');

GO

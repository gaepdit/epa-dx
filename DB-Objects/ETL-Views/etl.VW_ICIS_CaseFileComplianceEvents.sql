use AirWeb
go

create or alter view etl.VW_ICIS_CaseFileComplianceEvents
as

/**************************************************************************************************

Author:     Doug Waldron
Overview:
  This view organizes information for No Further Action Letters for use by the
  etl.ICIS_CaseFile_Updates stored procedure.

Modification History:
When        Who                 What
----------  ------------------  -------------------------------------------------------------------
2026-01-29  DWaldron            Initial version (epa-dx#2)

***************************************************************************************************/

select etl.EpaActionId(c.FacilityId, c.ActionNumber) as CaseFileId,
       etl.EpaActionId(w.FacilityId, w.ActionNumber) as ComplianceMonitoringId,
       c.Id                                          as AirWebId,
       c.DataExchangeStatus
from dbo.CaseFileComplianceEvents v
    inner join dbo.CaseFiles c
        on c.Id = v.CaseFileId
    inner join dbo.ComplianceWork w
        on w.Id = v.CaseFileId
where c.IsDeleted = 0
  and c.ActionNumber is not null
  and w.IsDeleted = 0
  and w.ActionNumber is not null;

go

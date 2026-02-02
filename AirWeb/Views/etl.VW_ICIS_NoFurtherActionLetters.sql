use AirWeb
go

create or alter view etl.VW_ICIS_NoFurtherActionLetters
as

/**************************************************************************************************

Author:     Doug Waldron
Overview:   This view organizes information for No Further Action Letters for use by the
            etl.ICIS_CaseFile_Update stored procedure.

Modification History:
When        Who                 What
----------  ------------------  -------------------------------------------------------------------
2026-01-29  DWaldron            Initial version (epa-dx#2)

***************************************************************************************************/

select etl.EpaActionId(c.FacilityId, c.ActionNumber) as CaseFileId,
       IssueDate,
       e.Id                                          as AirWebId,
       e.DataExchangeStatus
from dbo.EnforcementActions e
    inner join dbo.CaseFiles c
        on e.CaseFileId = c.Id
where e.IsDeleted = 0
  and c.IsDeleted = 0
  and c.ActionNumber is not null
  and e.ActionType in (N'NovNfaLetter', N'NoFurtherActionLetter')
  and e.IssueDate is not null
  and exists (select 1
              from NETWORKNODEFLOW.dbo.AirFacility t
              where t.AirFacilityID = etl.EpaFacilityId(e.FacilityId));

go

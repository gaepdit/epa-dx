USE AirWeb
GO

CREATE OR ALTER VIEW etl.VW_ICIS_InformalEnforcementAction
AS

/**************************************************************************************************

Author:     Doug Waldron
Overview:   This view organizes information for Informal Enforcement Actions for use by the
            etl.ICIS_CaseFile_Update stored procedure.

Modification History:
When        Who                 What
----------  ------------------  -------------------------------------------------------------------
2024-09-17  DWaldron            Reformatted
2024-09-20  DWaldron            Handle Proposed COs as if they were NOVs (icis-air#85)
2026-01-27  DWaldron            Complete rewrite for the new Air Web App; separates informal and
                                formal EAs (epa-dx#2)
2026-03-16  DWaldron            Rename the Case Files table (epa-dx#95)

***************************************************************************************************/

select etl.EpaActionId(e.FacilityId, e.ActionNumber)          as EnforcementActionId,
       etl.EpaFacilityId(e.FacilityId)                        as AirFacilityId,
       'NOV'                                                  as EnforcementActionTypeCode,
       concat(iif(e.ActionType = N'ProposedConsentOrder', N'Proposed Consent Order', N'Notice of Violation'),
              N', GA EPD Enforcement Case ID ', e.CaseFileId) as EnforcementActionName,
       concat('Facility ID ', e.FacilityId)                   as GaFacilityId,
       e.IssueDate                                            as AchievedDate,
       etl.EpaActionId(c.FacilityId, c.ActionNumber)          as CaseFileId,
       c.AirPrograms,
       c.PollutantIds,
       e.Id                                                   as AirWebId,
       e.DataExchangeStatus
from AirWeb.dbo.EnforcementActions e
    inner join AirWeb.dbo.EnforcementCaseFiles c
        on c.Id = e.CaseFileId
        and c.IsDeleted = 0
where e.IsDeleted = 0
  and e.ActionNumber is not null
  -- ↓ Proposed COs are treated as NOVs in ICIS-Air:
  and e.ActionType in (N'NovNfaLetter', N'NoticeOfViolation', N'ProposedConsentOrder')
  and exists (select 1
              from NETWORKNODEFLOW.dbo.AirFacility t
              where t.AirFacilityID = etl.EpaFacilityId(e.FacilityId));

GO

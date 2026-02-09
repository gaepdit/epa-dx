USE AirWeb
GO

CREATE OR ALTER VIEW etl.VW_ICIS_CaseFile
AS

/**************************************************************************************************

Author:     Doug Waldron
Overview:   This view organizes Case File information for use by the etl.ICIS_CaseFile_Update
            stored procedure.

Modification History:
When        Who                 What
----------  ------------------  -------------------------------------------------------------------
2024-09-17  DWaldron            Reformatted
2026-01-23  DWaldron            Complete rewrite for the new Air Web App (epa-dx#2)

***************************************************************************************************/

select etl.EpaActionId(c.FacilityId, c.ActionNumber) as CaseFileId,
       etl.EpaFacilityId(c.FacilityId)               as AirFacilityId,
       concat('GA EPD Enforcement Case ID ', c.Id)   as CaseFileName,
       iif(exists(select 1
                  from AirWeb.dbo.EnforcementActions e
                  where e.CaseFileId = c.Id
                    and e.IsReportableAction = 1
                    and e.IssueDate is not null
                    and e.IsDeleted = 0), 'N', 'Y')  as SensitiveDataIndicator,
       i.IssueDate                                   as AdvisementMethodDate,
       iif(i.IssueDate is null, null, 'LTR')         as AdvisementMethodTypeCode,
       c.ViolationTypeCode,
       c.DayZero                                     as FrvDeterminationDate,
       iif(v.SeverityCode = 'HPV', c.DayZero, null)  as HpvDayZeroDate,
       concat('Facility ID ', c.FacilityId)          as GaFacilityId,
       c.AirPrograms,
       c.PollutantIds,
       c.Id                                          as AirWebId,
       c.DataExchangeStatus
from AirWeb.dbo.CaseFiles c
    left join AirWeb.dbo.ViolationTypes v
        on v.Code = c.ViolationTypeCode
    left join (select CaseFileId, min(IssueDate) as IssueDate
               from AirWeb.dbo.EnforcementActions
               where ActionType in
                     (N'NoticeOfViolation', N'ProposedConsentOrder', N'NovNfaLetter', N'ConsentOrder')
                 and IsDeleted = 0
               group by CaseFileId) i
        on i.CaseFileId = c.Id
where c.IsDeleted = 0
  and c.ActionNumber is not null
  and exists (select 1
              from NETWORKNODEFLOW.dbo.AirFacility
              where AirFacilityID = etl.EpaFacilityId(c.FacilityId))
  and (exists (select 1
               from AirWeb.dbo.EnforcementActions e
               where e.CaseFileId = c.Id
                 and e.IsDeleted = 0
                 and e.IsReportableAction = 1)
    or exists (select 1
               from NETWORKNODEFLOW.dbo.CaseFile n
               where n.CaseFileId = etl.EpaActionId(c.FacilityId, c.ActionNumber)));

GO

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
2026-03-03  DWaldron            Include the IsReportable column (air-web#502)
2026-03-16  DWaldron            Rename the Case Files table (epa-dx#95)
2026-04-09  DWaldron            Rename the AirProgramCodes column (air-web#537, 1f183b3)
2026-05-06  DWaldron            Update violation type columns (epa-dx#102)
2026-09-04  DWaldron            Filter out Case Files derived from RMP Inspections (epa-dx#108)
2026-09-10  DWaldron            Remove the obsolete `IsReportable` column (epa-dx#108)

***************************************************************************************************/

select distinct etl.EpaActionId(f.FacilityId, f.ActionNumber) as CaseFileId,
                etl.EpaFacilityId(f.FacilityId)               as AirFacilityId,
                concat('GA EPD Enforcement Case ID ', f.Id)   as CaseFileName,
                iif(exists(select 1
                           from AirWeb.dbo.EnforcementActions e
                           where e.CaseFileId = f.Id
                             and e.IsReportableAction = 1
                             and e.IssueDate is not null
                             and e.IsDeleted = 0), 'N', 'Y')  as SensitiveDataIndicator,
                i.IssueDate                                   as AdvisementMethodDate,
                iif(i.IssueDate is null, null, 'LTR')         as AdvisementMethodTypeCode,
                f.ViolationTypeCode,
                f.DayZero                                     as FrvDeterminationDate,
                iif(v.Severity = 'HPV', f.DayZero, null)      as HpvDayZeroDate,
                concat('Facility ID ', f.FacilityId)          as GaFacilityId,
                f.AirProgramCodes                             as AirPrograms,
                f.PollutantIds,
                f.Id                                          as AirWebId,
                f.DataExchangeStatus
from AirWeb.dbo.EnforcementCaseFiles f
    left join AirWeb.dbo.ViolationTypes v
        on v.Code = f.ViolationTypeCode
    left join (select CaseFileId, min(IssueDate) as IssueDate
               from AirWeb.dbo.EnforcementActions
               where ActionType in
                     (N'NoticeOfViolation', N'ProposedConsentOrder', N'NovNfaLetter', N'ConsentOrder')
                 and IsDeleted = 0
               group by CaseFileId) i
        on i.CaseFileId = f.Id
    left join dbo.CaseFileComplianceEvents x
        on x.CaseFileId = f.Id
    left join dbo.ComplianceWork c
        on c.Id = x.ComplianceEventId
where f.IsDeleted = 0
  and f.ActionNumber is not null
  and (c.ComplianceWorkType is null or
       c.ComplianceWorkType <> 'RmpInspection')
  and exists (select 1
              from NETWORKNODEFLOW.dbo.AirFacility
              where AirFacilityID = etl.EpaFacilityId(f.FacilityId))
  and (exists (select 1
               from AirWeb.dbo.EnforcementActions e
               where e.CaseFileId = f.Id
                 and e.IsDeleted = 0
                 and e.IsReportableAction = 1)
    or exists (select 1
               from NETWORKNODEFLOW.dbo.CaseFile n
               where n.CaseFileId = etl.EpaActionId(f.FacilityId, f.ActionNumber)));

GO

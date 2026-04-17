USE AIRBRANCH
GO

CREATE OR ALTER VIEW etl.VW_ICIS_ID_REFERENCE
AS

/**************************************************************************************************

Author:     Doug Waldron
Overview:   Returns a list of all EDT record IDs and associated IAIP/AirWeb IDs

Modification History:
When        Who                 What
----------  ------------------  -------------------------------------------------------------------
2016-10     DWaldron            Initial Version
2019-12-09  DWaldron            Improved performance
2026-01-22  DWaldron            Complete rewrite for the new Air Web App (epa-dx#2)
2026-03-16  DWaldron            Rename the Case Files table (epa-dx#95)
2026-04-17  DWaldron            Use the AIRBRANCH version of etl.EpaFacilityId and etl.EpaActionId
                                to avoid permissions issues (iaip#1464)

***************************************************************************************************/

SELECT etl.EpaFacilityId(fi.STRAIRSNUMBER) AS EDTID,
/* Facility */
       right(fi.STRAIRSNUMBER, 8)                   AS IAIPID,
       'AIRFACILITY'                                AS IDCategory
FROM dbo.APBFACILITYINFORMATION fi
    INNER JOIN dbo.APBHEADERDATA AS hd
        ON hd.STRAIRSNUMBER = fi.STRAIRSNUMBER
where hd.STRAIRPROGRAMCODES NOT LIKE '0000000000000%'

UNION ALL

/* FCE */
select etl.EpaActionId(FacilityId, ActionNumber),
       convert(varchar(8), Id),
       'COMPLIANCEMONITORINGFCE'
from AirWeb.dbo.Fces
where IsDeleted = 0
  and ActionNumber is not null

union all

/* Compliance Monitoring */
select etl.EpaActionId(FacilityId, ActionNumber),
       convert(varchar(8), Id),
       case
           when ComplianceWorkType = 'AnnualComplianceCertification' then 'TVA'
           when ComplianceWorkType = 'Inspection' then 'POR'
           when ComplianceWorkType = 'Report' then 'PFF'
           when ComplianceWorkType = 'SourceTestReview' then 'CST'
           end
from AirWeb.dbo.ComplianceWork
where IsDeleted = 0
  and ComplianceWorkType in ('AnnualComplianceCertification', 'Inspection', 'Report', 'SourceTestReview')
  and ActionNumber is not null

union all

/* Case file */
select etl.EpaActionId(c.FacilityId, c.ActionNumber),
       convert(varchar(8), c.Id),
       'CASEFILE'
from AirWeb.dbo.EnforcementCaseFiles c
    INNER JOIN dbo.APBHEADERDATA AS hd
        ON c.FacilityId = iaip_facility.FormatAirsNumber(hd.STRAIRSNUMBER)
where c.IsDeleted = 0
  and c.ActionNumber is not null
  and hd.STRAIRPROGRAMCODES NOT LIKE '0000000000000%'
  and c.Id in (select e.CaseFileId
               from AirWeb.dbo.EnforcementActions e
               where e.IsDeleted = 0
                 and e.ActionNumber is not null
                 and e.IsReportableAction = 1)

union all

/* NOV */
select etl.EpaActionId(e.FacilityId, e.ActionNumber),
       convert(varchar(8), e.CaseFileId),
       'ENFORCEMENTACTION'
from AirWeb.dbo.EnforcementActions e
    INNER JOIN dbo.APBHEADERDATA AS hd
        ON e.FacilityId = iaip_facility.FormatAirsNumber(hd.STRAIRSNUMBER)
where e.IsDeleted = 0
  and e.ActionNumber is not null
  and ((e.ActionType in ('NoticeOfViolation', 'NovNfaLetter', 'ProposedConsentOrder') and e.IssueDate is not null)
    or (e.ActionType in ('ConsentOrder', 'AdministrativeOrder') and e.ExecutedDate is not null))
  and hd.STRAIRPROGRAMCODES NOT LIKE '0000000000000%'
  and e.CaseFileId in (select c.Id
                       from AirWeb.dbo.EnforcementCaseFiles c
                       where c.IsDeleted = 0
                         and c.ActionNumber is not null)
;

GO

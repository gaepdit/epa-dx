use AirWeb;

-- For older ACCs and Reports, set the review date equal to the closed date.

select ClosedDate   as [IAIP Complete Date],
       ReviewedDate as [Reviewed Date],
       Id           as [ID],
       FacilityId   as [Facility]
from AirWeb.dbo.ComplianceWork c
where ComplianceWorkType in ('AnnualComplianceCertification', 'Report')
  and ReviewedDate is null
  and UpdatedAt < '2026-02-28'
  and IsDeleted = 0
  and c.IsClosed = 1;

update c
set ReviewedDate = ClosedDate
from AirWeb.dbo.ComplianceWork c
where ComplianceWorkType in ('AnnualComplianceCertification', 'Report')
  and ReviewedDate is null
  and UpdatedAt < '2026-02-28'
  and IsDeleted = 0
  and c.IsClosed = 1;

-- For newer ACCs and Reports, set the review date equal to the date added and update the data exchange.

select ClosedDate                 as [Closed Date],
       convert(date, c.CreatedAt) as [Date Added],
       ReviewedDate               as [Reviewed Date],
       Id                         as [ID],
       FacilityId                 as [Facility]
from AirWeb.dbo.ComplianceWork c
where ComplianceWorkType in ('AnnualComplianceCertification', 'Report')
  and ReviewedDate is null
  and UpdatedAt >= '2026-02-28'
  and IsDeleted = 0
  and c.IsClosed = 1;

update c
set ReviewedDate       = convert(date, c.CreatedAt),
    DataExchangeStatus = 'U'
from AirWeb.dbo.ComplianceWork c
where ComplianceWorkType in ('AnnualComplianceCertification', 'Report')
  and ReviewedDate is null
  and UpdatedAt >= '2026-02-28'
  and IsDeleted = 0
  and c.IsClosed = 1;

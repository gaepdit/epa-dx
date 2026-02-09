--/* Count unprocessed updates

SELECT 'APBSUPPLAMENTALDATA' as Data, SUM(IIF(ICIS_STATUSIND <> 'P', 1, 0)) AS Unprocessed, COUNT(*) AS Total FROM AIRBRANCH.dbo.APBSUPPLAMENTALDATA
union
SELECT 'APBFACILITYINFORMATION' as Data, SUM(IIF(ICIS_STATUSIND <> 'P', 1, 0)) AS Unprocessed, COUNT(*) AS Total FROM AIRBRANCH.dbo.APBFACILITYINFORMATION
union
SELECT 'APBHEADERDATA' as Data, SUM(IIF(ICIS_STATUSIND <> 'P', 1, 0)) AS Unprocessed, COUNT(*) AS Total FROM AIRBRANCH.dbo.APBHEADERDATA
union
select 'Fces' as Data, sum(iif(DataExchangeStatus = 'U', 1, 0)) as Unprocessed, count(*) as Total from AirWeb.dbo.Fces where IsDeleted = 0 and ActionNumber is not null
union
select 'ComplianceWork' as Data, sum(iif(DataExchangeStatus = 'U', 1, 0)) as Unprocessed, count(*) as Total from AirWeb.dbo.ComplianceWork where IsDeleted = 0 and ActionNumber is not null
union
select 'EnforcementActions' as Data, sum(iif(DataExchangeStatus = 'U', 1, 0)) as Unprocessed, count(*) as Total from AirWeb.dbo.EnforcementActions where IsDeleted = 0 and ActionNumber is not null
union
select 'CaseFiles' as Data, sum(iif(DataExchangeStatus = 'U', 1, 0)) as Unprocessed, count(*) as Total from AirWeb.dbo.CaseFiles where IsDeleted = 0 and ActionNumber is not null

;
--*/
--/* Count unprocessed deletions

SELECT 'ICIS_DELETE' as Data, SUM(IIF(ICIS_STATUSIND <> 'P', 1, 0)) AS Unprocessed, COUNT(*) AS Total FROM AIRBRANCH.dbo.ICIS_DELETE
union
select 'Fces' as Data, sum(iif(DataExchangeStatus = 'D', 1, 0)) as Unprocessed, count(*) as Total from AirWeb.dbo.Fces where ActionNumber is not null
union
select 'ComplianceWork' as Data, sum(iif(DataExchangeStatus = 'D', 1, 0)) as Unprocessed, count(*) as Total from AirWeb.dbo.ComplianceWork where ActionNumber is not null
union
select 'EnforcementActions' as Data, sum(iif(DataExchangeStatus = 'D', 1, 0)) as Unprocessed, count(*) as Total from AirWeb.dbo.EnforcementActions where ActionNumber is not null
union
select 'CaseFiles' as Data, sum(iif(DataExchangeStatus = 'D', 1, 0)) as Unprocessed, count(*) as Total from AirWeb.dbo.CaseFiles where ActionNumber is not null
;
--*/
--/* Count staged records

USE NETWORKNODEFLOW
GO

SELECT COUNT(*) as [Unprocessed Submissions]
FROM   dbo.SubmissionStatus
WHERE  Status IS NULL;

begin
    CREATE TABLE #counts
    (
        table_name varchar(255),
        row_count  int
    );

    EXEC sys.sp_MSforeachtable
         @command1 = 'INSERT #counts (table_name, row_count) SELECT ''?'', COUNT(*) FROM ?';

    SELECT table_name
         , row_count
    FROM #counts
    WHERE table_name NOT LIKE '%CERS_%'
    ORDER BY table_name
           , row_count DESC;

    DROP TABLE #counts;
end

--*/

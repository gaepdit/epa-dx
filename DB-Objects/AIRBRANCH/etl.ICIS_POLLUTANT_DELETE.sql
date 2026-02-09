USE airbranch;
GO

CREATE OR ALTER PROCEDURE etl.ICIS_POLLUTANT_DELETE
AS

/**************************************************************************************************

Author:     Vidyanand Dhande
Overview:   Processes Air pollutant deletions for ICIS-Air 
   
  * This procedure takes each deleted air pollutant from the
  * AIRBRANCH schema and deletes the associated values from the AIRICIS tables.

Tables written to:
  NETWORKNODEFLOW.dbo.AIRPOLLUTANTS
  airbranch.dbo.ICIS_DELETE

Modification History:
When        Who                 What
----------  ------------------  -------------------------------------------------------------------
Previously  DWaldron            Initially created in Oracle
2016-06-29  VDhande             Migrated to SQL Server
2017-10-19  DWaldron            Bugfix: Pollutants not deleted from staging tables (DX-54)

  ***************************************************************************************************/

    SET XACT_ABORT, NOCOUNT ON;
BEGIN TRY

    BEGIN TRANSACTION;

    SELECT ad.ID                    AS ID,
           ad.DATAFAMILY            AS DATAFAMILY,
           SUBSTRING(ad.ID, 1, 18)  AS AIRFACILITYID,
           SUBSTRING(ad.ID, 20, 15) AS AIRPOLLUTANTSCODE
    INTO #ICIS_POLLUTANT_DELETE
    FROM AIRBRANCH.dbo.ICIS_DELETE AS ad
    WHERE ad.ICIS_STATUSIND <> 'P'
      AND ad.DATAFAMILY = 'AIRPOLLUTANT';

    DELETE t
    FROM NETWORKNODEFLOW.dbo.AIRPOLLUTANTS t
        INNER JOIN #ICIS_POLLUTANT_DELETE i
            ON t.AIRFACILITYID = i.AIRFACILITYID
            AND t.AIRPOLLUTANTSCODE = i.AIRPOLLUTANTSCODE;

    UPDATE ad
    SET ad.ICIS_STATUSIND   = 'P',
        ad.ICIS_PROCESSDATE = GETDATE()
    FROM airbranch.dbo.ICIS_DELETE ad
        INNER JOIN #ICIS_POLLUTANT_DELETE i
            ON ad.ID = i.ID
            AND ad.DATAFAMILY = i.DATAFAMILY;

    COMMIT TRANSACTION;

    RETURN 0;
END TRY
BEGIN CATCH
    IF @@trancount > 0
        ROLLBACK TRANSACTION;
    DECLARE
        @ErrorMessage nvarchar(4000) = ERROR_MESSAGE(),
        @ErrorSeverity int = ERROR_SEVERITY();
    RAISERROR (@ErrorMessage, @ErrorSeverity, 1);
    RETURN -1;
END CATCH
GO

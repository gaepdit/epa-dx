USE airbranch;
GO

CREATE OR ALTER PROCEDURE etl.ICIS_CMS_DELETE
AS

/**************************************************************************************************

Author:     Vidyanand Dhande
Overview:   Processes CMS deletions for ICIS-Air 
   
  * This procedure takes each deleted CMS from the AIRBRANCH schema and
  * deletes the associated values from the AIRICIS tables.

Tables written to:
  NETWORKNODEFLOW.dbo.COMPLIANCEMONITORINGSTRATEGY 
  airbranch.dbo.ICIS_DELETE 

Modification History:
When        Who                 What
----------  ------------------  -------------------------------------------------------------------
Previously  DWaldron            Initially created in Oracle
2016-06-28  VDhande             Migrated to SQL Server

***************************************************************************************************/

    SET XACT_ABORT, NOCOUNT ON;
BEGIN TRY

    BEGIN TRANSACTION;

    SELECT ad.ID         AS ID,
           ad.DATAFAMILY AS DATAFAMILY,
           ad.ID         AS AIRFACILITYID
    INTO #ICIS_CMS_DELETE
    FROM AIRBRANCH.dbo.ICIS_DELETE AS ad
    WHERE ad.ICIS_STATUSIND <> 'P'
      AND ad.DATAFAMILY = 'COMPLIANCEMONITORINGSTRATEGY';

    DELETE t
    FROM NETWORKNODEFLOW.dbo.AirComplianceMonitoringStrategy t
        INNER JOIN #ICIS_CMS_DELETE i
            ON t.AIRFACILITYID = i.AIRFACILITYID;

    UPDATE ad
    SET ad.ICIS_STATUSIND   = 'P',
        ad.ICIS_PROCESSDATE = GETDATE()
    FROM airbranch.dbo.ICIS_DELETE ad
        INNER JOIN #ICIS_CMS_DELETE i
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

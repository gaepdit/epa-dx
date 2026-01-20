USE airbranch;
GO
SET ANSI_NULLS ON;
GO

CREATE OR ALTER PROCEDURE etl.ICIS_CM_DELETE
AS

/**************************************************************************************************

Author:     Vidyanand Dhande
Overview:   Processes Compliance monitoring item deletions for ICIS-Air

  * This procedure takes each deleted compliance monitoring item from the
  * AIRBRANCH schema and deletes the associated values from the AIRICIS tables.

Tables written to:
  NETWORKNODEFLOW.dbo.CASEFILE2CMLINK
  NETWORKNODEFLOW.dbo.COMPLIANCEMONITORING
  AIRBRANCH.dbo.ICIS_DELETE

Tables accessed:
  AIRBRANCH.dbo.ICIS_DELETE

Modification History:
When        Who                 What
----------  ------------------  -------------------------------------------------------------------
Previously  DWaldron            Initially created in Oracle
2016-06-28  VDhande             Migrated to SQL Server

***************************************************************************************************/

     SET XACT_ABORT, NOCOUNT ON;
    BEGIN TRY

        BEGIN TRANSACTION;

        SELECT ad.ID AS         ID
             , ad.DATAFAMILY AS DATAFAMILY
             , ad.ID AS         ComplianceMonitoringId
        INTO #ICIS_CM_DELETE
        FROM   AIRBRANCH.dbo.ICIS_DELETE AS ad
        WHERE  ad.ICIS_STATUSIND <> 'P'
               AND ad.DATAFAMILY = 'COMPLIANCEMONITORING';

        DELETE t
        FROM NETWORKNODEFLOW.dbo.CASEFILE2CMLINK t
        INNER JOIN #ICIS_CM_DELETE i
          ON t.COMPLIANCEMONITORINGID = i.ComplianceMonitoringId;

        DELETE t
        FROM NETWORKNODEFLOW.dbo.COMPLIANCEMONITORING t
        INNER JOIN #ICIS_CM_DELETE i
          ON t.COMPLIANCEMONITORINGID = i.ComplianceMonitoringId;

        UPDATE ad
           SET
               ad.ICIS_STATUSIND = 'P'
             , ad.ICIS_PROCESSDATE = GETDATE()
        FROM AIRBRANCH.dbo.ICIS_DELETE ad
        INNER JOIN #ICIS_CM_DELETE i
          ON ad.ID = i.ID
             AND ad.DATAFAMILY = i.DATAFAMILY;

        DROP TABLE #ICIS_CM_DELETE;

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

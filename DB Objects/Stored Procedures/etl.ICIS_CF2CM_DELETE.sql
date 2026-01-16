USE airbranch;
GO

CREATE OR ALTER PROCEDURE etl.ICIS_CF2CM_DELETE
AS

/**************************************************************************************************

Author:     Vidyanand Dhande
Overview:   Processes Case File to Compliance Monitoring Linkage deletions for ICIS-Air
   
  * This procedure takes each deleted CF2CM Linkage from the
  * AIRBRANCH schema and deletes the associated values from the AIRICIS tables.

Tables written to:
  NETWORKNODEFLOW.dbo.CASEFILE2CMLINK 
  AIRBRANCH.dbo.ICIS_DELETE 

Modification History:
When        Who                 What
----------  ------------------  -------------------------------------------------------------------
Previously  DWaldron            Initially created in Oracle
2016-06-28  VDhande             Migrated to SQL Server
2017-11-02  DWaldron            Bugfix (IAIP-442)

***************************************************************************************************/

    SET XACT_ABORT, NOCOUNT ON;
BEGIN TRY

    BEGIN TRANSACTION;

    SELECT ad.ID                    AS ID,
           ad.DATAFAMILY            AS DATAFAMILY,
           SUBSTRING(ad.ID, 1, 25)  AS CASEFILEID,
           SUBSTRING(ad.ID, 27, 25) AS COMPLIANCEMONITORINGID
    INTO #ICIS_CF2CM_DELETE
    FROM AIRBRANCH.dbo.ICIS_DELETE AS ad
    WHERE ad.ICIS_STATUSIND <> 'P'
      AND ad.DATAFAMILY = 'CF2CMLINKAGE';

    DELETE t
    FROM NETWORKNODEFLOW.dbo.CASEFILE2CMLINK t
        INNER JOIN #ICIS_CF2CM_DELETE i
            ON t.CASEFILEID = i.CASEFILEID
            AND t.COMPLIANCEMONITORINGID = i.COMPLIANCEMONITORINGID;

    UPDATE ad
    SET ad.ICIS_STATUSIND   = 'P',
        ad.ICIS_PROCESSDATE = GETDATE()
    FROM AIRBRANCH.dbo.ICIS_DELETE ad
        INNER JOIN #ICIS_CF2CM_DELETE i
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

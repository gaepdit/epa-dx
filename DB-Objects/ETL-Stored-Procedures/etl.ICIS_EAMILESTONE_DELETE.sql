USE airbranch;
GO
SET ANSI_NULLS ON;
GO

CREATE OR ALTER PROCEDURE etl.ICIS_EAMILESTONE_DELETE
AS

/**************************************************************************************************

Author:     Vidyanand Dhande
Overview:   Processes EA Milestone deletions for ICIS-Air 
   
  * This procedure takes each deleted EA milestone from the
  * AIRBRANCH schema and deletes the associated values from the AIRICIS tables.

Tables written to:
  NETWORKNODEFLOW.dbo.EAMILESTONE 
  AIRBRANCH.dbo.ICIS_DELETE 

Tables accessed:
  AIRBRANCH.dbo.ICIS_DELETE 

Modification History:
When        Who                 What
----------  ------------------  -------------------------------------------------------------------
Previously  DWaldron            Initially created in Oracle
2016-06-29  VDhande             Migrated to SQL Server

***************************************************************************************************/

     SET XACT_ABORT, NOCOUNT ON;
    BEGIN TRY

        BEGIN TRANSACTION;

        SELECT ad.ID AS                    ID
             , ad.DATAFAMILY AS            DATAFAMILY
             , SUBSTRING(ad.ID, 1, 25) AS  ENFORCEMENTACTIONID
             , SUBSTRING(ad.ID, 27, 15) AS TYPE
        INTO #ICIS_EAMILESTONE_DELETE
        FROM   AIRBRANCH.dbo.ICIS_DELETE AS ad
        WHERE  ad.ICIS_STATUSIND <> 'P'
               AND ad.DATAFAMILY = 'EAMILESTONE';

        UPDATE t
           SET
               t.MilestoneActualDate = NULL
        FROM NETWORKNODEFLOW.dbo.EnforcementActionMilestone t
        INNER JOIN #ICIS_EAMILESTONE_DELETE i
          ON t.EnforcementActionId = i.ENFORCEMENTACTIONID
             AND t.Type = i.TYPE;

        UPDATE ad
           SET
               ad.ICIS_STATUSIND = 'P'
             , ad.ICIS_PROCESSDATE = GETDATE()
        FROM AIRBRANCH.dbo.ICIS_DELETE ad
        INNER JOIN #ICIS_EAMILESTONE_DELETE i
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

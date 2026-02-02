USE airbranch;
GO
SET ANSI_NULLS ON;
GO

CREATE OR ALTER PROCEDURE etl.ICIS_CASEFILE_DELETE
AS

/**************************************************************************************************

Author:     Vidyanand Dhande
Overview:   Processes Case file / enforcement deletions for ICIS-Air 
   
  * This procedure takes each deleted case file or enforcement action from the
  * AIRBRANCH schema and deletes the associated values from the AIRICIS tables.

Tables written to:
    NETWORKNODEFLOW.dbo.EAMILESTONE
    NETWORKNODEFLOW.dbo.CASEFILE2DAEALINK
    NETWORKNODEFLOW.dbo.ENFORCEMENTACTION
    NETWORKNODEFLOW.dbo.CASEFILE
    NETWORKNODEFLOW.dbo.CASEFILE2CMLINK 
    NETWORKNODEFLOW.dbo.CASEFILE2DAEALINK
    AIRBRANCH.dbo.ICIS_DELETE
  
Tables accessed:
  airbranch.dbo.ICIS_DELETE 

Modification History:
When        Who                 What
----------  ------------------  -------------------------------------------------------------------
Previously  DWaldron            Initially created in Oracle
2016-06-28  VDhande             Migrated to SQL Server
2024-09-17  DWaldron            Reformatted

***************************************************************************************************/

    SET XACT_ABORT, NOCOUNT ON;
BEGIN TRY

    BEGIN TRANSACTION;

    -- Find all deleted enforcement actions
    SELECT ad.ID         AS ID,
           ad.DATAFAMILY AS DATAFAMILY,
           ad.ID         AS ENFORCEMENTACTIONID
    INTO #EA_Delete
    FROM airbranch.dbo.ICIS_DELETE AS ad
    WHERE ad.ICIS_STATUSIND <> 'P'
      AND ad.DATAFAMILY = 'ENFORCEMENTACTION';

    DELETE t
    FROM NETWORKNODEFLOW.dbo.EnforcementActionMilestone t
        INNER JOIN #EA_Delete i
        ON t.EnforcementActionId = i.ENFORCEMENTACTIONID;

    DELETE t
    FROM NETWORKNODEFLOW.dbo.CASEFILE2DAEALINK t
        INNER JOIN #EA_Delete i
        ON t.ENFORCEMENTACTIONID = i.ENFORCEMENTACTIONID;

    DELETE t
    FROM NETWORKNODEFLOW.dbo.ENFORCEMENTACTION t
        INNER JOIN #EA_Delete i
        ON t.ENFORCEMENTACTIONID = i.ENFORCEMENTACTIONID;

    UPDATE ad
    SET ad.ICIS_STATUSIND   = 'P',
        ad.ICIS_PROCESSDATE = GETDATE()
    FROM AIRBRANCH.dbo.ICIS_DELETE ad
        INNER JOIN #EA_Delete i
        ON ad.ID = i.ID
            AND ad.DATAFAMILY = i.DATAFAMILY;

    DROP TABLE #EA_Delete;

    -- Find all deleted case files
    SELECT ad.ID         AS ID,
           ad.DATAFAMILY AS DATAFAMILY,
           ad.ID         AS CASEFILEID
    INTO #Case_File_Delete
    FROM airbranch.dbo.ICIS_DELETE AS ad
    WHERE ad.ICIS_STATUSIND <> 'P'
      AND ad.DATAFAMILY = 'CASEFILE';

    DELETE t
    FROM NETWORKNODEFLOW.dbo.CASEFILE t
        INNER JOIN #Case_File_Delete i
        ON t.CaseFileId = i.CASEFILEID;

    DELETE t
    FROM NETWORKNODEFLOW.dbo.CASEFILE2CMLINK t
        INNER JOIN #Case_File_Delete i
        ON t.CASEFILEID = i.CASEFILEID;

    DELETE t
    FROM NETWORKNODEFLOW.dbo.CASEFILE2DAEALINK t
        INNER JOIN #Case_File_Delete i
        ON t.CASEFILEID = i.CASEFILEID;

    UPDATE ad
    SET ad.ICIS_STATUSIND   = 'P',
        ad.ICIS_PROCESSDATE = GETDATE()
    FROM AIRBRANCH.dbo.ICIS_DELETE ad
        INNER JOIN #Case_File_Delete i
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

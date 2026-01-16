USE airbranch;
GO

CREATE OR ALTER PROCEDURE etl.ICIS_CMS_UPDATE
AS

/**************************************************************************************************

Author:     Vidyanand Dhande
Overview:   Compliance Monitoring family updates

  * Compliance Monitoring family updates
  * Created February/March 2015
  *
  * This procedure will capture any changes for CMS data family and add them to
  * the AIRICIS staging tables

Tables written to:
  NETWORKNODEFLOW.dbo.AirComplianceMonitoringStrategy

Modification History:
When        Who                 What
----------  ------------------  -------------------------------------------------------------------
Previously  DWaldron        Initially created in Oracle
2016-12-28  VDhande         Migrated to SQL Server
2020-01-24  DWaldron        Submit CMS Start Date with CMS changes (DX-115)

***************************************************************************************************/

    SET XACT_ABORT, NOCOUNT ON;
BEGIN TRY

    BEGIN TRANSACTION;

    -- Find all modified CMS
    SELECT CONCAT('GA000000', SUBSTRING(t.STRAIRSNUMBER, 3, 10)) AS AIRFACILITYID,
           t.STRAIRSNUMBER,
           t.ICIS_CMS_CTG_CODE,
           t.ICIS_CMS_FREQ
    INTO #Modified_CMS
    FROM AIRBRANCH.dbo.APBSUPPLAMENTALDATA AS t
        INNER JOIN NETWORKNODEFLOW.dbo.AIRFACILITY AS af
            ON af.AIRFACILITYID = CONCAT('GA000000', SUBSTRING(t.STRAIRSNUMBER, 3, 10))
    WHERE t.ICIS_CMS_CTG_CODE IS NOT NULL
      AND t.ICIS_STATUSIND <> 'P'
      AND AIRFACILITYID IN
          (SELECT AIRFACILITYID
           FROM NETWORKNODEFLOW.dbo.AirComplianceMonitoringStrategy);

    UPDATE cms
    SET cms.AirCMSSourceCategoryCode = i.ICIS_CMS_CTG_CODE,
        cms.AirCMSMinimumFrequency   = i.ICIS_CMS_FREQ,
        cms.AirCMSStartDate          = getdate()
    FROM NETWORKNODEFLOW.dbo.AirComplianceMonitoringStrategy cms
        INNER JOIN #Modified_CMS AS i
            ON cms.AirFacilityId = i.AIRFACILITYID;

    -- Reset the status indicator to 'P' for "Processed"
    UPDATE A
    SET ICIS_STATUSIND = 'P'
    FROM AIRBRANCH.dbo.APBSUPPLAMENTALDATA A
        INNER JOIN #Modified_CMS AS i
            ON A.STRAIRSNUMBER = i.STRAIRSNUMBER;

    DROP TABLE #Modified_CMS;

    -- Find all new CMS
    SELECT CONCAT('GA000000', SUBSTRING(t.STRAIRSNUMBER, 3, 10)) AS AIRFACILITYID,
           t.STRAIRSNUMBER,
           t.ICIS_CMS_CTG_CODE,
           t.ICIS_CMS_FREQ
    INTO #New_CMS
    FROM AIRBRANCH.dbo.APBSUPPLAMENTALDATA AS t
        INNER JOIN NETWORKNODEFLOW.dbo.AIRFACILITY AS af
            ON af.AIRFACILITYID = CONCAT('GA000000', SUBSTRING(t.STRAIRSNUMBER, 3, 10))
    WHERE t.ICIS_CMS_CTG_CODE IS NOT NULL
      AND t.ICIS_STATUSIND <> 'P'
      AND AIRFACILITYID NOT IN
          (SELECT AirFacilityId
           FROM NETWORKNODEFLOW.dbo.AirComplianceMonitoringStrategy);

    INSERT INTO NETWORKNODEFLOW.dbo.AirComplianceMonitoringStrategy
    (AirFacilityId, AirCMSSourceCategoryCode, AirCMSMinimumFrequency, AirCMSStartDate, TransactionID)
    SELECT AIRFACILITYID,
           ICIS_CMS_CTG_CODE,
           ICIS_CMS_FREQ,
           getdate(),
           NEWID()
    FROM #New_CMS;

    -- Reset the status indicator to 'P' for "Processed"
    UPDATE A
    SET ICIS_STATUSIND = 'P'
    FROM AIRBRANCH.dbo.APBSUPPLAMENTALDATA AS A
        INNER JOIN #New_CMS AS i
            ON A.STRAIRSNUMBER = i.STRAIRSNUMBER;

    DROP TABLE #New_CMS;

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

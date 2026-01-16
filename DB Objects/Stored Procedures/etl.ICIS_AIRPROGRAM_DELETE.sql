USE airbranch;
GO

CREATE OR ALTER PROCEDURE etl.ICIS_AIRPROGRAM_DELETE
AS

/**************************************************************************************************

Author:     Vidyanand Dhande
Overview:   Processes Air program deletions for ICIS-Air 
   
This procedure takes each deleted air program from the airbranch database 
and deletes the associated values from the ICIS-Air staging tables.

Tables written to:
  NETWORKNODEFLOW.dbo.AIRPROGRAMSUBPART
  NETWORKNODEFLOW.dbo.AIRPROGRAMS
  AIRBRANCH.dbo.ICIS_DELETE
  
Tables accessed:
  AIRBRANCH.dbo.ICIS_DELETE

Modification History:
When        Who                 What
----------  ------------------  -------------------------------------------------------------------
Previously  DWaldron            Initially created in Oracle
2016-06-28  VDhande             Migrated to SQL Server
2017-10-25  DWaldron            Correctly delete area source air programs (DX-55)
2018-08-15  DWaldron            Fix bug in program subpart deletion (DX-91)

***************************************************************************************************/

    SET XACT_ABORT, NOCOUNT ON;
BEGIN TRY

    BEGIN TRANSACTION;

    -- DATAFAMILY - 'AIRPROGRAMSUBPART'
    -- Find all deleted air program subparts and delete associate values in ICIS tables
    SELECT ad.ID                    AS ID,
           ad.DATAFAMILY            AS DATAFAMILY,
           SUBSTRING(ad.ID, 20, 20) AS AIRPROGRAMSUBPARTCODE,
           p.AirProgramID
    INTO #ICIS_SUBPART_DELETE
    FROM AIRBRANCH.dbo.ICIS_DELETE AS ad
        INNER JOIN NETWORKNODEFLOW.dbo.AirPrograms AS p
            ON p.AirFacilityID = SUBSTRING(ad.ID, 1, 18)
            AND p.AirProgramCode = SUBSTRING(ad.ID, 20, 7)
    WHERE ad.ICIS_STATUSIND <> 'P'
      AND ad.DATAFAMILY = 'AIRPROGRAMSUBPART';

    DELETE s
    FROM NETWORKNODEFLOW.dbo.AirProgramSubpart AS s
        INNER JOIN #ICIS_SUBPART_DELETE d
            ON d.AirProgramID = s.AirProgramID
            AND d.AIRPROGRAMSUBPARTCODE = s.AirProgramSubpartCode;

    UPDATE ad
    SET ad.ICIS_STATUSIND   = 'P',
        ad.ICIS_PROCESSDATE = GETDATE()
    FROM AIRBRANCH.dbo.ICIS_DELETE ad
        INNER JOIN #ICIS_SUBPART_DELETE i
            ON ad.ID = i.ID
            AND ad.DATAFAMILY = i.DATAFAMILY;

    DROP TABLE #ICIS_SUBPART_DELETE;

    -- DATAFAMILY 'AIRPROGRAMS'
    SELECT ad.ID                    AS ID,
           ad.DATAFAMILY            AS DATAFAMILY,
           SUBSTRING(ad.ID, 1, 18)  AS AIRFACILITYID,
           SUBSTRING(ad.ID, 20, 15) AS AIRPROGRAMCODE
    INTO #ICIS_PROGRAM_DELETE
    FROM AIRBRANCH.dbo.ICIS_DELETE AS ad
    WHERE ad.ICIS_STATUSIND <> 'P'
      AND ad.DATAFAMILY = 'AIRPROGRAMS';

    DELETE t
    FROM NETWORKNODEFLOW.dbo.AirPrograms t
        INNER JOIN #ICIS_PROGRAM_DELETE i
            ON t.AirFacilityID = i.AIRFACILITYID
            AND i.AIRPROGRAMCODE = CASE
                                       WHEN t.AirProgramCode IN ('CAANSPS', 'CAANSPSM')
                                           THEN 'CAANSPS'
                                       WHEN t.AirProgramCode IN ('CAAMACT', 'CAAGACTM')
                                           THEN 'CAAMACT'
                                       ELSE t.AirProgramCode
                END;

    UPDATE ad
    SET ad.ICIS_STATUSIND   = 'P',
        ad.ICIS_PROCESSDATE = GETDATE()
    FROM AIRBRANCH.dbo.ICIS_DELETE ad
        INNER JOIN #ICIS_PROGRAM_DELETE i
            ON ad.ID = i.ID
            AND ad.DATAFAMILY = i.DATAFAMILY;

    DROP TABLE #ICIS_PROGRAM_DELETE;

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

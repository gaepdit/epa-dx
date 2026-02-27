USE AIRBRANCH
GO

CREATE OR ALTER PROCEDURE etl.ICIS_FACILITY_DELETE
AS

/**************************************************************************************************

Author:     Vidyanand Dhande
Overview:   Processes Facility deletions for ICIS-Air 
   
  * This procedure takes each deleted facility from the AIRBRANCH schema and
  * deletes the associated values from the AIRICIS tables. 

Tables written to:
    NETWORKNODEFLOW.dbo.PORTABLESOURCE 
    NETWORKNODEFLOW.dbo.NAICS 
    NETWORKNODEFLOW.dbo.SIC 
    NETWORKNODEFLOW.dbo.GEOGRAPHICCOORDINATE
    NETWORKNODEFLOW.dbo.AIRFACILITY 
    AIRBRANCH.dbo.ICIS_DELETE 
  
Tables accessed:
    airbranch.dbo.ICIS_DELETE 
    NETWORKNODEFLOW.dbo.AIRGEOGRAPHICCOORDINATE

Modification History:
When        Who                 What
----------  ------------------  -------------------------------------------------------------------
Previously  DWaldron            Initially created in Oracle
2016-06-29  VDhande             Migrated to SQL Server
2017-04-28  DWaldron            Fix bugs from foreign key contraints

***************************************************************************************************/

    SET XACT_ABORT, NOCOUNT ON;
BEGIN TRY

    BEGIN TRANSACTION;

    SELECT ad.ID         AS ID,
           ad.DATAFAMILY AS DATAFAMILY,
           ad.ID         AS AIRFACILITYID
    INTO #ICIS_FACILITY_DELETE
    FROM airbranch.dbo.ICIS_DELETE AS ad
    WHERE ad.ICIS_STATUSIND <> 'P'
      AND ad.DATAFAMILY = 'FACILITY';

    DELETE t
    FROM NETWORKNODEFLOW.dbo.PORTABLESOURCE t
        INNER JOIN #ICIS_FACILITY_DELETE i
            ON t.AIRFACILITYID = i.AIRFACILITYID;

    DELETE t
    FROM NETWORKNODEFLOW.dbo.NAICS t
        INNER JOIN #ICIS_FACILITY_DELETE i
            ON t.AIRFACILITYID = i.AIRFACILITYID;

    DELETE t
    FROM NETWORKNODEFLOW.dbo.SIC t
        INNER JOIN #ICIS_FACILITY_DELETE i
            ON t.AIRFACILITYID = i.AIRFACILITYID;

    SELECT t.GeographicCoordinateID,
           t.GaAirFacilityID
    INTO #AirGeographicCoordinate_DELETE
    FROM NETWORKNODEFLOW.dbo.GeographicCoordinate AS t
        INNER JOIN NETWORKNODEFLOW.dbo.AirGeographicCoordinate AS a
            ON a.GeographicCoordinateID = t.GeographicCoordinateID
        INNER JOIN #ICIS_FACILITY_DELETE AS i
            ON a.AirFacilityID = i.AIRFACILITYID;

    DELETE t
    FROM NETWORKNODEFLOW.dbo.AirGeographicCoordinate t
        INNER JOIN #AirGeographicCoordinate_DELETE AS i
            ON t.AirFacilityID = i.GaAirFacilityID
            AND t.GeographicCoordinateID = i.GeographicCoordinateID;

    DELETE t
    FROM NETWORKNODEFLOW.dbo.GeographicCoordinate t
        INNER JOIN #AirGeographicCoordinate_DELETE AS i
            ON t.GaAirFacilityID = i.GaAirFacilityID
            AND t.GeographicCoordinateID = i.GeographicCoordinateID;

    DROP TABLE #AirGeographicCoordinate_DELETE;

    DELETE t
    FROM NETWORKNODEFLOW.dbo.AirPrograms t
        INNER JOIN #ICIS_FACILITY_DELETE i
            ON t.AirFacilityID = i.AIRFACILITYID;

    DELETE t
    FROM NETWORKNODEFLOW.dbo.AirFacility t
        INNER JOIN #ICIS_FACILITY_DELETE i
            ON t.AirFacilityID = i.AIRFACILITYID;

    UPDATE ad
    SET ad.ICIS_STATUSIND   = 'P',
        ad.ICIS_PROCESSDATE = GETDATE()
    FROM AIRBRANCH.dbo.ICIS_DELETE ad
        INNER JOIN #ICIS_FACILITY_DELETE i
            ON ad.ID = i.AIRFACILITYID
            AND ad.DATAFAMILY = 'FACILITY';

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

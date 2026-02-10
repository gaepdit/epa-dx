USE AIRBRANCH
GO

CREATE OR ALTER PROCEDURE etl.ICIS_FACILITY_UPDATE
AS

/**************************************************************************************************

Author:     Vidyanand Dhande
Overview:   Processes Air Facility / Pollutant / Program data family updates 
            for ICIS-Air

This procedure will capture any changes for AirFacility, AirPollutant, and
AirProgram data families and insert the updated records into staging tables.

Tables written to:
    NETWORKNODEFLOW.dbo.AIRPROGRAMS
    NETWORKNODEFLOW.dbo.AIRPROGRAMSUBPART
    NETWORKNODEFLOW.dbo.AirPollutants
    NETWORKNODEFLOW.dbo.AIRFACILITY
    NETWORKNODEFLOW.dbo.PORTABLESOURCE
    NETWORKNODEFLOW.dbo.NAICS
    NETWORKNODEFLOW.dbo.SIC
    NETWORKNODEFLOW.dbo.GEOGRAPHICCOORDINATE
    NETWORKNODEFLOW.dbo.AIRGEOGRAPHICCOORDINATE

Modification History:
When        Who                 What
----------  ------------------  -------------------------------------------------------------------
Previously  DWaldron            Initially created in Oracle
2016-11-28  VDhande             Migrated to SQL Server
2016-12-20  DWaldron            Test, reorganize and fix
2017-01-23  DWaldron            Accommodate new GACT/NSPS-non-major rules and
                                include start dates where available
2017-04-28  DWaldron            Fix bugs from foreign key contraints
2017-08-03  DWaldron            Fix bad joins in program/pollutant updates (DX-34)
2017-10-23  DWaldron            Include Operating Status Code & Start Date for
                                all Air Programs (DX-55)
2018-08-10  DWaldron            Enable updates of facilities after air programs
                                have been removed (DX-86)
2018-08-15  DWaldron            Don't use obsolete code column in APBSUBPARTDATA
                                for air program subparts (DX-90)
2018-08-24  DWaldron            Update facility ownership type (DX-68)
2020-01-30  DWaldron            Don't delete air program subparts. Instead, update
                                the subpart status indicator (DX-116)
2020-02-03  DWaldron            Only add Air Programs if subparts exist for the
                                facility or if subparts are not required. (DX-116)
2021-09-24  DWaldron            Replace empty street address with 'N/A' (#69)
2022-12-08  DWaldron            Update filter for approved facilities (IAIP-1177)

***************************************************************************************************/

    SET XACT_ABORT, NOCOUNT ON;
BEGIN TRY

    BEGIN TRANSACTION;

    /* *** PART I: All modified facilities *** */

    SELECT fi.STRAIRSNUMBER,
           CONCAT('GA000000', SUBSTRING(fi.STRAIRSNUMBER, 3, 10)) AS AIRFACILITYID
    INTO #All_Modified_Facilities
    FROM dbo.APBFACILITYINFORMATION AS fi
        INNER JOIN dbo.APBHEADERDATA AS hd
            ON fi.STRAIRSNUMBER = hd.STRAIRSNUMBER
        INNER JOIN dbo.AFSFACILITYDATA AS afs
            ON hd.STRAIRSNUMBER = afs.STRAIRSNUMBER
    WHERE afs.STRUPDATESTATUS in ('A', 'C')
      AND (fi.ICIS_STATUSIND <> 'P'
        OR hd.ICIS_STATUSIND <> 'P')
      AND CONCAT('GA000000', SUBSTRING(fi.STRAIRSNUMBER, 3, 10)) IN
          (SELECT AirFacilityID
           FROM NETWORKNODEFLOW.dbo.AirFacility);

    IF EXISTS
        (SELECT *
         FROM #All_Modified_Facilities)
        BEGIN

            -- Facility data
            SELECT fi.STRAIRSNUMBER,
                   CONCAT('GA000000', SUBSTRING(fi.STRAIRSNUMBER, 3, 10))        AS AIRFACILITYID,
                   fi.STRFACILITYCITY,
                   fi.STRFACILITYNAME,
                   IIF(fi.STRFACILITYSTREET1 = '', 'N/A', fi.STRFACILITYSTREET1) as STRFACILITYSTREET1,
                   fi.STRFACILITYSTREET2,
                   fi.STRFACILITYSTATE,
                   fi.STRFACILITYZIPCODE,
                   hd.STRPLANTDESCRIPTION,
                   lkn.NAICS_CODE,
                   lks.SIC_CODE,
                   lkc.ICIS_CITY_CODE,
                   s.FacilityOwnershipTypeCode
            INTO #Facility_Data
            FROM dbo.APBFACILITYINFORMATION AS fi
                INNER JOIN dbo.APBHEADERDATA AS hd
                    ON fi.STRAIRSNUMBER = hd.STRAIRSNUMBER
                inner join dbo.APBSUPPLAMENTALDATA s
                    on s.STRAIRSNUMBER = fi.STRAIRSNUMBER
                LEFT JOIN
            (SELECT ln.NAICS_CODE
             FROM dbo.LK_NAICS AS ln
             WHERE ln.ICIS_STATUS_FLAG = 'A') AS lkn
                    ON hd.STRNAICSCODE = lkn.NAICS_CODE
                LEFT JOIN
            (SELECT ls.SIC_CODE
             FROM dbo.LK_SIC AS ls
             WHERE ls.ICIS_STATUS_FLAG = 'A') AS lks
                    ON hd.STRSICCODE = lks.SIC_CODE
                LEFT JOIN
            (SELECT lc.LGCY_CITY_DESC,
                    lc.ICIS_CITY_CODE,
                    lc.LGCY_COUNTY_CODE
             FROM dbo.LK_ICIS_CITY_CODE AS lc
             WHERE lc.ICIS_STATUS_FLAG = 'A') AS lkc
                    ON lkc.LGCY_CITY_DESC = fi.STRFACILITYCITY
                    AND lkc.LGCY_COUNTY_CODE = SUBSTRING(fi.STRAIRSNUMBER, 5, 3)
            WHERE fi.STRAIRSNUMBER IN
                  (SELECT STRAIRSNUMBER
                   FROM #All_Modified_Facilities);

            IF EXISTS
                (SELECT *
                 FROM #Facility_Data)
                BEGIN

                    -- AirFacility
                    UPDATE A
                    SET A.FACILITYSITENAME            = SUBSTRING(i.STRFACILITYNAME, 1, 79),
                        A.LocationAddressText         = SUBSTRING(i.STRFACILITYSTREET1, 1, 50),
                        A.SupplementalLocationText    = IIF(UPPER(i.strfacilitystreet2) = 'N/A', NULL,
                                                            SUBSTRING(i.strfacilitystreet2, 1, 50)),
                        A.GNISCITYCODE                = i.icis_city_code,
                        A.LOCALITYNAME                = CASE
                                                            WHEN i.icis_city_code IS NULL
                                                                AND i.STRFACILITYCITY <> ' '
                                                                THEN i.STRFACILITYCITY
                                                            WHEN i.icis_city_code IS NULL
                                                                AND i.STRFACILITYCITY = ' '
                                                                THEN 'N/A'
                            END,
                        A.LocationAddressCountyCode   = CASE
                                                            WHEN i.icis_city_code IS NULL
                                                                AND SUBSTRING(i.strairsnumber, 5, 3) = '777'
                                                                THEN 'GA000'
                                                            WHEN i.icis_city_code IS NULL
                                                                AND SUBSTRING(i.strairsnumber, 5, 3) <> '777'
                                                                THEN CONCAT('GA', SUBSTRING(i.strairsnumber, 5, 3))
                            END,
                        A.LOCATIONSTATECODE           = i.STRFACILITYSTATE,
                        A.LOCATIONZIPCODE             = CASE
                                                            WHEN REPLACE(REPLACE(i.STRFACILITYZIPCODE, ' ', ''), '-', '') IS NULL
                                                                THEN '00000'
                                                            WHEN REPLACE(REPLACE(i.STRFACILITYZIPCODE, ' ', ''), '-', '') = ''
                                                                THEN '00000'
                                                            WHEN REPLACE(REPLACE(i.STRFACILITYZIPCODE, ' ', ''), '-', '') = '0'
                                                                THEN '00000'
                                                            ELSE REPLACE(REPLACE(i.STRFACILITYZIPCODE, ' ', ''), '-', '')
                            END,
                        A.FACILITYDESCRIPTION         = i.STRPLANTDESCRIPTION,
                        A.REGISTRATIONNUMBER          = CONCAT(SUBSTRING(i.STRAIRSNUMBER, 5, 3), '-',
                                                               SUBSTRING(i.STRAIRSNUMBER, 8, 15)),
                        A.FacilityTypeOfOwnershipCode = i.FacilityOwnershipTypeCode
                    FROM NETWORKNODEFLOW.dbo.AirFacility A
                        INNER JOIN #Facility_Data AS i
                            ON i.AIRFACILITYID = A.AIRFACILITYID;

                    -- NAICS
                    UPDATE A
                    SET A.NAICSCODE = IIF(i.NAICS_CODE IS NULL, '999999', i.NAICS_CODE)
                    FROM NETWORKNODEFLOW.dbo.NAICS A
                        INNER JOIN #Facility_Data i
                            ON i.AIRFACILITYID = A.AIRFACILITYID;

                    -- SIC
                    UPDATE A
                    SET A.SICCODE                 = i.SIC_CODE,
                        A.SICPRIMARYINDICATORCODE = IIF(i.SIC_CODE IS NULL, NULL, 'Y')
                    FROM NETWORKNODEFLOW.dbo.SIC A
                        INNER JOIN #Facility_Data i
                            ON i.AIRFACILITYID = A.AIRFACILITYID;

                END;

            DROP TABLE #Facility_Data;

            -- GEOGRAPHICCOORDINATE
            SELECT fi.STRAIRSNUMBER,
                   CAST(fi.NUMFACILITYLATITUDE AS varchar(15))  AS NUMFACILITYLATITUDE,
                   CAST(fi.NUMFACILITYLONGITUDE AS varchar(15)) AS NUMFACILITYLONGITUDE,
                   fi.STRHORIZONTALACCURACYMEASURE,
                   fi.STRHORIZONTALCOLLECTIONCODE,
                   fi.STRHORIZONTALREFERENCECODE,
                   af.AIRFACILITYID
            INTO #Geo_Coord
            FROM NETWORKNODEFLOW.dbo.AirFacility AS af
                INNER JOIN dbo.APBFACILITYINFORMATION AS fi
                    ON af.AIRFACILITYID = CONCAT('GA000000', SUBSTRING(fi.STRAIRSNUMBER, 3, 10))
                INNER JOIN #All_Modified_Facilities AS j
                    ON af.AIRFACILITYID = j.AIRFACILITYID;

            UPDATE A
            SET A.LATITUDEMEASURE                = i.NUMFACILITYLATITUDE,
                A.LONGITUDEMEASURE               = i.NUMFACILITYLONGITUDE,
                A.HorizontalAccuracyMeasure      = ROUND(CAST(i.STRHORIZONTALACCURACYMEASURE AS varchar(10)), 0),
                A.HorizontalCollectionMethodCode = i.STRHORIZONTALCOLLECTIONCODE,
                A.HorizontalReferenceDatumCode   = i.STRHORIZONTALREFERENCECODE
            FROM NETWORKNODEFLOW.dbo.GeographicCoordinate A
                INNER JOIN #Geo_Coord AS i
                    ON A.GaAirFacilityID = i.AirFacilityID;

            DROP TABLE #Geo_Coord;

            -- AIRPROGRAMS Update

            -- First, include all programs from the ICIS_PROGRAM_CODES table. This will
            -- miss some program codes like CAAGACTM and CAANSPSM, since those are not
            -- included in this table. They will be picked up in the next section below.
            SELECT af.AIRFACILITYID,
                   pc.ICIS_PROGRAM_CODE,
                   pc.OperatingStatusCode,
                   pc.OperatingStatusStartDate
            INTO #Air_Program_Updates
            FROM dbo.ICIS_PROGRAM_CODES AS pc
                INNER JOIN NETWORKNODEFLOW.dbo.AirFacility AS af
                    ON af.AirFacilityID = CONCAT('GA000000', SUBSTRING(pc.STRAIRSNUMBER, 3, 10))
                INNER JOIN #All_Modified_Facilities AS j
                    ON af.AirFacilityID = j.AIRFACILITYID
            WHERE pc.ICIS_PROGRAM_CODE IN
                  (SELECT AirProgramCode
                   FROM NETWORKNODEFLOW.dbo.AirPrograms
                   WHERE AirFacilityID = j.AIRFACILITYID);

            UPDATE a
            SET a.AirProgramOperatingStatusCode      = i.OperatingStatusCode,
                a.AirProgramOperatingStatusStartDate = i.OperatingStatusStartDate
            FROM NETWORKNODEFLOW.dbo.AirPrograms a
                INNER JOIN #All_Modified_Facilities j
                    ON a.AirFacilityID = j.AIRFACILITYID
                INNER JOIN #Air_Program_Updates i
                    ON a.AirProgramCode = i.ICIS_PROGRAM_CODE
                    AND a.AirFacilityID = i.AirFacilityID;

            DROP TABLE #Air_Program_Updates;

            -- Second, join with the APBSUBPARTDATA table to pick up the additional
            -- program codes like CAAGACTM and CAANSPSM for facilities subject to
            -- those types of subparts.
            SELECT af.AirFacilityID,
                   spc.ICIS_PROGRAM_CODE,
                   pc.OperatingStatusCode,
                   pc.OperatingStatusStartDate
            INTO #Air_Program2_Updates
            FROM (SELECT DISTINCT s.STRAIRSNUMBER,
                                  l.ICIS_PROGRAM_CODE
                  FROM APBSUBPARTDATA AS s
                      INNER JOIN LK_ICIS_PROGRAM_SUBPART AS l
                          on right(s.STRSUBPARTKEY, 1) = l.LGCY_PROGRAM_CODE
                          and s.STRSUBPART = l.LK_SUBPART_CODE
                  WHERE s.ACTIVE = 1) AS spc
                INNER JOIN AIRBRANCH.dbo.ICIS_PROGRAM_CODES pc
                    ON pc.STRAIRSNUMBER = spc.STRAIRSNUMBER
                    AND pc.ICIS_PROGRAM_CODE = CASE
                                                   WHEN spc.ICIS_PROGRAM_CODE = 'CAANSPSM'
                                                       THEN 'CAANSPS'
                                                   WHEN spc.ICIS_PROGRAM_CODE = 'CAAGACTM'
                                                       THEN 'CAAMACT'
                        END
                INNER JOIN NETWORKNODEFLOW.dbo.AirFacility AS af
                    ON af.AirFacilityID = CONCAT('GA000000', SUBSTRING(spc.STRAIRSNUMBER, 3, 10))
                INNER JOIN #All_Modified_Facilities AS j
                    ON af.AirFacilityID = j.AIRFACILITYID
            WHERE spc.ICIS_PROGRAM_CODE IN
                  (SELECT AirProgramCode
                   FROM NETWORKNODEFLOW.dbo.AirPrograms
                   WHERE AirFacilityID = j.AIRFACILITYID);

            UPDATE a
            SET a.AirProgramOperatingStatusCode      = i.OperatingStatusCode,
                a.AirProgramOperatingStatusStartDate = i.OperatingStatusStartDate
            FROM NETWORKNODEFLOW.dbo.AirPrograms A
                INNER JOIN #All_Modified_Facilities j
                    ON a.AirFacilityID = j.AIRFACILITYID
                INNER JOIN #Air_Program2_Updates i
                    ON a.AirProgramCode = i.ICIS_PROGRAM_CODE
                    AND a.AirFacilityID = i.AirFacilityID;

            DROP TABLE #Air_Program2_Updates;

            -- AIRPROGRAMS Insert

            -- First, include programs from the ICIS_PROGRAM_CODES table
            -- that do NOT have subparts in LK_ICIS_PROGRAM_SUBPART.
            insert into NETWORKNODEFLOW.dbo.AirPrograms
            (AirFacilityID,
             AirProgramCode,
             AirProgramOperatingStatusCode,
             AirProgramOperatingStatusStartDate,
             TransactionID)
            select f.AirFacilityID,
                   c.ICIS_PROGRAM_CODE,
                   c.OperatingStatusCode,
                   c.OperatingStatusStartDate,
                   NEWID()
            from dbo.ICIS_PROGRAM_CODES as c
                inner join NETWORKNODEFLOW.dbo.AirFacility as f
                    on f.AirFacilityID = CONCAT('GA000000', SUBSTRING(c.STRAIRSNUMBER, 3, 10))
                inner join #All_Modified_Facilities as j
                    on f.AirFacilityID = j.AIRFACILITYID
                left join etl.VW_AirProgramsWithSubparts v
                    on v.ICIS_PROGRAM_CODE = c.ICIS_PROGRAM_CODE
                left join NETWORKNODEFLOW.dbo.AirPrograms p
                    on p.AirProgramCode = c.ICIS_PROGRAM_CODE
                    and p.AirFacilityID = f.AIRFACILITYID
            where p.AirProgramID is null
              and v.ICIS_PROGRAM_CODE is null;

            -- Second, join with the APBSUBPARTDATA table to pick up
            -- Air Programs for which the facility does have subparts.
            insert into NETWORKNODEFLOW.dbo.AirPrograms
            (AirFacilityID,
             AirProgramCode,
             AirProgramOperatingStatusCode,
             AirProgramOperatingStatusStartDate,
             TransactionID)
            select f.AIRFACILITYID,
                   a.ICIS_PROGRAM_CODE,
                   c.OperatingStatusCode,
                   c.OperatingStatusStartDate,
                   NEWID()
            from ICIS_PROGRAM_CODES c
                inner join (select distinct s.STRAIRSNUMBER,
                                            l.ICIS_PROGRAM_CODE
                            from APBSUBPARTDATA as s
                                inner join LK_ICIS_PROGRAM_SUBPART as l
                                    on right(s.STRSUBPARTKEY, 1) = l.LGCY_PROGRAM_CODE
                                    and s.STRSUBPART = l.LK_SUBPART_CODE
                                    and l.ICIS_STATUS_FLAG = 'A')
                as a
                    on c.STRAIRSNUMBER = a.STRAIRSNUMBER
                    and c.ICIS_PROGRAM_CODE =
                        case
                            when a.ICIS_PROGRAM_CODE = 'CAANSPSM' then 'CAANSPS'
                            when a.ICIS_PROGRAM_CODE = 'CAAGACTM' then 'CAAMACT'
                            else a.ICIS_PROGRAM_CODE
                            end
                inner join NETWORKNODEFLOW.dbo.AirFacility as f
                    on f.AirFacilityID = CONCAT('GA000000', SUBSTRING(a.STRAIRSNUMBER, 3, 10))
                inner join #All_Modified_Facilities AS j
                    on f.AirFacilityID = j.AIRFACILITYID
                left join NETWORKNODEFLOW.dbo.AirPrograms p
                    on p.AirProgramCode = a.ICIS_PROGRAM_CODE
                    and p.AirFacilityID = f.AIRFACILITYID
            where p.AirProgramID is null;

            -- AIRPROGRAMSUBPART Update
            update a
            set a.AirProgramSubpartStatusIndicator = IIF(b.ACTIVE = '1', 'A', 'I')
            from NETWORKNODEFLOW.dbo.AirProgramSubpart a
                inner join NETWORKNODEFLOW.dbo.AirPrograms p
                    on a.AirProgramID = p.AirProgramID
                inner join (select s.STRAIRSNUMBER,
                                   s.ACTIVE,
                                   l.ICIS_PROGRAM_CODE,
                                   l.ICIS_PROGRAM_SUBPART_CODE
                            from APBSUBPARTDATA s
                                INNER JOIN LK_ICIS_PROGRAM_SUBPART AS l
                                    on right(s.STRSUBPARTKEY, 1) = l.LGCY_PROGRAM_CODE
                                    and s.STRSUBPART = l.LK_SUBPART_CODE
                                    and l.ICIS_STATUS_FLAG = 'A') b
                    on CONCAT('GA000000', SUBSTRING(b.STRAIRSNUMBER, 3, 10)) =
                       p.AirFacilityID
                    and p.AirProgramCode = b.ICIS_PROGRAM_CODE
                    and a.AirProgramSubpartCode = b.ICIS_PROGRAM_SUBPART_CODE
                INNER JOIN #All_Modified_Facilities AS j
                    ON p.AirFacilityID = j.AIRFACILITYID;

            -- AIRPROGRAMSUBPART Insert
            insert into NETWORKNODEFLOW.dbo.AirProgramSubpart
            (AirProgramID,
             AirProgramSubpartCode,
             AirProgramSubpartStatusIndicator)
            select p.AirProgramID,
                   b.ICIS_PROGRAM_SUBPART_CODE,
                   IIF(b.ACTIVE = '1', 'A', 'I')
            from NETWORKNODEFLOW.dbo.AirPrograms p
                INNER JOIN #All_Modified_Facilities AS j
                    ON p.AirFacilityID = j.AIRFACILITYID
                inner join (select s.STRAIRSNUMBER,
                                   s.ACTIVE,
                                   l.ICIS_PROGRAM_CODE,
                                   l.ICIS_PROGRAM_SUBPART_CODE
                            from APBSUBPARTDATA s
                                INNER JOIN LK_ICIS_PROGRAM_SUBPART AS l
                                    on right(s.STRSUBPARTKEY, 1) = l.LGCY_PROGRAM_CODE
                                    and s.STRSUBPART = l.LK_SUBPART_CODE
                                    and l.ICIS_STATUS_FLAG = 'A') b
                    on CONCAT('GA000000', SUBSTRING(b.STRAIRSNUMBER, 3, 10)) =
                       p.AirFacilityID
                    and p.AirProgramCode = b.ICIS_PROGRAM_CODE
                left join NETWORKNODEFLOW.dbo.AirProgramSubpart a
                    on a.AirProgramID = p.AirProgramID
                    and
                       b.ICIS_PROGRAM_SUBPART_CODE = a.AirProgramSubpartCode
            where a.AirProgramSubpartID is null;

            -- AIRPOLLUTANT - update existing
            SELECT af.AIRFACILITYID,
                   pl.ICIS_POLLUTANT_CODE,
                   hd.ICIS_POLLUTANT_CLASS_CODE,
                   ch.ChangeDate
            INTO #Air_Pollutant_Update
            FROM dbo.ICIS_POLLUTANT AS pl
                INNER JOIN dbo.APBHEADERDATA AS hd
                    ON pl.STRAIRSNUMBER = hd.STRAIRSNUMBER
                INNER JOIN iaip_facility.VW_FacilityClassChangeDate AS ch
                    ON ch.STRAIRSNUMBER = pl.STRAIRSNUMBER
                INNER JOIN NETWORKNODEFLOW.dbo.AIRFACILITY AS af
                    ON af.AIRFACILITYID = CONCAT('GA000000', SUBSTRING(hd.STRAIRSNUMBER, 3, 10))
                INNER JOIN #All_Modified_Facilities AS j
                    ON af.AIRFACILITYID = j.AIRFACILITYID
            WHERE hd.STROPERATIONALSTATUS <> 'X'
              AND pl.ICIS_POLLUTANT_CODE IN
                  (SELECT ap.AIRPOLLUTANTSCODE
                   FROM NETWORKNODEFLOW.dbo.AIRPOLLUTANTS AS ap
                       INNER JOIN #All_Modified_Facilities AS j
                           ON ap.AIRFACILITYID = j.AIRFACILITYID);

            UPDATE A
            SET A.AirPollutantDAClassificationCode      = i.ICIS_POLLUTANT_CLASS_CODE,
                A.AirPollutantDAClassificationStartDate = i.ChangeDate
            FROM NETWORKNODEFLOW.dbo.AirPollutants A
                INNER JOIN #Air_Pollutant_Update i
                    ON A.AIRPOLLUTANTSCODE = i.ICIS_POLLUTANT_CODE
                    AND A.AirFacilityId = i.AIRFACILITYID
                INNER JOIN #All_Modified_Facilities j
                    ON A.AIRFACILITYID = j.AIRFACILITYID;

            -- AIRPOLLUTANT - insert new
            INSERT INTO NETWORKNODEFLOW.dbo.AirPollutants
            (AIRFACILITYID,
             AIRPOLLUTANTSCODE,
             AirPollutantDAClassificationCode,
             AirPollutantDAClassificationStartDate,
             TRANSACTIONID)
            SELECT af.AIRFACILITYID,
                   pl.ICIS_POLLUTANT_CODE,
                   hd.ICIS_POLLUTANT_CLASS_CODE,
                   ch.ChangeDate,
                   NEWID()
            FROM dbo.ICIS_POLLUTANT AS pl
                INNER JOIN dbo.APBHEADERDATA AS hd
                    ON pl.STRAIRSNUMBER = hd.STRAIRSNUMBER
                INNER JOIN iaip_facility.VW_FacilityClassChangeDate AS ch
                    ON ch.STRAIRSNUMBER = pl.STRAIRSNUMBER
                INNER JOIN NETWORKNODEFLOW.dbo.AIRFACILITY AS af
                    ON af.AIRFACILITYID = CONCAT('GA000000', SUBSTRING(hd.STRAIRSNUMBER, 3, 10))
                INNER JOIN #All_Modified_Facilities AS j
                    ON af.AIRFACILITYID = j.AIRFACILITYID
            WHERE hd.STROPERATIONALSTATUS <> 'X'
              AND pl.ICIS_POLLUTANT_CODE NOT IN
                  (SELECT A.AirPollutantsCode
                   FROM NETWORKNODEFLOW.dbo.AirPollutants AS A
                       INNER JOIN #All_Modified_Facilities AS j
                           ON A.AirFacilityID = j.AIRFACILITYID);

            -- Reset the facility status indicators to 'P' for "Processed"
            UPDATE fi
            SET fi.ICIS_STATUSIND = 'P'
            FROM dbo.APBFACILITYINFORMATION fi
                INNER JOIN #All_Modified_Facilities j
                    ON fi.strairsnumber = j.strairsnumber;

            UPDATE hd
            SET hd.ICIS_STATUSIND = 'P'
            FROM dbo.APBHEADERDATA hd
                INNER JOIN #All_Modified_Facilities j
                    ON hd.strairsnumber = j.strairsnumber;

        END;

    DROP TABLE #All_Modified_Facilities;

    /* *** END: Modified facilities *** */

    /* *** PART II: All new facilities *** */

    SELECT fi.STRAIRSNUMBER,
           CONCAT('GA000000', SUBSTRING(fi.STRAIRSNUMBER, 3, 10)) AS AIRFACILITYID
    INTO #All_New_Facilities
    FROM dbo.APBFACILITYINFORMATION AS fi
        INNER JOIN dbo.APBHEADERDATA AS hd
            ON fi.STRAIRSNUMBER = hd.STRAIRSNUMBER
        INNER JOIN dbo.AFSFACILITYDATA AS afs
            ON hd.STRAIRSNUMBER = afs.STRAIRSNUMBER
    WHERE afs.STRUPDATESTATUS in ('A', 'C')
      AND (FI.ICIS_STATUSIND <> 'P'
        OR hd.ICIS_STATUSIND <> 'P')
      AND hd.STRAIRPROGRAMCODES NOT LIKE '0000000000000%'
      AND CONCAT('GA000000', SUBSTRING(fi.STRAIRSNUMBER, 3, 10)) NOT IN
          (SELECT AirFacilityID
           FROM NETWORKNODEFLOW.dbo.AirFacility);

    IF EXISTS
        (SELECT *
         FROM #All_New_Facilities)
        BEGIN

            -- Get Facility data
            SELECT fi.STRAIRSNUMBER,
                   CONCAT('GA000000', SUBSTRING(fi.STRAIRSNUMBER, 3, 10))        AS AIRFACILITYID,
                   fi.STRFACILITYCITY,
                   fi.STRFACILITYNAME,
                   IIF(fi.STRFACILITYSTREET1 = '', 'N/A', fi.STRFACILITYSTREET1) as STRFACILITYSTREET1,
                   fi.STRFACILITYSTREET2,
                   fi.STRFACILITYSTATE,
                   fi.STRFACILITYZIPCODE,
                   hd.STRPLANTDESCRIPTION,
                   lkn.NAICS_CODE,
                   lks.SIC_CODE,
                   lkc.ICIS_CITY_CODE,
                   s.FacilityOwnershipTypeCode
            INTO #New_Facility_Data
            FROM dbo.APBFACILITYINFORMATION AS fi
                INNER JOIN dbo.APBHEADERDATA AS hd
                    ON fi.STRAIRSNUMBER = hd.STRAIRSNUMBER
                inner join dbo.APBSUPPLAMENTALDATA s
                    on s.STRAIRSNUMBER = fi.STRAIRSNUMBER
                LEFT JOIN
            (SELECT ln.NAICS_CODE
             FROM dbo.LK_NAICS AS ln
             WHERE ln.ICIS_STATUS_FLAG = 'A') AS lkn
                    ON hd.STRNAICSCODE = lkn.NAICS_CODE
                LEFT JOIN
            (SELECT ls.SIC_CODE
             FROM dbo.LK_SIC AS ls
             WHERE ls.ICIS_STATUS_FLAG = 'A') AS lks
                    ON hd.STRSICCODE = lks.SIC_CODE
                LEFT JOIN
            (SELECT lc.LGCY_CITY_DESC,
                    lc.ICIS_CITY_CODE,
                    lc.LGCY_COUNTY_CODE
             FROM dbo.LK_ICIS_CITY_CODE AS lc
             WHERE lc.ICIS_STATUS_FLAG = 'A') AS lkc
                    ON lkc.LGCY_CITY_DESC = UPPER(fi.STRFACILITYCITY)
                    AND lkc.LGCY_COUNTY_CODE = SUBSTRING(fi.STRAIRSNUMBER, 5, 3)
                INNER JOIN #All_New_Facilities AS j
                    ON fi.STRAIRSNUMBER = j.STRAIRSNUMBER;

            IF EXISTS
                (SELECT *
                 FROM #New_Facility_Data)
                BEGIN

                    -- AirFacility
                    INSERT INTO NETWORKNODEFLOW.dbo.AIRFACILITY
                    (AIRFACILITYID,
                     FACILITYSITENAME,
                     LocationAddressText,
                     SupplementalLocationText,
                     GNISCITYCODE,
                     LOCALITYNAME,
                     LOCATIONADDRESSCOUNTYCODE,
                     LOCATIONSTATECODE,
                     LOCATIONZIPCODE,
                     FACILITYDESCRIPTION,
                     REGISTRATIONNUMBER,
                     TRANSACTIONID,
                     FacilityTypeOfOwnershipCode)
                    SELECT i.AIRFACILITYID,
                           i.strfacilityname,
                           SUBSTRING(i.strfacilitystreet1, 1, 50),
                           IIF(i.strfacilitystreet2 = 'N/A', NULL, SUBSTRING(i.strfacilitystreet2, 1, 50)),
                           i.icis_city_code,
                           CASE
                               WHEN i.icis_city_code IS NULL
                                   AND i.STRFACILITYCITY <> ' '
                                   THEN i.STRFACILITYCITY
                               WHEN i.icis_city_code IS NULL
                                   AND i.STRFACILITYCITY = ' '
                                   THEN 'N/A'
                               END,
                           CASE
                               WHEN i.icis_city_code IS NULL
                                   AND SUBSTRING(i.strairsnumber, 5, 3) = '777'
                                   THEN 'GA000'
                               WHEN i.icis_city_code IS NULL
                                   AND SUBSTRING(i.strairsnumber, 5, 3) <> '777'
                                   THEN CONCAT('GA', SUBSTRING(i.strairsnumber, 5, 3))
                               END,
                           i.STRFACILITYSTATE,
                           CASE
                               WHEN REPLACE(REPLACE(i.STRFACILITYZIPCODE, ' ', ''), '-', '') IS NULL
                                   THEN '00000'
                               WHEN REPLACE(REPLACE(i.STRFACILITYZIPCODE, ' ', ''), '-', '') = ''
                                   THEN '00000'
                               WHEN REPLACE(REPLACE(i.STRFACILITYZIPCODE, ' ', ''), '-', '') = '0'
                                   THEN '00000'
                               ELSE REPLACE(REPLACE(i.STRFACILITYZIPCODE, ' ', ''), '-', '')
                               END,
                           i.STRPLANTDESCRIPTION,
                           CONCAT(SUBSTRING(i.STRAIRSNUMBER, 5, 3), '-', SUBSTRING(i.STRAIRSNUMBER, 8, 15)),
                           NEWID(),
                           i.FacilityOwnershipTypeCode
                    FROM #New_Facility_Data AS i;

                    -- Portable source
                    INSERT INTO NETWORKNODEFLOW.dbo.PORTABLESOURCE
                    (AIRFACILITYID,
                     PORTABLESOURCEINDICATOR)
                    SELECT i.AIRFACILITYID,
                           IIF(SUBSTRING(i.AIRFACILITYID, 11, 3) = 777, 'Y', 'N')
                    FROM #New_Facility_Data AS i;

                    -- NAICS
                    INSERT INTO NETWORKNODEFLOW.dbo.NAICS
                    (NAICSCODE,
                     NAICSPRIMARYINDICATORCODE,
                     AIRFACILITYID)
                    SELECT IIF(i.NAICS_CODE IS NULL, '999999', i.NAICS_CODE),
                           'Y',
                           i.AIRFACILITYID
                    FROM #New_Facility_Data AS i;

                    -- SIC
                    INSERT INTO NETWORKNODEFLOW.dbo.SIC
                    (SICCODE,
                     SICPRIMARYINDICATORCODE,
                     AIRFACILITYID)
                    SELECT i.SIC_CODE,
                           IIF(i.SIC_CODE IS NULL, NULL, 'Y'),
                           i.AIRFACILITYID
                    FROM #New_Facility_Data AS i;

                END;

            DROP TABLE #New_Facility_Data;

            --   GEOGRAPHICCOORDINATE
            SELECT fi.NUMFACILITYLATITUDE,
                   fi.NUMFACILITYLONGITUDE,
                   fi.STRHORIZONTALACCURACYMEASURE,
                   fi.STRHORIZONTALCOLLECTIONCODE,
                   fi.STRHORIZONTALREFERENCECODE,
                   af.AIRFACILITYID
            INTO #New_Geo_Coord
            FROM NETWORKNODEFLOW.dbo.AIRFACILITY AS af
                INNER JOIN dbo.APBFACILITYINFORMATION AS fi
                    ON af.AIRFACILITYID = CONCAT('GA000000', SUBSTRING(fi.STRAIRSNUMBER, 3, 10))
                INNER JOIN #All_New_Facilities AS j
                    ON af.AIRFACILITYID = j.AIRFACILITYID;

            CREATE TABLE #New_AirGeographicCoordinate
            (
                AirFacilityID          varchar(20),
                GeographicCoordinateID int
            );

            INSERT INTO NETWORKNODEFLOW.dbo.GeographicCoordinate
            (LatitudeMeasure,
             LongitudeMeasure,
             HorizontalAccuracyMeasure,
             HorizontalCollectionMethodCode,
             HorizontalReferenceDatumCode,
             GaAirFacilityID)
            OUTPUT inserted.GaAirFacilityID,
                   inserted.GeographicCoordinateID
                INTO #New_AirGeographicCoordinate
            SELECT i.NUMFACILITYLATITUDE,
                   i.NUMFACILITYLONGITUDE,
                   ROUND(i.STRHORIZONTALACCURACYMEASURE, 0),
                   i.STRHORIZONTALCOLLECTIONCODE,
                   i.STRHORIZONTALREFERENCECODE,
                   i.AirFacilityID
            FROM #New_Geo_Coord AS i;

            INSERT INTO NETWORKNODEFLOW.dbo.AirGeographicCoordinate
            (AirFacilityID,
             GeographicCoordinateID)
            SELECT AirFacilityID, GeographicCoordinateID
            FROM #New_AirGeographicCoordinate;

            DROP TABLE #New_AirGeographicCoordinate;

            -- AIRPROGRAMS
            -- First, SKIP programs with subparts (NESH, NSPS, MACT) since those can have varied
            -- air program codes for the same program; i.e., CAANSPS vs CAANSPSM, or CAAMACT vs CAAGACTM
            INSERT INTO NETWORKNODEFLOW.dbo.AirPrograms
            (AirFacilityID,
             AirProgramCode,
             AirProgramOperatingStatusCode,
             AirProgramOperatingStatusStartDate,
             TransactionID)
            SELECT af.AirFacilityID,
                   pc.ICIS_PROGRAM_CODE,
                   pc.OperatingStatusCode,
                   pc.OperatingStatusStartDate,
                   NEWID()
            FROM dbo.ICIS_PROGRAM_CODES AS pc
                INNER JOIN NETWORKNODEFLOW.dbo.AirFacility AS af
                    ON af.AIRFACILITYID = CONCAT('GA000000', SUBSTRING(pc.STRAIRSNUMBER, 3, 10))
                INNER JOIN #All_New_Facilities AS j
                    ON af.AirFacilityID = j.AIRFACILITYID
            WHERE pc.ICIS_PROGRAM_CODE NOT IN ('CAANESH', 'CAANSPS', 'CAAMACT', 'CAAGACTM', 'CAANSPSM');

            -- Second INCLUDE programs with subparts (NESH, NSPS, MACT);
            -- These programs can have varied air program codes
            INSERT INTO NETWORKNODEFLOW.dbo.AirPrograms
            (AirFacilityID,
             AirProgramCode,
             AirProgramOperatingStatusCode,
             AirProgramOperatingStatusStartDate,
             TransactionID)
            SELECT af.AirFacilityID,
                   spc.ICIS_PROGRAM_CODE,
                   pc.OperatingStatusCode,
                   pc.OperatingStatusStartDate,
                   NEWID()
            FROM (SELECT DISTINCT s.STRAIRSNUMBER,
                                  l.ICIS_PROGRAM_CODE
                  FROM APBSUBPARTDATA AS s
                      INNER JOIN LK_ICIS_PROGRAM_SUBPART AS l
                          on right(s.STRSUBPARTKEY, 1) = l.LGCY_PROGRAM_CODE
                          and s.STRSUBPART = l.LK_SUBPART_CODE
                  WHERE s.ACTIVE = 1) AS spc
                INNER JOIN AIRBRANCH.dbo.ICIS_PROGRAM_CODES pc
                    ON pc.STRAIRSNUMBER = spc.STRAIRSNUMBER
                    AND pc.ICIS_PROGRAM_CODE = CASE
                                                   WHEN spc.ICIS_PROGRAM_CODE = 'CAANESH'
                                                       THEN 'CAANESH'
                                                   WHEN spc.ICIS_PROGRAM_CODE IN ('CAANSPS', 'CAANSPSM')
                                                       THEN 'CAANSPS'
                                                   WHEN spc.ICIS_PROGRAM_CODE IN ('CAAMACT', 'CAAGACTM')
                                                       THEN 'CAAMACT'
                        END
                INNER JOIN NETWORKNODEFLOW.dbo.AirFacility AS af
                    ON af.AirFacilityID = CONCAT('GA000000', SUBSTRING(pc.STRAIRSNUMBER, 3, 10))
                INNER JOIN #All_New_Facilities AS j
                    ON af.AirFacilityID = j.AIRFACILITYID
            WHERE pc.ICIS_PROGRAM_CODE IN ('CAANESH', 'CAANSPS', 'CAAMACT', 'CAAGACTM', 'CAANSPSM');

            -- AIRPROGRAMSUBPART
            insert into NETWORKNODEFLOW.dbo.AirProgramSubpart
            (AirProgramID,
             AirProgramSubpartCode,
             AirProgramSubpartStatusIndicator)
            SELECT p.AirProgramID,
                   b.ICIS_PROGRAM_SUBPART_CODE,
                   IIF(b.ACTIVE = '1', 'A', 'I')
            from NETWORKNODEFLOW.dbo.AirPrograms p
                inner join (select s.STRAIRSNUMBER,
                                   s.ACTIVE,
                                   l.ICIS_PROGRAM_CODE,
                                   l.ICIS_PROGRAM_SUBPART_CODE
                            from APBSUBPARTDATA s
                                INNER JOIN LK_ICIS_PROGRAM_SUBPART AS l
                                    on right(s.STRSUBPARTKEY, 1) = l.LGCY_PROGRAM_CODE
                                    and s.STRSUBPART = l.LK_SUBPART_CODE
                                    and l.ICIS_STATUS_FLAG = 'A') b
                    on CONCAT('GA000000', SUBSTRING(b.STRAIRSNUMBER, 3, 10)) =
                       p.AirFacilityID
                    and p.AirProgramCode = b.ICIS_PROGRAM_CODE
                INNER JOIN #All_New_Facilities AS j
                    ON p.AIRFACILITYID = j.AIRFACILITYID;

            -- AIRPOLLUTANT
            INSERT INTO NETWORKNODEFLOW.dbo.AIRPOLLUTANTS
            (AIRFACILITYID,
             AIRPOLLUTANTSCODE,
             AirPollutantDAClassificationCode,
             AirPollutantDAClassificationStartDate,
             TRANSACTIONID)
            SELECT af.AIRFACILITYID,
                   pl.ICIS_POLLUTANT_CODE,
                   hd.ICIS_POLLUTANT_CLASS_CODE,
                   ch.ChangeDate,
                   NEWID()
            FROM dbo.ICIS_POLLUTANT AS pl
                INNER JOIN dbo.APBHEADERDATA AS hd
                    ON pl.STRAIRSNUMBER = hd.STRAIRSNUMBER
                INNER JOIN iaip_facility.VW_FacilityClassChangeDate AS ch
                    ON ch.STRAIRSNUMBER = pl.STRAIRSNUMBER
                INNER JOIN NETWORKNODEFLOW.dbo.AIRFACILITY AS af
                    ON af.AIRFACILITYID = CONCAT('GA000000', SUBSTRING(hd.STRAIRSNUMBER, 3, 10))
                INNER JOIN #All_New_Facilities AS j
                    ON af.AIRFACILITYID = j.AIRFACILITYID
            WHERE hd.STROPERATIONALSTATUS <> 'X';

            -- Reset the facility status indicators to 'P' for "Processed"
            UPDATE fi
            SET fi.ICIS_STATUSIND = 'P'
            FROM dbo.APBFACILITYINFORMATION fi
                INNER JOIN #All_New_Facilities j
                    ON fi.strairsnumber = j.strairsnumber;

            UPDATE hd
            SET hd.ICIS_STATUSIND = 'P'
            FROM dbo.APBHEADERDATA hd
                INNER JOIN #All_New_Facilities j
                    ON hd.strairsnumber = j.strairsnumber;

        END;

    DROP TABLE #All_New_Facilities;

    /* *** END: New facilities *** */

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

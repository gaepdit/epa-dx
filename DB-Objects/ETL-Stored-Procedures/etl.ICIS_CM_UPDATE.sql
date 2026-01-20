USE airbranch;
GO

CREATE OR ALTER PROCEDURE etl.ICIS_CM_UPDATE
AS

/**************************************************************************************************

Overview:   This procedure stages Compliance Monitoring updates.

Tables written to:
    NETWORKNODEFLOW.dbo.COMPLIANCEMONITORINGCODE
    NETWORKNODEFLOW.dbo.COMPLIANCEMONITORING
    NETWORKNODEFLOW.dbo.AIRSTACKTESTDATA
    NETWORKNODEFLOW.dbo.TVACCREVIEWDATA

Modification History:
When        Who                 What
----------  ------------------  -------------------------------------------------------------------
Previously  DWaldron            Initially created in Oracle
2016-12-28  VDhande             Migrated to SQL Server
2018-08-02  DWaldron            Exclude closed air program codes (DX-86)
2019-02-13  DWaldron            Include SIP air program with CM event if no others exist (DX-107)
2026-01-20  DWaldron            Complete rewrite for the new Air Web App (epa-dx#2)

***************************************************************************************************/

     SET XACT_ABORT, NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;

        -- Find all modified compliance monitoring
        SELECT cm.AIRFACILITYID
             , cm.COMPLIANCEMONITORINGID
             , cm.APBTRACKINGNUMBER
             , cm.AFSACTIONNUMBER
             , cm.COMPLIANCEMONITORINGDATE
             , cm.ACTIVITYNAME
             , cm.ACTIVITYTYPECODE
             , cm.INSPECTIONTYPECODE
             , cm.AGENCYTYPECODE
             , cm.MONITORINGTYPE
             , cm.APBSHORTACTIVITYNAME
             , cm.APBFACILITYIDDESC
             , cm.FacilityReportedStatusCode
             , cm.AIRPOLLUTANTCODE
        INTO #Modified_CM
        FROM   AIRBRANCH.dbo.VW_ICIS_COMPLIANCEMONITORING AS cm
        INNER JOIN NETWORKNODEFLOW.dbo.AIRFACILITY AS af
          ON cm.AIRFACILITYID = af.AIRFACILITYID
        WHERE  cm.ICIS_STATUSIND <> 'P'
               AND cm.COMPLIANCEMONITORINGID IN
        (
            SELECT COMPLIANCEMONITORINGID
            FROM   NETWORKNODEFLOW.dbo.COMPLIANCEMONITORING
        );

        IF EXISTS
        (
            SELECT *
            FROM   #Modified_CM
        )
            BEGIN

                UPDATE I
                   SET
                       i.ACTIVITYTYPECODE = j.ACTIVITYTYPECODE
                     , i.COMPLIANCEMONITORINGDATE = j.COMPLIANCEMONITORINGDATE
                     , i.INSPECTIONTYPECODE = j.INSPECTIONTYPECODE
                     , i.ACTIVITYNAME = j.ACTIVITYNAME
                     , i.AGENCYTYPECODE = j.AGENCYTYPECODE
                     , i.AIRFACILITYID = j.AIRFACILITYID
                     , i.AIRPOLLUTANTCODE = j.AIRPOLLUTANTCODE
                     , i.INSPECTIONUSERDEFINEDFIELD2 = j.APBSHORTACTIVITYNAME
                     , i.INSPECTIONUSERDEFINEDFIELD3 = j.APBFACILITYIDDESC
                     , i.FacilityReportedComplianceStatusCode = j.FacilityReportedStatusCode
                     , i.MONITORINGTYPE = j.MONITORINGTYPE
                FROM NETWORKNODEFLOW.dbo.COMPLIANCEMONITORING i
                INNER JOIN #Modified_CM AS j
                  ON i.COMPLIANCEMONITORINGID = j.COMPLIANCEMONITORINGID;

                -- Delete and reinsert CM program codes
                DELETE i
                FROM NETWORKNODEFLOW.dbo.COMPLIANCEMONITORINGCODE AS i
                INNER JOIN #Modified_CM AS j
                  ON i.COMPLIANCEMONITORINGID = j.COMPLIANCEMONITORINGID
                WHERE  i.CODENAME = 'ProgramCode';

                INSERT INTO NETWORKNODEFLOW.dbo.COMPLIANCEMONITORINGCODE
                ( COMPLIANCEMONITORINGID
                , CODENAME
                , CODEVALUE
                )
                SELECT cm.COMPLIANCEMONITORINGID
                     , 'ProgramCode'
                     , case
                           when pg.ICIS_PROGRAM_CODE is null then 'CAASIP'
                           else pg.ICIS_PROGRAM_CODE
                       end
                FROM   NETWORKNODEFLOW.dbo.COMPLIANCEMONITORING AS cm
                LEFT JOIN AIRBRANCH.dbo.ICIS_PROGRAM_CODES AS pg
                   ON CONCAT('GA000000', SUBSTRING(pg.STRAIRSNUMBER, 3, 10)) = cm.AIRFACILITYID
                          and pg.OperatingStatusCode <> 'CLS'
                 INNER JOIN #Modified_CM AS j
                   ON cm.COMPLIANCEMONITORINGID = j.COMPLIANCEMONITORINGID;

                -- AIRSTACKTESTDATA 
                -- (only update is needed; data should be inserted with new compliance monitoring event)
                SELECT cm.COMPLIANCEMONITORINGID
                     , ti.STRCOMPLIANCESTATUS
                     , ti.STRTESTINGFIRM
                     , ti.STRWITNESSINGENGINEER
                     , ti.DATRECEIVEDDATE
                     , ti.DATCOMPLETEDATE
                     , ti.DATTESTDATEEND
                INTO #AirStack_i
                FROM   AIRBRANCH.dbo.SSCPITEMMASTER AS mm
                INNER JOIN AIRBRANCH.dbo.SSCPTESTREPORTS AS st
                  ON mm.STRTRACKINGNUMBER = st.STRTRACKINGNUMBER
                INNER JOIN AIRBRANCH.dbo.AFSISMPRECORDS AS afs
                  ON st.STRREFERENCENUMBER = afs.STRREFERENCENUMBER
                INNER JOIN AIRBRANCH.dbo.ISMPREPORTINFORMATION AS ti
                  ON st.STRREFERENCENUMBER = ti.STRREFERENCENUMBER
                INNER JOIN NETWORKNODEFLOW.dbo.COMPLIANCEMONITORING AS cm
                  ON cm.COMPLIANCEMONITORINGID = CONCAT('GA000A0000', SUBSTRING(mm.STRAIRSNUMBER, 3, 10), RIGHT(CONCAT('00000', afs.STRAFSACTIONNUMBER), 5))
                INNER JOIN #Modified_CM AS j
                  ON cm.COMPLIANCEMONITORINGID = j.COMPLIANCEMONITORINGID
                WHERE  mm.STREVENTTYPE = '03'
                       AND (mm.STRDELETE IS NULL
                            OR mm.STRDELETE NOT LIKE 'True')
                       AND (ti.STRDELETE IS NULL
                            OR ti.STRDELETE NOT LIKE 'DELETE');

                UPDATE A
                   SET
                       STACKTESTSTATUSCODE = CASE
                                                 WHEN i.STRCOMPLIANCESTATUS = '01'
                                                 THEN 'PEN'
                                                 WHEN i.STRCOMPLIANCESTATUS = '02'
                                                 THEN 'PSS'
                                                 WHEN i.STRCOMPLIANCESTATUS = '03'
                                                 THEN 'PSS'
                                                 WHEN i.STRCOMPLIANCESTATUS = '04'
                                                 THEN 'NA'
                                                 WHEN i.STRCOMPLIANCESTATUS = '05'
                                                 THEN 'FAI'
                                             END
                     , CONDUCTORTYPECODE = CASE
                                               WHEN i.STRTESTINGFIRM = '00102'
                                               THEN 'STE'
                                               ELSE 'OOR'
                                           END
                     , OBSERVEDAGENCYTYPECODE = CASE
                                                    WHEN i.STRWITNESSINGENGINEER = 0
                                                    THEN NULL
                                                    ELSE 'STA'
                                                END
                     , REPORTRECEIVEDDATE = CASE
                                                WHEN i.DATCOMPLETEDATE < i.DATRECEIVEDDATE
                                                THEN NULL
                                                WHEN i.DATRECEIVEDDATE < i.DATTESTDATEEND
                                                THEN NULL
                                                ELSE i.DATRECEIVEDDATE
                                            END
                     , RESULTSREVIEWEDDATE = CASE
                                                 WHEN i.DATCOMPLETEDATE < '01-JAN-1970'
                                                 THEN NULL
                                                 WHEN i.DATCOMPLETEDATE < i.DATRECEIVEDDATE
                                                 THEN NULL
                                                 ELSE i.DATCOMPLETEDATE
                                             END
                FROM NETWORKNODEFLOW.dbo.AIRSTACKTESTDATA A
                INNER JOIN #AirStack_i AS i
                  ON A.COMPLIANCEMONITORINGID = i.COMPLIANCEMONITORINGID;

                DROP TABLE #AirStack_i;

                -- TVACCREVIEWDATA 
                -- (only update is needed; data should be inserted with new compliance monitoring event)
                UPDATE a
                   SET
                       a.TVACCREVIEWEDDATE = DATEADD(dd, 1, vcm.COMPLIANCEMONITORINGDATE)
                FROM NETWORKNODEFLOW.dbo.TVACCReviewData a
                INNER JOIN AIRBRANCH.dbo.VW_ICIS_COMPLIANCEMONITORING AS vcm
                  ON vcm.ComplianceMonitoringId = a.ComplianceMonitoringId
                INNER JOIN NETWORKNODEFLOW.dbo.COMPLIANCEMONITORING AS cm
                  ON cm.COMPLIANCEMONITORINGID = vcm.COMPLIANCEMONITORINGID
                INNER JOIN #Modified_CM AS j
                  ON vcm.COMPLIANCEMONITORINGID = j.COMPLIANCEMONITORINGID
                WHERE  vcm.INSPECTIONTYPECODE = 'TVA';

                -- Reset the status indicator to 'P' for "Processed"
                UPDATE m
                   SET
                       m.ICIS_STATUSIND = 'P'
                FROM AIRBRANCH.dbo.SSCPFCEMASTER AS m
                INNER JOIN #Modified_CM AS j
                  ON m.STRFCENUMBER = j.APBTRACKINGNUMBER
                     AND j.INSPECTIONTYPECODE IN('FOO', 'FFO');

                UPDATE m
                   SET
                       m.ICIS_STATUSIND = 'P'
                FROM AIRBRANCH.dbo.SSCPITEMMASTER AS m
                INNER JOIN #Modified_CM AS j
                  ON m.STRTRACKINGNUMBER = j.APBTRACKINGNUMBER
                     AND j.INSPECTIONTYPECODE NOT IN('FOO', 'FFO');

            END;

        DROP TABLE #Modified_CM;

        -- Find all new compliance monitoring 
        SELECT cm.AIRFACILITYID
             , cm.COMPLIANCEMONITORINGID
             , cm.APBTRACKINGNUMBER
             , cm.AFSACTIONNUMBER
             , cm.COMPLIANCEMONITORINGDATE
             , cm.ACTIVITYNAME
             , cm.ACTIVITYTYPECODE
             , cm.INSPECTIONTYPECODE
             , cm.AGENCYTYPECODE
             , cm.MONITORINGTYPE
             , cm.APBSHORTACTIVITYNAME
             , cm.APBFACILITYIDDESC
             , cm.FacilityReportedStatusCode
             , cm.AIRPOLLUTANTCODE
        INTO #New_CM
        FROM   AIRBRANCH.dbo.VW_ICIS_COMPLIANCEMONITORING AS cm
        INNER JOIN NETWORKNODEFLOW.dbo.AIRFACILITY AS af
          ON cm.AIRFACILITYID = af.AIRFACILITYID
        WHERE  cm.ICIS_STATUSIND <> 'P'
               AND cm.COMPLIANCEMONITORINGID NOT IN
        (
            SELECT COMPLIANCEMONITORINGID
            FROM   NETWORKNODEFLOW.dbo.COMPLIANCEMONITORING
        );

        IF EXISTS
        (
            SELECT *
            FROM   #New_CM
        )
            BEGIN

                INSERT INTO NETWORKNODEFLOW.dbo.COMPLIANCEMONITORING
                ( COMPLIANCEMONITORINGID
                , ACTIVITYTYPECODE
                , COMPLIANCEMONITORINGDATE
                , INSPECTIONTYPECODE
                , ACTIVITYNAME
                , AGENCYTYPECODE
                , AIRFACILITYID
                , AIRPOLLUTANTCODE
                , INSPECTIONUSERDEFINEDFIELD2
                , INSPECTIONUSERDEFINEDFIELD3
                , FacilityReportedComplianceStatusCode
                , MONITORINGTYPE
                , TRANSACTIONID
                )
                SELECT j.COMPLIANCEMONITORINGID
                     , j.ACTIVITYTYPECODE
                     , j.COMPLIANCEMONITORINGDATE
                     , j.INSPECTIONTYPECODE
                     , j.ACTIVITYNAME
                     , j.AGENCYTYPECODE
                     , j.AIRFACILITYID
                     , j.AIRPOLLUTANTCODE
                     , j.APBSHORTACTIVITYNAME
                     , j.APBFACILITYIDDESC
                     , j.FacilityReportedStatusCode
                     , j.MONITORINGTYPE
                     , NEWID()
                FROM   #New_CM AS j;

                -- ProgramCode 
                INSERT INTO NETWORKNODEFLOW.dbo.COMPLIANCEMONITORINGCODE
                ( COMPLIANCEMONITORINGID
                , CODENAME
                , CODEVALUE
                )
                SELECT cm.COMPLIANCEMONITORINGID
                     , 'ProgramCode'
                     , case
                           when pg.ICIS_PROGRAM_CODE is null then 'CAASIP'
                           else pg.ICIS_PROGRAM_CODE
                       end
                FROM   NETWORKNODEFLOW.dbo.COMPLIANCEMONITORING AS cm
                LEFT JOIN AIRBRANCH.dbo.ICIS_PROGRAM_CODES AS pg
                  ON CONCAT('GA000000', SUBSTRING(pg.STRAIRSNUMBER, 3, 10)) = cm.AIRFACILITYID
                    and pg.OperatingStatusCode <> 'CLS'
                INNER JOIN #New_CM AS j
                  ON cm.COMPLIANCEMONITORINGID = j.COMPLIANCEMONITORINGID;

                -- ComplianceInspectionTypeCode
                INSERT INTO NETWORKNODEFLOW.dbo.COMPLIANCEMONITORINGCODE
                ( COMPLIANCEMONITORINGID
                , CODENAME
                , CODEVALUE
                )
                SELECT cm.COMPLIANCEMONITORINGID
                     , 'ComplianceInspectionTypeCode'
                     , cm.INSPECTIONTYPECODE
                FROM   NETWORKNODEFLOW.dbo.COMPLIANCEMONITORING AS cm
                INNER JOIN #New_CM AS j
                  ON cm.COMPLIANCEMONITORINGID = j.COMPLIANCEMONITORINGID;

                -- AIRSTACKTESTDATA 
                SELECT cm.COMPLIANCEMONITORINGID
                     , ti.STRCOMPLIANCESTATUS
                     , ti.STRTESTINGFIRM
                     , ti.STRWITNESSINGENGINEER
                     , ti.DATRECEIVEDDATE
                     , ti.DATCOMPLETEDATE
                     , ti.DATTESTDATEEND
                INTO #AirStackTestData_New
                FROM   AIRBRANCH.dbo.SSCPITEMMASTER AS mm
                INNER JOIN AIRBRANCH.dbo.SSCPTESTREPORTS AS st
                  ON mm.STRTRACKINGNUMBER = st.STRTRACKINGNUMBER
                INNER JOIN AIRBRANCH.dbo.AFSISMPRECORDS AS afs
                  ON st.STRREFERENCENUMBER = afs.STRREFERENCENUMBER
                INNER JOIN AIRBRANCH.dbo.ISMPREPORTINFORMATION AS ti
                  ON st.STRREFERENCENUMBER = ti.STRREFERENCENUMBER
                INNER JOIN NETWORKNODEFLOW.dbo.COMPLIANCEMONITORING AS cm
                  ON cm.COMPLIANCEMONITORINGID = CONCAT('GA000A0000', SUBSTRING(mm.STRAIRSNUMBER, 3, 10), RIGHT(CONCAT('00000', afs.STRAFSACTIONNUMBER), 5))
                INNER JOIN #New_CM AS j
                  ON cm.COMPLIANCEMONITORINGID = j.COMPLIANCEMONITORINGID
                WHERE  mm.STREVENTTYPE = '03'
                       AND (mm.STRDELETE IS NULL
                            OR mm.STRDELETE NOT LIKE 'True')
                       AND (ti.STRDELETE IS NULL
                            OR ti.STRDELETE NOT LIKE 'DELETE');

                INSERT INTO NETWORKNODEFLOW.dbo.AirStackTestData
                ( COMPLIANCEMONITORINGID
                , STACKTESTSTATUSCODE
                , CONDUCTORTYPECODE
                , OBSERVEDAGENCYTYPECODE
                , REPORTRECEIVEDDATE
                , RESULTSREVIEWEDDATE
                )
                SELECT i.COMPLIANCEMONITORINGID
                     , CASE
                           WHEN i.STRCOMPLIANCESTATUS = '01'
                           THEN 'PEN'
                           WHEN i.STRCOMPLIANCESTATUS = '02'
                           THEN 'PSS'
                           WHEN i.STRCOMPLIANCESTATUS = '03'
                           THEN 'PSS'
                           WHEN i.STRCOMPLIANCESTATUS = '04'
                           THEN 'NA'
                           WHEN i.STRCOMPLIANCESTATUS = '05'
                           THEN 'FAI'
                       END
                     , CASE
                           WHEN i.STRTESTINGFIRM = '00102'
                           THEN 'STE'
                           ELSE 'OOR'
                       END
                     , CASE
                           WHEN i.STRWITNESSINGENGINEER = 0
                           THEN NULL
                           ELSE 'STA'
                       END
                     , CASE
                           WHEN i.DATCOMPLETEDATE < i.DATRECEIVEDDATE
                           THEN NULL
                           WHEN i.DATRECEIVEDDATE < i.DATTESTDATEEND
                           THEN NULL
                           ELSE i.DATRECEIVEDDATE
                       END
                     , CASE
                           WHEN i.DATCOMPLETEDATE < '01-JAN-1970'
                           THEN NULL
                           WHEN i.DATCOMPLETEDATE < i.DATRECEIVEDDATE
                           THEN NULL
                           ELSE i.DATCOMPLETEDATE
                       END
                FROM   #AirStackTestData_New AS i;

                DROP TABLE #AirStackTestData_New;

                -- TVACCREVIEWDATA 
                INSERT INTO NETWORKNODEFLOW.dbo.TVACCREVIEWDATA
                ( TVACCREVIEWEDDATE
                , REVIEWERAGENCYCODE
                , COMPLIANCEMONITORINGID
                )
                SELECT DATEADD(dd, 1, vcm.COMPLIANCEMONITORINGDATE)
                     , 'STA'
                     , vcm.COMPLIANCEMONITORINGID
                FROM   AIRBRANCH.dbo.VW_ICIS_COMPLIANCEMONITORING AS vcm
                INNER JOIN NETWORKNODEFLOW.dbo.COMPLIANCEMONITORING AS cm
                  ON cm.COMPLIANCEMONITORINGID = vcm.COMPLIANCEMONITORINGID
                INNER JOIN #New_CM AS j
                  ON vcm.COMPLIANCEMONITORINGID = j.COMPLIANCEMONITORINGID
                WHERE  vcm.INSPECTIONTYPECODE = 'TVA';

                -- Reset the status indicator to 'P' for "Processed"
                UPDATE m
                   SET
                       m.ICIS_STATUSIND = 'P'
                FROM AIRBRANCH.dbo.SSCPFCEMASTER AS m
                INNER JOIN #New_CM AS j
                  ON m.STRFCENUMBER = j.APBTRACKINGNUMBER
                     AND j.INSPECTIONTYPECODE IN('FOO', 'FFO');

                UPDATE m
                   SET
                       m.ICIS_STATUSIND = 'P'
                FROM AIRBRANCH.dbo.SSCPITEMMASTER AS m
                INNER JOIN #New_CM AS j
                  ON m.STRTRACKINGNUMBER = j.APBTRACKINGNUMBER
                     AND j.INSPECTIONTYPECODE NOT IN('FOO', 'FFO');

            END;

        DROP TABLE #New_CM;

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

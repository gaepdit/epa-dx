USE airbranch;
GO

CREATE OR ALTER VIEW etl.VW_ICIS_COMPLIANCEMONITORING
AS

/**************************************************************************************************

Author:     Doug Waldron
Overview:
  This view organizes Compliance Monitoring information for use by the etl.ICIS_CASEFILE_UPDATE
  and etl.ICIS_CM_UPDATE stored procedures.

Modification History:
When        Who                 What
----------  ------------------  -------------------------------------------------------------------
2024-09-17  DWaldron            Reformatted

***************************************************************************************************/

SELECT /* FCE*/
    CONCAT('GA000000', SUBSTRING(mm.STRAIRSNUMBER, 3, 10)) AS AirFacilityId,
    CONCAT('GA000A0000', SUBSTRING(mm.STRAIRSNUMBER, 3, 10),
           dbo.LPAD(afs.STRAFSACTIONNUMBER, 5, '0'))
                                                           AS ComplianceMonitoringId,
    mm.STRFCENUMBER                                        AS ApbTrackingNumber,
    afs.STRAFSACTIONNUMBER                                 AS AfsActionNumber,
    fce.DATFCECOMPLETED                                    AS ComplianceMonitoringDate,
    IIF(fce.STRSITEINSPECTION = 'False',
        CONCAT('Full Compliance Evaluation, Off-Site, GA EPD Compliance FCE #', mm.STRFCENUMBER),
        CONCAT('Full Compliance Evaluation, On-Site, GA EPD Compliance FCE #', mm.STRFCENUMBER))
                                                           AS ActivityName,
    'INS'                                                  AS ActivityTypeCode,
    IIF(fce.STRSITEINSPECTION = 'False', 'FFO', 'FOO')     AS InspectionTypeCode,
    'STA'                                                  AS AgencyTypeCode,
    'DA'                                                   AS MonitoringType,
    CONCAT('GA EPD Compliance FCE #', mm.STRFCENUMBER)     AS ApbShortActivityName,
    CONCAT('GA EPD Facility ID ', SUBSTRING(mm.STRAIRSNUMBER, 5, 3), '-', SUBSTRING(mm.STRAIRSNUMBER, 8, 5))
                                                           AS ApbFacilityIdDesc,
    NULL                                                   AS FacilityReportedStatusCode,
    NULL                                                   AS AirPollutantCode,
    mm.ICIS_STATUSIND
FROM dbo.AFSSSCPFCERECORDS AS afs
    INNER JOIN dbo.SSCPFCEMASTER AS mm
    ON afs.STRFCENUMBER = mm.STRFCENUMBER
    INNER JOIN dbo.SSCPFCE AS fce
    ON mm.STRFCENUMBER = fce.STRFCENUMBER
where (mm.IsDeleted is null or mm.IsDeleted = 0)

UNION

/* TVACC*/

SELECT CONCAT('GA000000', SUBSTRING(mm.STRAIRSNUMBER, 3, 10)) AS AirFacilityId,
       CONCAT('GA000A0000', SUBSTRING(mm.STRAIRSNUMBER, 3, 10),
              dbo.LPAD(afs.STRAFSACTIONNUMBER, 5, '0'))
                                                              AS ComplianceMonitoringId,
       mm.STRTRACKINGNUMBER                                   AS ApbTrackingNumber,
       afs.STRAFSACTIONNUMBER                                 AS AfsActionNumber,
       DATEADD(D, -1, mm.DATCOMPLETEDATE)                     AS ComplianceMonitoringDate,
       CONCAT('Title V Annual Compliance Certification Review, GA EPD Compliance ACC #', mm.STRTRACKINGNUMBER)
                                                              AS ActivityName,
       'INS'                                                  AS ActivityTypeCode,
       'TVA'                                                  AS InspectionTypeCode,
       'STA'                                                  AS AgencyTypeCode,
       'TVACC'                                                AS MonitoringType,
       CONCAT('GA EPD Compliance #', mm.STRTRACKINGNUMBER)    AS ApbShortActivityName,
       CONCAT('GA EPD Facility ID ', SUBSTRING(mm.STRAIRSNUMBER, 5, 3), '-', SUBSTRING(mm.STRAIRSNUMBER, 8, 5))
                                                              AS ApbFacilityIdDesc,
       IIF(acc.STRREPORTEDDEVIATIONS = 'True', 'INT', 'CON')  AS FacilityReportedStatusCode,
       NULL                                                   AS AirPollutantCode,
       mm.ICIS_STATUSIND
FROM dbo.AFSSSCPRECORDS AS afs
    INNER JOIN dbo.SSCPITEMMASTER AS mm
    ON mm.STRTRACKINGNUMBER = afs.STRTRACKINGNUMBER
    INNER JOIN dbo.SSCPACCS AS acc
    ON mm.STRTRACKINGNUMBER = acc.STRTRACKINGNUMBER
WHERE mm.STREVENTTYPE = '04'
  AND mm.DATCOMPLETEDATE IS NOT NULL
  AND (mm.STRDELETE <> 'True'
    OR mm.STRDELETE IS NULL)

UNION

/* Inspection*/

SELECT CONCAT('GA000000', SUBSTRING(mm.STRAIRSNUMBER, 3, 10)) AS AirFacilityId,
       CONCAT('GA000A0000', SUBSTRING(mm.STRAIRSNUMBER, 3, 10),
              dbo.LPAD(afs.STRAFSACTIONNUMBER, 5, '0'))
                                                              AS ComplianceMonitoringId,
       mm.STRTRACKINGNUMBER                                   AS ApbTrackingNumber,
       afs.STRAFSACTIONNUMBER                                 AS AfsActionNumber,
       ins.DATINSPECTIONDATEEND                               AS ComplianceMonitoringDate,
       CONCAT('State Compliance Inspection, GA EPD Compliance Inspection #', mm.STRTRACKINGNUMBER)
                                                              AS ActivityName,
       'INS'                                                  AS ActivityTypeCode,
       'POR'                                                  AS InspectionTypeCode,
       'STA'                                                  AS AgencyTypeCode,
       'DA'                                                   AS MonitoringType,
       CONCAT('GA EPD Compliance #', mm.STRTRACKINGNUMBER)    AS ApbShortActivityName,
       CONCAT('GA EPD Facility ID ', SUBSTRING(mm.STRAIRSNUMBER, 5, 3), '-', SUBSTRING(mm.STRAIRSNUMBER, 8, 5))
                                                              AS ApbFacilityIdDesc,
       NULL                                                   AS FacilityReportedStatusCode,
       NULL                                                   AS AirPollutantCode,
       mm.ICIS_STATUSIND
FROM dbo.AFSSSCPRECORDS AS afs
    INNER JOIN dbo.SSCPITEMMASTER AS mm
    ON mm.STRTRACKINGNUMBER = afs.STRTRACKINGNUMBER
    INNER JOIN dbo.SSCPINSPECTIONS AS ins
    ON mm.STRTRACKINGNUMBER = ins.STRTRACKINGNUMBER
WHERE mm.STREVENTTYPE = '02'
  AND (mm.STRDELETE <> 'True'
    OR mm.STRDELETE IS NULL)

UNION

/* PCE*/

SELECT CONCAT('GA000000', SUBSTRING(mm.STRAIRSNUMBER, 3, 10)) AS AirFacilityId,
       CONCAT('GA000A0000', SUBSTRING(mm.STRAIRSNUMBER, 3, 10),
              dbo.LPAD(afs.STRAFSACTIONNUMBER, 5, '0'))
                                                              AS ComplianceMonitoringId,
       mm.STRTRACKINGNUMBER                                   AS ApbTrackingNumber,
       afs.STRAFSACTIONNUMBER                                 AS AfsActionNumber,
       mm.DATRECEIVEDDATE                                     AS ComplianceMonitoringDate,
       CONCAT('Periodic Compliance Report Review, GA EPD Compliance Report #', mm.STRTRACKINGNUMBER)
                                                              AS ActivityName,
       'INS'                                                  AS ActivityTypeCode,
       'PFF'                                                  AS InspectionTypeCode,
       'STA'                                                  AS AgencyTypeCode,
       'DA'                                                   AS MonitoringType,
       CONCAT('GA EPD Compliance #', mm.STRTRACKINGNUMBER)    AS ApbShortActivityName,
       CONCAT('GA EPD Facility ID ', SUBSTRING(mm.STRAIRSNUMBER, 5, 3), '-', SUBSTRING(mm.STRAIRSNUMBER, 8, 5))
                                                              AS ApbFacilityIdDesc,
       NULL                                                   AS FacilityReportedStatusCode,
       NULL                                                   AS AirPollutantCode,
       mm.ICIS_STATUSIND
FROM dbo.AFSSSCPRECORDS AS afs
    INNER JOIN dbo.SSCPITEMMASTER AS mm
    ON mm.STRTRACKINGNUMBER = afs.STRTRACKINGNUMBER
WHERE mm.STREVENTTYPE IN ('01', '05')
  AND (mm.STRDELETE <> 'True'
    OR mm.STRDELETE IS NULL)

UNION

/* Stack test*/

SELECT CONCAT('GA000000', SUBSTRING(mm.STRAIRSNUMBER, 3, 10)) AS AirFacilityId,
       CONCAT('GA000A0000', SUBSTRING(mm.STRAIRSNUMBER, 3, 10),
              dbo.LPAD(afs.STRAFSACTIONNUMBER, 5, '0'))
                                                              AS ComplianceMonitoringId,
       mm.STRTRACKINGNUMBER                                   AS ApbTrackingNumber,
       afs.STRAFSACTIONNUMBER                                 AS AfsActionNumber,
       ti.DATTESTDATEEND                                      AS ComplianceMonitoringDate,
       IIF(ti.STRWITNESSINGENGINEER = 0,
           CONCAT('Stack Test Review (Unobserved), GA EPD Compliance Test #', mm.STRTRACKINGNUMBER,
                  ', Reference #', st.STRREFERENCENUMBER),
           CONCAT('Stack Test Review (Observed), GA EPD Compliance Test #', mm.STRTRACKINGNUMBER,
                  ', Reference #', st.STRREFERENCENUMBER))
                                                              AS ActivityName,
       'INS'                                                  AS ActivityTypeCode,
       'CST'                                                  AS InspectionTypeCode,
       'STA'                                                  AS AgencyTypeCode,
       'DA'                                                   AS MonitoringType,
       CONCAT('GA EPD Compliance #', mm.STRTRACKINGNUMBER, ', Test #', st.STRREFERENCENUMBER)
                                                              AS ApbShortActivityName,
       CONCAT('GA EPD Facility ID ', SUBSTRING(mm.STRAIRSNUMBER, 5, 3), '-', SUBSTRING(mm.STRAIRSNUMBER, 8, 5))
                                                              AS ApbFacilityIdDesc,
       NULL                                                   AS FacilityReportedStatusCode,
       lkp.ICIS_POLLUTANT_CODE                                AS AirPollutantCode,
       mm.ICIS_STATUSIND
FROM dbo.SSCPITEMMASTER AS mm
    INNER JOIN dbo.SSCPTESTREPORTS AS st
    ON mm.STRTRACKINGNUMBER = st.STRTRACKINGNUMBER
    INNER JOIN dbo.AFSISMPRECORDS AS afs
    ON st.STRREFERENCENUMBER = afs.STRREFERENCENUMBER
    INNER JOIN dbo.ISMPREPORTINFORMATION AS ti
    ON ti.STRREFERENCENUMBER = st.STRREFERENCENUMBER
    LEFT JOIN dbo.LK_ICIS_POLLUTANT AS lkp
    ON lkp.LGCY_POLLUTANT_CODE = ti.STRPOLLUTANT
WHERE mm.STREVENTTYPE = '03'
  AND (mm.STRDELETE <> 'True'
    OR mm.STRDELETE IS NULL);

GO

USE airbranch;
GO
SET ANSI_NULLS ON;
GO

CREATE OR ALTER VIEW etl.VW_ICIS_ID_REFERENCE
AS

    /***************************************************************************

Author:     Doug Waldron
Created:    2016
Overview:   Returns a list of all EDT record IDs and associated airbranch IDs

Modification History:
When        Who                 What
----------  ------------------  ----------------------------------------
2016-10     DWaldron            Initial Version
2019-12-09  DWaldron            Improved performance

*******************************************************************************/

/* Facility */
SELECT CONCAT('GA000000', SUBSTRING(STRAIRSNUMBER, 3, 10)) AS EDTID,
       SUBSTRING(STRAIRSNUMBER, 5, 8)                      AS IAIPID,
       'AIRFACILITY'                                       AS IDCategory
FROM dbo.APBFACILITYINFORMATION

UNION ALL

/* Case file */
SELECT CONCAT('GA000A0000', SUBSTRING(enf.STRAIRSNUMBER, 3, 10),
              RIGHT(CONCAT('00000', enf.STRAFSKEYACTIONNUMBER), 5)) AS EDTID,
       CAST(enf.STRENFORCEMENTNUMBER AS varchar(6))                 AS IAIPID,
       'CASEFILE'                                                   AS IDCategory
FROM dbo.SSCP_AUDITEDENFORCEMENT AS enf
     INNER JOIN dbo.APBHEADERDATA AS hd
                ON enf.STRAIRSNUMBER = hd.STRAIRSNUMBER
WHERE enf.STRAFSKEYACTIONNUMBER IS NOT NULL
  AND enf.STRACTIONTYPE <> 'LON'
  AND hd.STRAIRPROGRAMCODES NOT LIKE '0000000000000%'
  and (enf.IsDeleted = 0 or enf.IsDeleted is null)

UNION ALL

/* Compliance monitoring */

/* FCE*/
SELECT CONCAT('GA000A0000', SUBSTRING(mm.STRAIRSNUMBER, 3, 10),
              RIGHT(CONCAT('00000', afs.STRAFSACTIONNUMBER), 5)) AS EDTID,
       CAST(mm.STRFCENUMBER AS varchar(6))                       AS IAIPID,
       'COMPLIANCEMONITORINGFCE'                                 AS IDCategory
FROM dbo.AFSSSCPFCERECORDS AS afs
     INNER JOIN dbo.SSCPFCEMASTER AS mm
                ON afs.STRFCENUMBER = mm.STRFCENUMBER
     INNER JOIN dbo.SSCPFCE AS fce
                ON mm.STRFCENUMBER = fce.STRFCENUMBER
where (mm.IsDeleted is null or mm.IsDeleted = 0)

UNION ALL

/* TVACC*/
SELECT CONCAT('GA000A0000', SUBSTRING(mm.STRAIRSNUMBER, 3, 10),
              RIGHT(CONCAT('00000', afs.STRAFSACTIONNUMBER), 5)) AS EDTID,
       CAST(mm.STRTRACKINGNUMBER AS varchar(6))                  AS IAIPID,
       'TVA'                                                     AS InspectionTypeCode
FROM dbo.AFSSSCPRECORDS AS afs
     INNER JOIN dbo.SSCPITEMMASTER AS mm
                ON mm.STRTRACKINGNUMBER = afs.STRTRACKINGNUMBER
     INNER JOIN dbo.SSCPACCS AS acc
                ON mm.STRTRACKINGNUMBER = acc.STRTRACKINGNUMBER
WHERE mm.STREVENTTYPE = '04'
  AND mm.DATCOMPLETEDATE IS NOT NULL
  AND mm.STRDELETE IS NULL

UNION ALL

/* Inspection*/
SELECT CONCAT('GA000A0000', SUBSTRING(mm.STRAIRSNUMBER, 3, 10),
              RIGHT(CONCAT('00000', afs.STRAFSACTIONNUMBER), 5)) AS EDTID,
       CAST(mm.STRTRACKINGNUMBER AS varchar(6))                  AS IAIPID,
       'POR'                                                     AS InspectionTypeCode
FROM dbo.AFSSSCPRECORDS AS afs
     INNER JOIN dbo.SSCPITEMMASTER AS mm
                ON mm.STRTRACKINGNUMBER = afs.STRTRACKINGNUMBER
     INNER JOIN dbo.SSCPINSPECTIONS AS ins
                ON mm.STRTRACKINGNUMBER = ins.STRTRACKINGNUMBER
WHERE mm.STREVENTTYPE = '02'
  AND mm.STRDELETE IS NULL

UNION ALL

/* PCE*/
SELECT CONCAT('GA000A0000', SUBSTRING(mm.STRAIRSNUMBER, 3, 10),
              RIGHT(CONCAT('00000', afs.STRAFSACTIONNUMBER), 5)) AS EDTID,
       CAST(mm.STRTRACKINGNUMBER AS varchar(6))                  AS IAIPID,
       'PFF'                                                     AS InspectionTypeCode
FROM dbo.AFSSSCPRECORDS AS afs
     INNER JOIN dbo.SSCPITEMMASTER AS mm
                ON mm.STRTRACKINGNUMBER = afs.STRTRACKINGNUMBER
WHERE mm.STREVENTTYPE IN ('01', '05')
  AND mm.STRDELETE IS NULL

UNION ALL

/* Stack test*/
SELECT CONCAT('GA000A0000', SUBSTRING(mm.STRAIRSNUMBER, 3, 10),
              RIGHT(CONCAT('00000', afs.STRAFSACTIONNUMBER), 5)) AS EDTID,
       CAST(mm.STRTRACKINGNUMBER AS varchar(6))                  AS IAIPID,
       'CST'                                                     AS InspectionTypeCode
FROM dbo.SSCPITEMMASTER AS mm
     INNER JOIN dbo.SSCPTESTREPORTS AS st
                ON mm.STRTRACKINGNUMBER = st.STRTRACKINGNUMBER
     INNER JOIN dbo.AFSISMPRECORDS AS afs
                ON st.STRREFERENCENUMBER = afs.STRREFERENCENUMBER
WHERE mm.STREVENTTYPE = '03'
  AND mm.STRDELETE IS NULL

UNION ALL

/* Enforcement */

/* NOV*/
SELECT CONCAT('GA000A0000', SUBSTRING(STRAIRSNUMBER, 3, 10),
              RIGHT(CONCAT('00000', STRAFSNOVSENTNUMBER), 5)) AS EDTID,
       CAST(STRENFORCEMENTNUMBER AS varchar(6))               AS IAIPID,
       'ENFORCEMENTACTION'                                    AS IDCategory
FROM dbo.SSCP_AUDITEDENFORCEMENT
WHERE STRNOVSENT = 'True'
  AND STRAFSNOVSENTNUMBER IS NOT NULL
  AND STRAFSKEYACTIONNUMBER IS NOT NULL
  and (IsDeleted = 0 or IsDeleted is null)

UNION ALL

/* CO*/
SELECT CONCAT('GA000A0000', SUBSTRING(STRAIRSNUMBER, 3, 10),
              RIGHT(CONCAT('00000', STRAFSCOEXECUTEDNUMBER), 5)) AS EDTID,
       CAST(STRENFORCEMENTNUMBER AS varchar(6))                  AS IAIPID,
       'ENFORCEMENTACTION'                                       AS IDCategory
FROM dbo.SSCP_AUDITEDENFORCEMENT
WHERE STRCOEXECUTED = 'True'
  AND STRAFSCOEXECUTEDNUMBER IS NOT NULL
  AND STRAFSKEYACTIONNUMBER IS NOT NULL
  and (IsDeleted = 0 or IsDeleted is null)

UNION ALL

/* AO*/
SELECT CONCAT('GA000A0000', SUBSTRING(STRAIRSNUMBER, 3, 10),
              RIGHT(CONCAT('00000', STRAFSAOTOAGNUMBER), 5)) AS EDTID,
       CAST(STRENFORCEMENTNUMBER AS varchar(6))              AS IAIPID,
       'ENFORCEMENTACTION'                                   AS IDCategory
FROM dbo.SSCP_AUDITEDENFORCEMENT
WHERE STRAOEXECUTED = 'True'
  AND STRAFSAOTOAGNUMBER IS NOT NULL
  AND STRAFSKEYACTIONNUMBER IS NOT NULL
  and (IsDeleted = 0 or IsDeleted is null)

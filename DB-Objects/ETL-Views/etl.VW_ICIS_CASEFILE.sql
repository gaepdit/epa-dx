USE airbranch;
GO
SET ANSI_NULLS ON;
GO

CREATE OR ALTER VIEW etl.VW_ICIS_CASEFILE
AS

/**************************************************************************************************

Author:     Doug Waldron
Overview:
  This view organizes Case File information for use by the etl.ICIS_CASEFILE_UPDATE
  stored procedure.

Modification History:
When        Who                 What
----------  ------------------  -------------------------------------------------------------------
2024-09-17  DWaldron            Reformatted

***************************************************************************************************/

SELECT CONCAT('GA000A0000', SUBSTRING(enf.STRAIRSNUMBER, 3, 10),
              dbo.LPAD(enf.STRAFSKEYACTIONNUMBER, 5, '0')) AS CaseFileId,
       CONCAT('GA000000', SUBSTRING(enf.STRAIRSNUMBER, 3,
                                    10))                   AS AirFacilityId,
       enf.STRENFORCEMENTNUMBER                            AS EnforcementNumber,
       CASE
           WHEN lvt.SEVERITYCODE = 'HPV'
               THEN CONCAT('Case File, High Priority Violation, GA EPD Enforcement # ',
                           enf.STRENFORCEMENTNUMBER)
           WHEN lvt.SEVERITYCODE = 'FRV'
               THEN CONCAT('Case File, Federally Reportable Violation, GA EPD Enforcement # ',
                           enf.STRENFORCEMENTNUMBER)
           ELSE CONCAT('Case File, Violation not federally reportable, GA EPD Enforcement # ',
                       enf.STRENFORCEMENTNUMBER)
       END                                                 AS CaseFileName,
       CONCAT('GA EPD Enforcement #',
              enf.STRENFORCEMENTNUMBER)                    AS ApbShortActivityName,
       CONCAT('GA EPD Facility ID ',
              SUBSTRING(enf.STRAIRSNUMBER, 5, 3),
              '-',
              SUBSTRING(enf.STRAIRSNUMBER, 8,
                        5))                                AS ApbFacilityIdDesc,
       CASE
           WHEN enf.STRNOVSENT = 'True' OR enf.STRCOPROPOSED = 'True'
               THEN 'LTR'
           ELSE NULL
       END                                                 AS AdvisementMethodTypeCode,
       CASE
           WHEN enf.STRNOVSENT = 'True'
               THEN enf.DATNOVSENT
           WHEN enf.STRCOPROPOSED = 'True'
               THEN enf.DATCOPROPOSED
           ELSE NULL
       END                                                 AS AdvisementMethodDate,
       enf.STRHPV                                          AS AirViolationTypeCode,
       CASE
           WHEN enf.STRDAYZERO = 'True' AND lvt.SEVERITYCODE = 'HPV'
               then enf.DATDAYZERO
           else dbo.LeastDate(enf.DATNOVSENT,
                              dbo.LeastDate(enf.DATCOPROPOSED,
                                            dbo.LeastDate(enf.DATCOEXECUTED, enf.DATAOEXECUTED)))
       end                                                 AS FrvDeterminationDate,
       CASE
           WHEN enf.STRDAYZERO = 'True' AND lvt.SEVERITYCODE = 'HPV'
               THEN enf.DATDAYZERO
           ELSE NULL
       END                                                 AS HpvDayZeroDate,
       CASE
           WHEN enf.STRNOVSENT = 'False' AND enf.STRCOEXECUTED = 'False' AND enf.STRAOEXECUTED = 'False'
               THEN 'Y'
           ELSE 'N'
       END                                                 AS SensitiveDataIndicator,
       enf.ICIS_STATUSIND,
       lvt.SEVERITYCODE
FROM SSCP_AUDITEDENFORCEMENT AS enf
    INNER JOIN APBHEADERDATA AS hd
    ON enf.STRAIRSNUMBER = hd.STRAIRSNUMBER
    INNER JOIN LK_VIOLATION_TYPE AS lvt
    ON enf.STRHPV = lvt.AIRVIOLATIONTYPECODE
WHERE enf.STRAFSKEYACTIONNUMBER IS NOT NULL
  AND enf.STRACTIONTYPE <> 'LON'
  AND hd.STRAIRPROGRAMCODES NOT LIKE '0000000000000%'
  and (enf.IsDeleted = 0 or enf.IsDeleted is null);

GO

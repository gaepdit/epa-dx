USE airbranch;
GO
SET ANSI_NULLS ON;
GO

CREATE OR ALTER VIEW etl.VW_ICIS_ENFORCEMENTACTION
AS

/**************************************************************************************************

Author:     Doug Waldron
Overview:
  This view organizes Enforcement Action information for use by the etl.ICIS_CASEFILE_UPDATE
  stored procedure.

Modification History:
When        Who                 What
----------  ------------------  -------------------------------------------------------------------
2024-09-17  DWaldron            Reformatted
2024-09-20  DWaldron            Handle Proposed COs as if they were NOVs (icis-air #85)

***************************************************************************************************/

SELECT /* NOV */
    CONCAT('GA000A0000', SUBSTRING(STRAIRSNUMBER, 3, 10),
           dbo.LPAD(STRAFSNOVSENTNUMBER, 5, 0))
                                   AS ENFORCEMENTACTIONID,
    CONCAT('GA000A0000', SUBSTRING(STRAIRSNUMBER, 3, 10),
           dbo.LPAD(STRAFSKEYACTIONNUMBER, 5, 0))
                                   AS CASEFILEID,
    CONCAT('GA000000', SUBSTRING(STRAIRSNUMBER, 3, 10))
                                   AS AIRFACILITYID,
    'NOV'                          AS EATYPECODE,
    CONCAT('Notice of Violation, GA EPD Enforcement #', STRENFORCEMENTNUMBER)
                                   AS EnforcementActionName,
    STRENFORCEMENTNUMBER           AS ApbEnforcementNumber,
    SUBSTRING(STRAIRSNUMBER, 5, 8) AS AIRSNUMBER,
    STRAFSKEYACTIONNUMBER          AS AFSKEYACTIONNUMBER,
    STRAFSNOVSENTNUMBER            AS AFSACTIONNUMBER,
    STRNOVSENT,
    DATNOVSENT,
    STRNFALETTERSENT,
    DATNFALETTERSENT,
    NULL                           AS STRCOEXECUTED,
    NULL                           AS DATCOEXECUTED,
    NULL                           AS STRCOPENALTYAMOUNT,
    NULL                           AS STRCORESOLVED,
    NULL                           AS DATCORESOLVED,
    NULL                           AS STRAOAPPEALED,
    NULL                           AS DATAOAPPEALED,
    NULL                           AS STRAOEXECUTED,
    NULL                           AS DATAOEXECUTED,
    NULL                           AS STRAORESOLVED,
    NULL                           AS DATAORESOLVED,
    CONCAT('GA EPD Enforcement #', STRENFORCEMENTNUMBER)
                                   AS ApbShortActivityName,
    CONCAT('GA EPD Facility ID ', SUBSTRING(STRAIRSNUMBER, 5, 3), '-', SUBSTRING(STRAIRSNUMBER, 8, 5))
                                   AS ApbFacilityIdDesc,
    ICIS_STATUSIND
FROM SSCP_AUDITEDENFORCEMENT
WHERE STRNOVSENT = 'True'
  AND STRAFSNOVSENTNUMBER IS NOT NULL
  AND STRAFSKEYACTIONNUMBER IS NOT NULL
  and (IsDeleted = 0 or IsDeleted is null)
UNION

/* Proposed CO (as NOV) */
SELECT CONCAT('GA000A0000', SUBSTRING(STRAIRSNUMBER, 3, 10),
              dbo.LPAD(STRAFSCOPROPOSEDNUMBER, 5, 0))
                                      AS ENFORCEMENTACTIONID,
       CONCAT('GA000A0000', SUBSTRING(STRAIRSNUMBER, 3, 10),
              dbo.LPAD(STRAFSKEYACTIONNUMBER, 5, 0))
                                      AS CASEFILEID,
       CONCAT('GA000000', SUBSTRING(STRAIRSNUMBER, 3, 10))
                                      AS AIRFACILITYID,
       'NOV'                          AS EATYPECODE, -- Keep this as 'NOV'.
       CONCAT('Proposed Consent Order, GA EPD Enforcement #', STRENFORCEMENTNUMBER)
                                      AS EnforcementActionName,
       STRENFORCEMENTNUMBER           AS ApbEnforcementNumber,
       SUBSTRING(STRAIRSNUMBER, 5, 8) AS AIRSNUMBER,
       STRAFSKEYACTIONNUMBER          AS AFSKEYACTIONNUMBER,
       STRAFSCOPROPOSEDNUMBER         AS AFSACTIONNUMBER,
       STRCOPROPOSED                  as STRNOVSENT,
       DATCOPROPOSED                  as DATNOVSENT,
       NULL                           AS STRNFALETTERSENT, -- Currently, NFAs are only added to primary NOVs (not Proposed COs sent as NOVs), but this could change in the future.
       NULL                           AS DATNFALETTERSENT,
       NULL                           AS STRCOEXECUTED,
       NULL                           AS DATCOEXECUTED,
       NULL                           AS STRCOPENALTYAMOUNT,
       NULL                           AS STRCORESOLVED,
       NULL                           AS DATCORESOLVED,
       NULL                           AS STRAOAPPEALED,
       NULL                           AS DATAOAPPEALED,
       NULL                           AS STRAOEXECUTED,
       NULL                           AS DATAOEXECUTED,
       NULL                           AS STRAORESOLVED,
       NULL                           AS DATAORESOLVED,
       CONCAT('GA EPD Enforcement #', STRENFORCEMENTNUMBER)
                                      AS ApbShortActivityName,
       CONCAT('GA EPD Facility ID ', SUBSTRING(STRAIRSNUMBER, 5, 3), '-', SUBSTRING(STRAIRSNUMBER, 8, 5))
                                      AS ApbFacilityIdDesc,
       ICIS_STATUSIND
FROM SSCP_AUDITEDENFORCEMENT
WHERE STRCOPROPOSED = 'True' -- Send Proposed CO as NOV
  AND STRAFSCOPROPOSEDNUMBER IS NOT NULL
  AND STRAFSKEYACTIONNUMBER IS NOT NULL
  and (IsDeleted = 0 or IsDeleted is null)
 UNION

/* CO */
SELECT CONCAT('GA000A0000', SUBSTRING(STRAIRSNUMBER, 3, 10),
              dbo.LPAD(STRAFSCOEXECUTEDNUMBER, 5, 0))
                                       AS ENFORCEMENTACTIONID,
       CONCAT('GA000A0000', SUBSTRING(STRAIRSNUMBER, 3, 10),
              dbo.LPAD(STRAFSKEYACTIONNUMBER, 5, 0))
                                       AS CASEFILEID,
       CONCAT('GA000000', SUBSTRING(STRAIRSNUMBER, 3, 10))
                                       AS AIRFACILITYID,
       'SCAAAO'                        AS EATYPECODE,
       IIF(STRCONUMBER IS NOT NULL,
           CONCAT('Consent Order, GA EPD Enforcement #', STRENFORCEMENTNUMBER, ', Order #', STRCONUMBER),
           CONCAT('Consent Order, GA EPD Enforcement #', STRENFORCEMENTNUMBER))
                                       AS EnforcementActionName,
       STRENFORCEMENTNUMBER            AS ApbEnforcementNumber,
       SUBSTRING(STRAIRSNUMBER, 5, 12) AS AIRSNUMBER,
       STRAFSKEYACTIONNUMBER           AS AFSKEYACTIONNUMBER,
       STRAFSCOEXECUTEDNUMBER          AS AFSACTIONNUMBER,
       NULL                            AS STRNOVSENT,
       NULL                            AS DATNOVSENT,
       NULL                            AS STRNFALETTERSENT,
       NULL                            AS DATNFALETTERSENT,
       STRCOEXECUTED,
       DATCOEXECUTED,
       STRCOPENALTYAMOUNT,
       STRCORESOLVED,
       DATCORESOLVED,
       NULL                            AS STRAOAPPEALED,
       NULL                            AS DATAOAPPEALED,
       NULL                            AS STRAOEXECUTED,
       NULL                            AS DATAOEXECUTED,
       NULL                            AS STRAORESOLVED,
       NULL                            AS DATAORESOLVED,
       CONCAT('GA EPD Enforcement #', STRENFORCEMENTNUMBER)
                                       AS ApbShortActivityName,
       CONCAT('GA EPD Facility ID ', SUBSTRING(STRAIRSNUMBER, 5, 3), '-', SUBSTRING(STRAIRSNUMBER, 8, 15))
                                       AS ApbFacilityIdDesc,
       ICIS_STATUSIND
FROM SSCP_AUDITEDENFORCEMENT
WHERE STRCOEXECUTED = 'True'
  AND STRAFSCOEXECUTEDNUMBER IS NOT NULL
  AND STRAFSKEYACTIONNUMBER IS NOT NULL
  and (IsDeleted = 0 or IsDeleted is null)
UNION

/* AO */
SELECT CONCAT('GA000A0000', SUBSTRING(STRAIRSNUMBER, 3, 10),
              dbo.LPAD(STRAFSAOTOAGNUMBER, 5, 0))
                                       AS ENFORCEMENTACTIONID,
       CONCAT('GA000A0000', SUBSTRING(STRAIRSNUMBER, 3, 10),
              dbo.LPAD(STRAFSKEYACTIONNUMBER, 5, 0))
                                       AS CASEFILEID,
       CONCAT('GA000000', SUBSTRING(STRAIRSNUMBER, 3, 10))
                                       AS AIRFACILITYID,
       'CIV'                           AS EATYPECODE,
       IIF(STRCONUMBER IS NOT NULL,
           CONCAT('Administrative Order, GA EPD Enforcement #', STRENFORCEMENTNUMBER, ', Order #', STRCONUMBER),
           CONCAT('Administrative Order, GA EPD Enforcement #', STRENFORCEMENTNUMBER))
                                       AS EnforcementActionName,
       STRENFORCEMENTNUMBER            AS ApbEnforcementNumber,
       SUBSTRING(STRAIRSNUMBER, 5, 12) AS AIRSNUMBER,
       STRAFSKEYACTIONNUMBER           AS AFSKEYACTIONNUMBER,
       STRAFSAOTOAGNUMBER              AS AFSACTIONNUMBER,
       NULL                            AS STRNOVSENT,
       NULL                            AS DATNOVSENT,
       NULL                            AS STRNFALETTERSENT,
       NULL                            AS DATNFALETTERSENT,
       NULL                            AS STRCOEXECUTED,
       NULL                            AS DATCOEXECUTED,
       NULL                            AS STRCOPENALTYAMOUNT,
       NULL                            AS STRCORESOLVED,
       NULL                            AS DATCORESOLVED,
       STRAOAPPEALED,
       DATAOAPPEALED,
       STRAOEXECUTED,
       DATAOEXECUTED,
       STRAORESOLVED,
       DATAORESOLVED,
       CONCAT('GA EPD Enforcement #', STRENFORCEMENTNUMBER)
                                       AS ApbShortActivityName,
       CONCAT('GA EPD Facility ID ', SUBSTRING(STRAIRSNUMBER, 5, 3), '-', SUBSTRING(STRAIRSNUMBER, 8, 5))
                                       AS ApbFacilityIdDesc,
       ICIS_STATUSIND
FROM SSCP_AUDITEDENFORCEMENT
WHERE STRAOEXECUTED = 'True'
  AND STRAFSAOTOAGNUMBER IS NOT NULL
  AND STRAFSKEYACTIONNUMBER IS NOT NULL
  and (IsDeleted = 0 or IsDeleted is null);

GO

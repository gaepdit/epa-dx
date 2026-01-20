USE airbranch;
GO
SET ANSI_NULLS ON;
GO

CREATE OR ALTER PROCEDURE etl.ICIS_CASEFILE_UPDATE
AS

/**************************************************************************************************

Author:     Vidyanand Dhande
Overview:   Processes Case file / enforcement updates for ICIS-Air

This procedure inserts the individual data families in order, then resets
the status indicator.

A lot has to happen for each record in AIRBRANCH.SSCP_AUDITEDENFORCEMENT.
There is only one status indicator column in the table, but many data
families are affected.

Tables written to:
    NETWORKNODEFLOW.dbo.CASEFILE
    NETWORKNODEFLOW.dbo.CASEFILECODE
    NETWORKNODEFLOW.dbo.AIRVIOLATIONDATA
    NETWORKNODEFLOW.dbo.OTHERPATHWAYACTIVITYDATA
    NETWORKNODEFLOW.dbo.ENFORCEMENTACTION
    NETWORKNODEFLOW.dbo.EnforcementActionAirFacility
    NETWORKNODEFLOW.dbo.CASEFILE2DAEALINK
    NETWORKNODEFLOW.dbo.ENFORCEMENTACTIONCODE
    NETWORKNODEFLOW.dbo.AIRDAFINALORDER
    NETWORKNODEFLOW.dbo.AIRDAFINALORDERAIRFACILITY
    NETWORKNODEFLOW.dbo.EnforcementActionMilestone
    NETWORKNODEFLOW.dbo.CASEFILE2CMLINK
    AIRBRANCH.dbo.SSCP_AUDITEDENFORCEMENT

Tables accessed:
    AIRBRANCH.dbo.VW_ICIS_CASEFILE
    AIRBRANCH.dbo.VW_ICIS_ENFORCEMENTACTION
    airbranch.dbo.ICIS_CASEFILE_CODES

Modification History:
When        Who                 What
----------  ------------------  -------------------------------------------------------------------
Previously  DWaldron            Initially created in Oracle
2016-06-29  VDhande             Migrated to SQL Server
2017-05-24  DWaldron            Add code to populate Final Order Identifier (DX-14)
2017-10-31  DWaldron            Update Case File-Enforcement Action/CM linkages any time a case
                                file gets updated (ensures broken linkages get fixed) (DX-39)
2017-11-02  DWaldron            Allow multiple Compliance Monitoring linkages for Case Files
                                (IAIP-442)
2018-12-01  DWaldron            Fix missing FinalOrderIdentifier in Enf Actions -- Only affected
                                Case Files where final order exists when Case File first inserted.
                                (DX-73)
2024-09-17  DWaldron            Reformatted
2024-09-20  DWaldron            Handle Proposed COs as if they were NOVs (icis-air #85)

***************************************************************************************************/

    SET XACT_ABORT, NOCOUNT ON
BEGIN TRY

    BEGIN TRANSACTION;

    /* *** PART I: All modified Case Files *** */

    SELECT cf.CASEFILEID,
           cf.AIRFACILITYID,
           cf.CASEFILENAME,
           cf.APBSHORTACTIVITYNAME,
           cf.APBFACILITYIDDESC,
           cf.ADVISEMENTMETHODTYPECODE,
           cf.ADVISEMENTMETHODDATE,
           cf.SENSITIVEDATAINDICATOR,
           cf.ENFORCEMENTNUMBER
    INTO #Modified_Case_Files
    FROM AIRBRANCH.dbo.VW_ICIS_CASEFILE AS cf
        INNER JOIN NETWORKNODEFLOW.dbo.AIRFACILITY AS af
        ON cf.AIRFACILITYID = af.AIRFACILITYID
    WHERE cf.ICIS_STATUSIND <> 'P'
      AND cf.CaseFileId IN
          (SELECT CASEFILEID
           FROM NETWORKNODEFLOW.dbo.CASEFILE);

    IF EXISTS
        (SELECT *
         FROM #Modified_Case_Files)
        BEGIN

            -- Case File
            UPDATE c
            SET c.CASEFILENAME              = j.CASEFILENAME,
                c.AIRFACILITYID             = j.AIRFACILITYID,
                c.SensitiveDataIndicator    = j.SENSITIVEDATAINDICATOR,
                c.ADVISEMENTMETHODTYPECODE  = j.ADVISEMENTMETHODTYPECODE,
                c.ADVISEMENTMETHODDATE      = j.ADVISEMENTMETHODDATE,
                c.CASEFILEUSERDEFINEDFIELD2 = j.APBSHORTACTIVITYNAME,
                c.CASEFILEUSERDEFINEDFIELD3 = j.APBFACILITYIDDESC
            FROM NETWORKNODEFLOW.dbo.CASEFILE c
                INNER JOIN #Modified_Case_Files AS j
                ON c.CASEFILEID = j.CASEFILEID;

            -- Delete and reinsert program codes to ensure only current codes are used
            DELETE c
            FROM NETWORKNODEFLOW.dbo.CASEFILECODE c
                INNER JOIN #Modified_Case_Files AS j
                ON c.CASEFILEID = j.CASEFILEID
            WHERE c.CODENAME = 'ProgramCode';

            SELECT DISTINCT acf.ICIS_PROGRAM_CODE,
                            icf.CASEFILEID
            INTO #Program_Codes
            FROM airbranch.dbo.ICIS_CASEFILE_CODES AS acf
                RIGHT JOIN NETWORKNODEFLOW.dbo.CASEFILE AS icf
                ON icf.CASEFILEID = acf.CASEFILEID
                INNER JOIN #Modified_Case_Files AS j
                ON icf.CASEFILEID = j.CASEFILEID;

            INSERT INTO NETWORKNODEFLOW.dbo.CASEFILECODE
                (CASEFILECODEID,
                 CASEFILEID,
                 CODENAME,
                 CODEVALUE)
            SELECT NEWID(),
                   i.CASEFILEID,
                   'ProgramCode',
                   ISNULL(i.ICIS_PROGRAM_CODE, 'CAASIP')
            FROM #Program_Codes AS i;

            DROP TABLE #Program_Codes;

            -- Delete and reinsert pollutant codes to ensure only current codes are used
            DELETE c
            FROM NETWORKNODEFLOW.dbo.CASEFILECODE c
                INNER JOIN #Modified_Case_Files AS j
                ON c.CASEFILEID = j.CASEFILEID
            WHERE c.CODENAME = 'AirPollutantCode';

            SELECT DISTINCT acf.ICIS_POLLUTANT_CODE,
                            acf.CASEFILEID
            INTO #Pollutant_Code
            FROM AIRBRANCH.dbo.ICIS_CASEFILE_CODES AS acf
                INNER JOIN NETWORKNODEFLOW.dbo.CASEFILE AS icf
                ON icf.CASEFILEID = acf.CASEFILEID
                INNER JOIN #Modified_Case_Files AS j
                ON icf.CASEFILEID = j.CASEFILEID
            WHERE acf.ICIS_POLLUTANT_CODE IS NOT NULL;

            INSERT INTO NETWORKNODEFLOW.dbo.CASEFILECODE
                (CASEFILECODEID,
                 CASEFILEID,
                 CODENAME,
                 CODEVALUE)
            SELECT NEWID(),
                   i.CASEFILEID,
                   'AirPollutantCode',
                   i.ICIS_POLLUTANT_CODE
            FROM #Pollutant_Code AS i;

            DROP TABLE #Pollutant_Code;

            -- Delete and reinsert air violation data to ensure only current data is used
            DELETE a
            FROM NETWORKNODEFLOW.dbo.AIRVIOLATIONDATA a
                INNER JOIN #Modified_Case_Files AS j
                ON a.CASEFILEID = j.CASEFILEID;

            SELECT acf.CASEFILEID,
                   acf.AIRVIOLATIONTYPECODE,
                   acf.FRVDETERMINATIONDATE,
                   acf.HPVDAYZERODATE,
                   cc.ICIS_PROGRAM_CODE   AS ProgramCode,
                   cc.ICIS_POLLUTANT_CODE AS PollutantCode
            INTO #Air_Violation_Data
            FROM AIRBRANCH.dbo.VW_ICIS_CASEFILE AS acf
                INNER JOIN AIRBRANCH.dbo.ICIS_CASEFILE_CODES AS cc
                ON acf.CASEFILEID = cc.CASEFILEID
            WHERE acf.CaseFileId IN
                  (SELECT CaseFileId
                   FROM #Modified_Case_Files);

            INSERT INTO NETWORKNODEFLOW.dbo.AIRVIOLATIONDATA
                (AIRVIOLATIONDATAID,
                 CASEFILEID,
                 AIRVIOLATIONTYPECODE,
                 AIRVIOLATIONPROGRAMCODE,
                 AIRVIOLATIONPOLLUTANTCODE,
                 FRVDETERMINATIONDATE,
                 HPVDAYZERODATE)
            SELECT NEWID(),
                   i.CASEFILEID,
                   i.AIRVIOLATIONTYPECODE,
                   ISNULL(i.ProgramCode, 'CAASIP'),
                   i.PollutantCode,
                   i.FRVDETERMINATIONDATE,
                   i.HPVDAYZERODATE
            FROM #Air_Violation_Data AS i;

            DROP TABLE #Air_Violation_Data;

            -- Delete and reinsert "other pathway activity" data ('ADDR' and 'RSLV')
            -- to ensure only current data is used
            DELETE t
            FROM NETWORKNODEFLOW.dbo.OTHERPATHWAYACTIVITYDATA t
                INNER JOIN #Modified_Case_Files AS j
                ON t.CASEFILEID = j.CASEFILEID;

            SELECT ae.CASEFILEID,
                   ae.DATNFALETTERSENT
            INTO #ADDR_RSLV_i
            FROM AIRBRANCH.dbo.VW_ICIS_ENFORCEMENTACTION AS ae
                INNER JOIN NETWORKNODEFLOW.dbo.CASEFILE cf
                ON ae.CASEFILEID = cf.CASEFILEID
                INNER JOIN #Modified_Case_Files AS j
                ON ae.CASEFILEID = j.CASEFILEID
            WHERE ae.EATYPECODE = 'NOV'
              AND ae.STRNFALETTERSENT = 'True';

            -- First, insert 'ADDR'
            INSERT INTO NETWORKNODEFLOW.dbo.OTHERPATHWAYACTIVITYDATA
                (OTHERPATHWAYACTIVITYDATAID,
                 CASEFILEID,
                 OTHERPATHWAYCATEGORYCODE,
                 OTHERPATHWAYTYPECODE,
                 OTHERPATHWAYDATE)
            SELECT NEWID(),
                   i.CASEFILEID,
                   'ADDR',
                   'NAN',
                   i.DATNFALETTERSENT
            FROM #ADDR_RSLV_i AS i;

            -- Second, insert 'RSLV'
            INSERT INTO NETWORKNODEFLOW.dbo.OTHERPATHWAYACTIVITYDATA
                (OTHERPATHWAYACTIVITYDATAID,
                 CASEFILEID,
                 OTHERPATHWAYCATEGORYCODE,
                 OTHERPATHWAYTYPECODE,
                 OTHERPATHWAYDATE)
            SELECT NEWID(),
                   i.CASEFILEID,
                   'RSLV',
                   'NAN',
                   i.DATNFALETTERSENT
            FROM #ADDR_RSLV_i AS i;

            DROP TABLE #ADDR_RSLV_i;

            -- Update existing enforcement actions for the modified case files
            SELECT ea.ENFORCEMENTACTIONID,
                   ea.EATYPECODE,
                   ea.ENFORCEMENTACTIONNAME,
                   ea.DATNOVSENT,
                   ea.APBSHORTACTIVITYNAME,
                   ea.APBFACILITYIDDESC,
                   ea.AIRFACILITYID
            INTO #Modified_Enforcement_Actions
            FROM AIRBRANCH.dbo.VW_ICIS_ENFORCEMENTACTION AS ea
                INNER JOIN NETWORKNODEFLOW.dbo.AIRFACILITY AS af
                ON ea.AIRFACILITYID = af.AIRFACILITYID
                INNER JOIN #Modified_Case_Files AS j
                ON ea.CASEFILEID = j.CASEFILEID
            WHERE ea.ENFORCEMENTACTIONID IN
                  (SELECT ENFORCEMENTACTIONID
                   FROM NETWORKNODEFLOW.dbo.ENFORCEMENTACTION);

            UPDATE E
            SET E.EnforcementActionTypeCode = i.EATYPECODE,
                E.EnforcementActionName     = i.EnforcementActionName,
                E.FORUM                     = CASE
                                                  WHEN i.EATYPECODE = 'SCAAAO' -- Non-judicial
                                                      THEN 'AFR'
                                                  WHEN i.EATYPECODE = 'CIV' -- Judicial
                                                      THEN 'JDC'
                                              END,
                E.ACHIEVEDDATE              = CASE -- (NOV and Proposed CO)
                                                  WHEN i.EATYPECODE = 'NOV'
                                                      THEN i.DATNOVSENT
                                              END,
                EAUSERDEFINEDFIELD2         = i.ApbShortActivityName,
                EAUSERDEFINEDFIELD3         = i.ApbFacilityIdDesc,
                TYPE                        = IIF(i.EATYPECODE = 'NOV', 'DAInFormal', 'DAFormal')
            FROM NETWORKNODEFLOW.dbo.ENFORCEMENTACTION E
                INNER JOIN #Modified_Enforcement_Actions AS i
                ON E.ENFORCEMENTACTIONID = i.ENFORCEMENTACTIONID;

            -- Update any existing case file to enforcement action linkages
            -- to ensure linkage is resubmitted (in case it got broken or rejected
            -- previously). This does not change the value but causes the update
            -- trigger to fire, which adds the linkage to the SubmissionStatus table.
            UPDATE lnk
            SET CaseFileId = lnk.CaseFileId
            FROM NETWORKNODEFLOW.dbo.CaseFile2DAEALink lnk
                INNER JOIN #Modified_Enforcement_Actions AS i
                ON lnk.EnforcementActionId = i.ENFORCEMENTACTIONID;

            DROP TABLE #Modified_Enforcement_Actions;

            -- Add new enforcement actions for the modified case files
            SELECT ea.ENFORCEMENTACTIONID,
                   ea.CASEFILEID,
                   ea.EATYPECODE,
                   ea.ENFORCEMENTACTIONNAME,
                   ea.DATNOVSENT,
                   ea.APBSHORTACTIVITYNAME,
                   ea.APBFACILITYIDDESC,
                   ea.AIRFACILITYID
            INTO #New_Enforcement_Actions
            FROM AIRBRANCH.dbo.VW_ICIS_ENFORCEMENTACTION AS ea
                INNER JOIN NETWORKNODEFLOW.dbo.AIRFACILITY AS af
                ON ea.AIRFACILITYID = af.AIRFACILITYID
                INNER JOIN #Modified_Case_Files AS j
                ON ea.CaseFileId = j.CASEFILEID
            WHERE ea.ENFORCEMENTACTIONID NOT IN
                  (SELECT ENFORCEMENTACTIONID
                   FROM NETWORKNODEFLOW.dbo.ENFORCEMENTACTION);

            IF EXISTS
                (SELECT *
                 FROM #New_Enforcement_Actions)
                BEGIN

                    -- First Enforcement Actions
                    INSERT INTO NETWORKNODEFLOW.dbo.ENFORCEMENTACTION
                        (ENFORCEMENTACTIONID,
                         EnforcementActionTypeCode,
                         EnforcementActionName,
                         Forum,
                         AchievedDate,
                         EAUserDefinedField2,
                         EAUserDefinedField3,
                         LeadAgencyCode,
                         Type,
                         TransactionID)
                    SELECT i.ENFORCEMENTACTIONID,
                           i.EATYPECODE,
                           i.EnforcementActionName,
                           CASE
                               WHEN i.EATYPECODE = 'SCAAAO' -- Non-judicial
                                   THEN 'AFR'
                               WHEN i.EATYPECODE = 'CIV' -- Judicial
                                   THEN 'JDC'
                           END,
                           CASE -- (NOV and Proposed CO)
                               WHEN i.EATYPECODE = 'NOV'
                                   THEN i.DATNOVSENT
                           END,
                           i.ApbShortActivityName,
                           i.ApbFacilityIdDesc,
                           'ST4',
                           IIF(i.EATYPECODE = 'NOV', 'DAInFormal', 'DAFormal'),
                           NEWID()
                    FROM #New_Enforcement_Actions AS i;

                    -- Second, Enforcement Action Facilities
                    INSERT INTO NETWORKNODEFLOW.dbo.EnforcementActionAirFacility
                        (ENFORCEMENTACTIONID,
                         AIRFACILITYID)
                    SELECT i.ENFORCEMENTACTIONID,
                           i.AIRFACILITYID
                    FROM #New_Enforcement_Actions AS i;

                    -- Third, Case File to Enforcement Action linkage
                    INSERT INTO NETWORKNODEFLOW.dbo.CASEFILE2DAEALINK
                        (CASEFILEID,
                         ENFORCEMENTACTIONID,
                         TRANSACTIONID)
                    SELECT i.CASEFILEID,
                           i.ENFORCEMENTACTIONID,
                           NEWID()
                    FROM #New_Enforcement_Actions AS i;

                END;

            DROP TABLE #New_Enforcement_Actions;

            -- All enforcement actions related to modified case files
            SELECT ea.ENFORCEMENTACTIONID
            INTO #Enforcement_Actions
            FROM AIRBRANCH.dbo.VW_ICIS_ENFORCEMENTACTION AS ea
                INNER JOIN NETWORKNODEFLOW.dbo.AIRFACILITY AS af
                ON ea.AIRFACILITYID = af.AIRFACILITYID
                INNER JOIN #Modified_Case_Files AS j
                ON ea.CASEFILEID = j.CASEFILEID;

            IF EXISTS
                (SELECT *
                 FROM #Enforcement_Actions)
                BEGIN

                    -- Delete and reinsert all enforcement actions codes (program, pollutant,
                    -- and enforcement action type codes)
                    DELETE e
                    FROM NETWORKNODEFLOW.dbo.ENFORCEMENTACTIONCODE e
                        INNER JOIN #Enforcement_Actions AS k
                        ON e.ENFORCEMENTACTIONID = k.ENFORCEMENTACTIONID
                    WHERE e.CodeName IN ('ProgramsViolatedCode', 'AirPollutantCode', 'EnforcementActionTypeCode');

                    -- Program and pollutant codes
                    SELECT ae.ENFORCEMENTACTIONID,
                           cc.CODENAME,
                           cc.CODEVALUE
                    INTO #EA_pollutant_codes
                    FROM AIRBRANCH.dbo.VW_ICIS_ENFORCEMENTACTION AS ae
                        INNER JOIN NETWORKNODEFLOW.dbo.ENFORCEMENTACTION AS ie
                        ON ie.ENFORCEMENTACTIONID = ae.ENFORCEMENTACTIONID
                        INNER JOIN NETWORKNODEFLOW.dbo.CASEFILECODE AS cc
                        ON cc.CASEFILEID = ae.CASEFILEID
                        INNER JOIN #Enforcement_Actions AS k
                        ON ae.ENFORCEMENTACTIONID = k.ENFORCEMENTACTIONID;

                    INSERT INTO NETWORKNODEFLOW.dbo.ENFORCEMENTACTIONCODE
                        (ENFORCEMENTACTIONCODEID,
                         ENFORCEMENTACTIONID,
                         CODENAME,
                         CODEVALUE)
                    SELECT NEWID(),
                           i.ENFORCEMENTACTIONID,
                           IIF(i.CODENAME = 'ProgramCode', 'ProgramsViolatedCode', i.CODENAME),
                           i.CODEVALUE
                    FROM #EA_pollutant_codes AS i;

                    DROP TABLE #EA_pollutant_codes;

                    -- Enforcement Action Type Code
                    SELECT ie.ENFORCEMENTACTIONID,
                           ie.EnforcementActionTypeCode
                    INTO #EA_action_codes
                    FROM NETWORKNODEFLOW.dbo.ENFORCEMENTACTION AS ie
                        INNER JOIN #Enforcement_Actions AS k
                        ON ie.ENFORCEMENTACTIONID = k.ENFORCEMENTACTIONID
                    WHERE ie.EnforcementActionTypeCode <> 'NOV';

                    INSERT INTO NETWORKNODEFLOW.dbo.ENFORCEMENTACTIONCODE
                        (ENFORCEMENTACTIONCODEID,
                         ENFORCEMENTACTIONID,
                         CODENAME,
                         CODEVALUE)
                    SELECT NEWID(),
                           i.ENFORCEMENTACTIONID,
                           'EnforcementActionTypeCode',
                           i.EnforcementActionTypeCode
                    FROM #EA_action_codes AS i;

                    DROP TABLE #EA_action_codes;

                    -- Delete and reinsert final orders
                    DELETE a
                    FROM NETWORKNODEFLOW.dbo.AIRDAFINALORDER a
                        INNER JOIN #Enforcement_Actions AS k
                        ON a.ENFORCEMENTACTIONID = k.ENFORCEMENTACTIONID;

                    SELECT ae.ENFORCEMENTACTIONID,
                           ae.EATYPECODE,
                           ae.AIRFACILITYID,
                           ae.DATCOEXECUTED,
                           ae.DATCORESOLVED,
                           ae.STRCORESOLVED,
                           ae.STRCOPENALTYAMOUNT,
                           ae.DATAOEXECUTED,
                           ae.DATAORESOLVED,
                           ae.STRAORESOLVED,
                           ae.ENFORCEMENTACTIONNAME,
                           ae.DATAOAPPEALED
                    INTO #Final_Orders
                    FROM airbranch.dbo.VW_ICIS_ENFORCEMENTACTION AS ae
                        INNER JOIN NETWORKNODEFLOW.dbo.ENFORCEMENTACTION AS ie
                        ON ie.ENFORCEMENTACTIONID = ae.ENFORCEMENTACTIONID
                        INNER JOIN #Enforcement_Actions AS k
                        ON ae.ENFORCEMENTACTIONID = k.ENFORCEMENTACTIONID
                    WHERE ae.EATYPECODE <> 'NOV';

                    INSERT INTO NETWORKNODEFLOW.dbo.AIRDAFINALORDER
                        (AirDAFinalOrderId,
                         EnforcementActionId,
                         FinalOrderTypeCode,
                         FinalOrderIssuedEnteredDate,
                         AirEnforcementActionResolvedDate,
                         CashCivilPenaltyRequiredAmount,
                         OtherComments,
                         FinalOrderIdentifier)
                    SELECT NEWID(),
                           i.ENFORCEMENTACTIONID,
                           CASE
                               WHEN i.EATYPECODE = 'SCAAAO' -- Non-judicial
                                   THEN 'AFO'
                               WHEN i.EATYPECODE = 'CIV' -- Judicial
                                   THEN 'CDO'
                           END,
                           CASE
                               WHEN i.EATYPECODE = 'SCAAAO' -- Non-judicial
                                   THEN i.DATCOEXECUTED
                               WHEN i.EATYPECODE = 'CIV' -- Judicial
                                   THEN NULL -- APB does not currently track Final Order Entered (FOE)
                           END,
                           CASE
                               WHEN i.EATYPECODE = 'SCAAAO' -- Non-judicial
                                   AND i.STRCORESOLVED = 'True'
                                   THEN IIF(i.DATCORESOLVED >= i.DATCOEXECUTED, i.DATCORESOLVED, NULL)
                               WHEN i.EATYPECODE = 'CIV' -- Judicial
                                   AND i.STRAORESOLVED = 'True'
                                   THEN IIF(i.DATAORESOLVED >= i.DATAOEXECUTED AND
                                            (i.DATAORESOLVED >= i.DATAOAPPEALED OR i.DATAOAPPEALED < i.DATAOEXECUTED),
                                            i.DATAORESOLVED, NULL)
                           END,
                           IIF(i.EATYPECODE = 'SCAAAO', REPLACE(REPLACE(i.STRCOPENALTYAMOUNT, '$', ''), ',', ''),
                               null), -- (Non-judicial only)
                           i.ENFORCEMENTACTIONNAME,
                           1          -- FinalOrderIdentifier (Currently GA only issues one final order for any EA)
                    FROM #Final_Orders AS i;

                    DROP TABLE #Final_Orders;

                    -- Insert facility associated with each final order
                    SELECT ae.AIRFACILITYID,
                           fo.AIRDAFINALORDERID
                    INTO #Final_Order_Facilities
                    FROM AIRBRANCH.dbo.VW_ICIS_ENFORCEMENTACTION AS ae
                        INNER JOIN NETWORKNODEFLOW.dbo.ENFORCEMENTACTION AS ie
                        ON ie.ENFORCEMENTACTIONID = ae.ENFORCEMENTACTIONID
                        INNER JOIN NETWORKNODEFLOW.dbo.AIRDAFINALORDER AS fo
                        ON ae.ENFORCEMENTACTIONID = fo.ENFORCEMENTACTIONID
                        INNER JOIN #Enforcement_Actions AS k
                        ON ae.ENFORCEMENTACTIONID = k.ENFORCEMENTACTIONID;

                    INSERT INTO NETWORKNODEFLOW.dbo.AIRDAFINALORDERAIRFACILITY
                        (AIRDAFINALORDERID,
                         AIRFACILITYID)
                    SELECT i.AIRDAFINALORDERID,
                           i.AIRFACILITYID
                    FROM #Final_Order_Facilities AS i;

                    DROP TABLE #Final_Order_Facilities;

                    -- Insert/update EA Milestones
                    -- Multiple milestones are possible for each EA (RSAGJ and CMF)

                    -- * Update existing 'RSAGJ' milestone
                    --  (EATYPECODE = 'CIV' and strAoExecuted = True)
                    SELECT ae.ENFORCEMENTACTIONID,
                           ae.DATAOEXECUTED
                    INTO #Update_Milestone_RSAGJ
                    FROM AIRBRANCH.dbo.VW_ICIS_ENFORCEMENTACTION AS ae
                        INNER JOIN NETWORKNODEFLOW.dbo.ENFORCEMENTACTION AS ie
                        ON ie.ENFORCEMENTACTIONID = ae.ENFORCEMENTACTIONID
                        INNER JOIN #Enforcement_Actions AS k
                        ON ae.ENFORCEMENTACTIONID = k.ENFORCEMENTACTIONID
                    WHERE ae.EATYPECODE = 'CIV'
                      AND ae.STRAOEXECUTED = 'True'
                      AND ae.ENFORCEMENTACTIONID IN
                          (SELECT ENFORCEMENTACTIONID
                           FROM NETWORKNODEFLOW.dbo.EnforcementActionMilestone
                           WHERE TYPE = 'RSAGJ');

                    UPDATE e
                    SET e.MILESTONEACTUALDATE = i.DATAOEXECUTED
                    FROM NETWORKNODEFLOW.dbo.EnforcementActionMilestone e
                        INNER JOIN #Update_Milestone_RSAGJ AS i
                        ON e.ENFORCEMENTACTIONID = i.ENFORCEMENTACTIONID
                            AND e.TYPE = 'RSAGJ';

                    DROP TABLE #Update_Milestone_RSAGJ;

                    -- * Update existing 'CMF' milestone
                    --  (EATYPECODE = 'CIV' and strAoAppealed = True)
                    SELECT ae.ENFORCEMENTACTIONID,
                           ae.DATAOAPPEALED,
                           ae.DATAOEXECUTED
                    INTO #Update_Milestone_CMF
                    FROM AIRBRANCH.dbo.VW_ICIS_ENFORCEMENTACTION AS ae
                        INNER JOIN NETWORKNODEFLOW.dbo.ENFORCEMENTACTION AS ie
                        ON ie.ENFORCEMENTACTIONID = ae.ENFORCEMENTACTIONID
                        INNER JOIN #Enforcement_Actions AS k
                        ON ae.ENFORCEMENTACTIONID = k.ENFORCEMENTACTIONID
                    WHERE ae.EATYPECODE = 'CIV'
                      AND ae.STRAOAPPEALED = 'True'
                      AND ae.ENFORCEMENTACTIONID IN
                          (SELECT ENFORCEMENTACTIONID
                           FROM NETWORKNODEFLOW.dbo.EnforcementActionMilestone
                           WHERE TYPE = 'CMF');

                    UPDATE e
                    SET e.MILESTONEACTUALDATE = i.DATAOAPPEALED
                    FROM NETWORKNODEFLOW.dbo.EnforcementActionMilestone e
                        INNER JOIN #Update_Milestone_CMF AS i
                        ON e.ENFORCEMENTACTIONID = i.ENFORCEMENTACTIONID
                            AND e.TYPE = 'CMF'
                    WHERE i.DATAOEXECUTED <= i.DATAOAPPEALED;

                    DELETE e
                    FROM NETWORKNODEFLOW.dbo.EnforcementActionMilestone e
                        INNER JOIN #Update_Milestone_CMF AS i
                        ON e.ENFORCEMENTACTIONID = i.ENFORCEMENTACTIONID
                            AND e.TYPE = 'CMF'
                    WHERE i.DATAOEXECUTED > i.DATAOAPPEALED;

                    DROP TABLE #Update_Milestone_CMF;

                    -- * Insert new 'RSAGJ' milestone
                    --  (EATYPECODE = 'CIV' and strAoExecuted = True)
                    INSERT INTO NETWORKNODEFLOW.dbo.EnforcementActionMilestone
                        (ENFORCEMENTACTIONID,
                         MILESTONEACTUALDATE,
                         TYPE,
                         TRANSACTIONID)
                    SELECT ae.ENFORCEMENTACTIONID,
                           ae.DATAOEXECUTED,
                           'RSAGJ',
                           NEWID()
                    FROM airbranch.dbo.VW_ICIS_ENFORCEMENTACTION AS ae
                        INNER JOIN NETWORKNODEFLOW.dbo.ENFORCEMENTACTION AS ie
                        ON ie.ENFORCEMENTACTIONID = ae.ENFORCEMENTACTIONID
                        INNER JOIN #Enforcement_Actions AS k
                        ON ae.ENFORCEMENTACTIONID = k.ENFORCEMENTACTIONID
                    WHERE ae.EATYPECODE = 'CIV'
                      AND ae.STRAOEXECUTED = 'True'
                      AND ae.ENFORCEMENTACTIONID NOT IN
                          (SELECT ENFORCEMENTACTIONID
                           FROM NETWORKNODEFLOW.dbo.EnforcementActionMilestone
                           WHERE TYPE = 'RSAGJ');

                    -- * Insert new 'CMF' milestone
                    --  (EATYPECODE = 'CIV' and strAoAppealed = True)
                    INSERT INTO NETWORKNODEFLOW.dbo.EnforcementActionMilestone
                        (ENFORCEMENTACTIONID,
                         MILESTONEACTUALDATE,
                         TYPE,
                         TRANSACTIONID)
                    SELECT ae.ENFORCEMENTACTIONID,
                           ae.DATAOAPPEALED,
                           'CMF',
                           NEWID()
                    FROM AIRBRANCH.dbo.VW_ICIS_ENFORCEMENTACTION AS ae
                        INNER JOIN NETWORKNODEFLOW.dbo.ENFORCEMENTACTION AS ie
                        ON ie.ENFORCEMENTACTIONID = ae.ENFORCEMENTACTIONID
                        INNER JOIN #Enforcement_Actions AS k
                        ON ae.ENFORCEMENTACTIONID = k.ENFORCEMENTACTIONID
                    WHERE ae.EATYPECODE = 'CIV'
                      AND ae.STRAOAPPEALED = 'True'
                      AND ae.DATAOEXECUTED <= ae.DATAOAPPEALED
                      AND ae.ENFORCEMENTACTIONID NOT IN
                          (SELECT ENFORCEMENTACTIONID
                           FROM NETWORKNODEFLOW.dbo.EnforcementActionMilestone
                           WHERE TYPE = 'CMF');

                    -- End of EA Milestones
                END;
            -- End of enforcement actions
            DROP TABLE #Enforcement_Actions;

            -- Update any existing case file to compliance monitoring linkages
            -- to ensure linkage is resubmitted (in case it got broken or rejected
            -- previously). This does not change the value but causes the update
            -- trigger to fire, which adds the linkage to the SubmissionStatus table.
            UPDATE lnk
            SET ComplianceMonitoringId = lnk.ComplianceMonitoringId
            FROM NETWORKNODEFLOW.dbo.CaseFile2CMLink lnk
                INNER JOIN #Modified_Case_Files AS i
                ON lnk.CaseFileId = i.CaseFileId;

            -- Insert new case file to compliance monitoring linkages for a given
            -- case file.
            INSERT INTO NETWORKNODEFLOW.dbo.CaseFile2CMLink
                (CaseFileId,
                 ComplianceMonitoringId,
                 TransactionID)
            SELECT acf.CaseFileId,
                   cm.ComplianceMonitoringId,
                   NEWID()
            FROM #Modified_Case_Files AS acf
                INNER JOIN NETWORKNODEFLOW.dbo.CaseFile AS cf
                ON acf.CaseFileId = cf.CaseFileId
                INNER JOIN SSCP_EnforcementEvents ee
                ON ee.EnforcementNumber = acf.EnforcementNumber
                INNER JOIN VW_ICIS_COMPLIANCEMONITORING cm
                ON cm.ApbTrackingNumber = ee.TrackingNumber
                INNER JOIN NETWORKNODEFLOW.dbo.ComplianceMonitoring AS co
                ON cm.ComplianceMonitoringId = co.ComplianceMonitoringId
            WHERE cm.ComplianceMonitoringId NOT IN
                  (SELECT t.ComplianceMonitoringId
                   FROM NETWORKNODEFLOW.dbo.CaseFile2CMLink t
                   WHERE t.CaseFileId = acf.CaseFileId);

            -- Reset the status indicator for the case file to 'P' for "Processed"
            UPDATE enf
            SET enf.ICIS_STATUSIND = 'P'
            FROM AIRBRANCH.dbo.SSCP_AUDITEDENFORCEMENT enf
                INNER JOIN #Modified_Case_Files AS j
                ON enf.STRENFORCEMENTNUMBER = j.ENFORCEMENTNUMBER;

        END;

    DROP TABLE #Modified_Case_Files;

    /* *** END: Modified Case Files *** */

    /* *** PART II: All new Case Files *** */

    SELECT cf.CASEFILEID,
           cf.AIRFACILITYID,
           cf.CASEFILENAME,
           cf.APBSHORTACTIVITYNAME,
           cf.APBFACILITYIDDESC,
           cf.ADVISEMENTMETHODTYPECODE,
           cf.ADVISEMENTMETHODDATE,
           cf.SENSITIVEDATAINDICATOR,
           cf.EnforcementNumber
    INTO #New_Case_Files
    FROM AIRBRANCH.dbo.VW_ICIS_CASEFILE AS cf
        INNER JOIN NETWORKNODEFLOW.dbo.AIRFACILITY AS af
        ON cf.AIRFACILITYID = af.AIRFACILITYID
    WHERE cf.ICIS_STATUSIND <> 'P'
      AND cf.CaseFileId NOT IN
          (SELECT CASEFILEID
           FROM NETWORKNODEFLOW.dbo.CASEFILE);

    IF EXISTS
        (SELECT *
         FROM #New_Case_Files)
        BEGIN

            -- Case File
            INSERT INTO NETWORKNODEFLOW.dbo.CASEFILE
                (CASEFILEID,
                 CASEFILENAME,
                 LEADAGENCYCODE,
                 AIRFACILITYID,
                 SensitiveDataIndicator,
                 ADVISEMENTMETHODTYPECODE,
                 ADVISEMENTMETHODDATE,
                 CASEFILEUSERDEFINEDFIELD2,
                 CASEFILEUSERDEFINEDFIELD3,
                 TRANSACTIONID)
            SELECT i.CASEFILEID,
                   i.CASEFILENAME,
                   'ST2',
                   i.AIRFACILITYID,
                   i.SENSITIVEDATAINDICATOR,
                   i.ADVISEMENTMETHODTYPECODE,
                   i.ADVISEMENTMETHODDATE,
                   i.APBSHORTACTIVITYNAME,
                   i.APBFACILITYIDDESC,
                   NEWID()
            FROM #New_Case_Files AS i;

            -- Program codes
            INSERT INTO NETWORKNODEFLOW.dbo.CASEFILECODE
                (CASEFILECODEID,
                 CASEFILEID,
                 CODENAME,
                 CODEVALUE)
            SELECT NEWID(),
                   CASEFILEID,
                   'ProgramCode',
                   ISNULL(ICIS_PROGRAM_CODE, 'CAASIP')
            FROM (SELECT DISTINCT acf.ICIS_PROGRAM_CODE,
                                  icf.casefileid
                  FROM AIRBRANCH.dbo.ICIS_CASEFILE_CODES AS acf
                      RIGHT JOIN NETWORKNODEFLOW.dbo.CASEFILE AS icf
                      ON icf.CASEFILEID = acf.CASEFILEID
                      INNER JOIN #New_Case_Files AS j
                      ON icf.CASEFILEID = j.CASEFILEID) AS i;

            -- Pollutant codes
            INSERT INTO NETWORKNODEFLOW.dbo.CASEFILECODE
                (CASEFILECODEID,
                 CASEFILEID,
                 CODENAME,
                 CODEVALUE)
            SELECT NEWID(),
                   CASEFILEID,
                   'AirPollutantCode',
                   ICIS_POLLUTANT_CODE
            FROM (SELECT DISTINCT acf.ICIS_POLLUTANT_CODE,
                                  acf.CASEFILEID
                  FROM AIRBRANCH.dbo.ICIS_CASEFILE_CODES AS acf
                      INNER JOIN NETWORKNODEFLOW.dbo.CASEFILE AS icf
                      ON icf.CASEFILEID = acf.CASEFILEID
                      INNER JOIN #New_Case_Files AS j
                      ON icf.CASEFILEID = j.CASEFILEID
                  WHERE acf.ICIS_POLLUTANT_CODE IS NOT NULL) AS i;

            -- Air violation data
            INSERT INTO NETWORKNODEFLOW.dbo.AIRVIOLATIONDATA
                (AIRVIOLATIONDATAID,
                 CASEFILEID,
                 AIRVIOLATIONTYPECODE,
                 AIRVIOLATIONPROGRAMCODE,
                 AIRVIOLATIONPOLLUTANTCODE,
                 FRVDETERMINATIONDATE,
                 HPVDAYZERODATE)
            SELECT NEWID(),
                   acf.CASEFILEID,
                   acf.AIRVIOLATIONTYPECODE,
                   ISNULL(cc.ICIS_PROGRAM_CODE, 'CAASIP'),
                   cc.ICIS_POLLUTANT_CODE,
                   acf.FRVDETERMINATIONDATE,
                   acf.HPVDAYZERODATE
            FROM AIRBRANCH.dbo.VW_ICIS_CASEFILE AS acf
                INNER JOIN AIRBRANCH.dbo.ICIS_CASEFILE_CODES AS cc
                ON acf.CASEFILEID = cc.CASEFILEID
            WHERE acf.CaseFileId IN
                  (SELECT CaseFileId
                   FROM #New_Case_Files);

            -- "Other pathway activity" data ('ADDR' and 'RSLV')
            --
            -- First, insert 'ADDR'
            INSERT INTO NETWORKNODEFLOW.dbo.OTHERPATHWAYACTIVITYDATA
                (OTHERPATHWAYACTIVITYDATAID,
                 CASEFILEID,
                 OTHERPATHWAYCATEGORYCODE,
                 OTHERPATHWAYTYPECODE,
                 OTHERPATHWAYDATE)
            SELECT NEWID(),
                   i.CASEFILEID,
                   'ADDR',
                   'NAN',
                   i.DATNFALETTERSENT
            FROM airbranch.dbo.VW_ICIS_ENFORCEMENTACTION AS i
                INNER JOIN NETWORKNODEFLOW.dbo.CASEFILE AS c
                ON i.CASEFILEID = c.CASEFILEID
                INNER JOIN #New_Case_Files AS j
                ON i.CASEFILEID = j.CASEFILEID
            WHERE i.EATYPECODE = 'NOV'
              AND i.STRNFALETTERSENT = 'True';

            -- Second, insert 'RSLV'
            INSERT INTO NETWORKNODEFLOW.dbo.OTHERPATHWAYACTIVITYDATA
                (OTHERPATHWAYACTIVITYDATAID,
                 CASEFILEID,
                 OTHERPATHWAYCATEGORYCODE,
                 OTHERPATHWAYTYPECODE,
                 OTHERPATHWAYDATE)
            SELECT NEWID(),
                   i.CASEFILEID,
                   'RSLV',
                   'NAN',
                   i.DATNFALETTERSENT
            FROM AIRBRANCH.dbo.VW_ICIS_ENFORCEMENTACTION AS i
                INNER JOIN NETWORKNODEFLOW.dbo.CASEFILE AS c
                ON i.CASEFILEID = c.CASEFILEID
                INNER JOIN #New_Case_Files AS j
                ON i.CASEFILEID = j.CASEFILEID
            WHERE i.EATYPECODE = 'NOV'
              AND i.STRNFALETTERSENT = 'True';

            -- Find all enforcement actions for a given case file
            SELECT ea.ENFORCEMENTACTIONID,
                   ea.CASEFILEID,
                   ea.EATYPECODE,
                   ea.ENFORCEMENTACTIONNAME,
                   ea.DATNOVSENT,
                   ea.APBSHORTACTIVITYNAME,
                   ea.APBFACILITYIDDESC,
                   ea.AIRFACILITYID
            INTO #Add_Enforcement_Actions
            FROM airbranch.dbo.VW_ICIS_ENFORCEMENTACTION AS ea
                INNER JOIN NETWORKNODEFLOW.dbo.AIRFACILITY AS af
                ON ea.AIRFACILITYID = af.AIRFACILITYID
                INNER JOIN #New_Case_Files AS j
                ON ea.CASEFILEID = j.CASEFILEID;

            IF EXISTS
                (SELECT *
                 FROM #Add_Enforcement_Actions)
                BEGIN

                    -- Enforcement Action data
                    INSERT INTO NETWORKNODEFLOW.dbo.ENFORCEMENTACTION
                        (ENFORCEMENTACTIONID,
                         EnforcementActionTypeCode,
                         EnforcementActionName,
                         FORUM,
                         ACHIEVEDDATE,
                         EAUSERDEFINEDFIELD2,
                         EAUSERDEFINEDFIELD3,
                         LEADAGENCYCODE,
                         TYPE,
                         TRANSACTIONID)
                    SELECT ENFORCEMENTACTIONID,
                           EATYPECODE,
                           EnforcementActionName,
                           CASE
                               WHEN EATYPECODE = 'SCAAAO' -- Non-judicial
                                   THEN 'AFR'
                               WHEN EATYPECODE = 'CIV' -- Judicial
                                   THEN 'JDC'
                           END,
                           CASE -- (NOV and Proposed CO)
                               WHEN EATYPECODE = 'NOV'
                                   THEN DATNOVSENT
                           END,
                           ApbShortActivityName,
                           ApbFacilityIdDesc,
                           'ST4',
                           IIF(EATYPECODE = 'NOV', 'DAInFormal', 'DAFormal'),
                           NEWID()
                    FROM #Add_Enforcement_Actions;

                    -- Enforcement Action facilities
                    INSERT INTO NETWORKNODEFLOW.dbo.EnforcementActionAirFacility
                        (ENFORCEMENTACTIONID,
                         AIRFACILITYID)
                    SELECT ENFORCEMENTACTIONID,
                           AIRFACILITYID
                    FROM #Add_Enforcement_Actions;

                    -- Case File to Enforcement Action linkage
                    INSERT INTO NETWORKNODEFLOW.dbo.CASEFILE2DAEALINK
                        (CASEFILEID,
                         ENFORCEMENTACTIONID,
                         TRANSACTIONID)
                    SELECT CASEFILEID,
                           ENFORCEMENTACTIONID,
                           NEWID()
                    FROM #Add_Enforcement_Actions;

                    -- Insert all enforcement actions codes (program and pollutant codes) for
                    -- each enforcement action (they are identical to the same codes for
                    -- the case file, except the name 'ProgramCode' is changed to
                    -- 'ProgramsViolatedCode')
                    INSERT INTO NETWORKNODEFLOW.dbo.ENFORCEMENTACTIONCODE
                        (ENFORCEMENTACTIONCODEID,
                         ENFORCEMENTACTIONID,
                         CODENAME,
                         CODEVALUE)
                    SELECT NEWID(),
                           ae.enforcementactionid,
                           IIF(cc.CODENAME = 'ProgramCode', 'ProgramsViolatedCode', cc.CODENAME),
                           cc.codevalue
                    FROM AIRBRANCH.dbo.VW_ICIS_ENFORCEMENTACTION AS ae
                        INNER JOIN NETWORKNODEFLOW.dbo.ENFORCEMENTACTION AS ie
                        ON ie.ENFORCEMENTACTIONID = ae.ENFORCEMENTACTIONID
                        INNER JOIN NETWORKNODEFLOW.dbo.CASEFILECODE AS cc
                        ON cc.CASEFILEID = ae.CASEFILEID
                        INNER JOIN #Add_Enforcement_Actions AS k
                        ON ae.ENFORCEMENTACTIONID = k.ENFORCEMENTACTIONID;

                    -- EnforcementActionTypeCode
                    INSERT INTO NETWORKNODEFLOW.dbo.ENFORCEMENTACTIONCODE
                        (ENFORCEMENTACTIONCODEID,
                         ENFORCEMENTACTIONID,
                         CODENAME,
                         CODEVALUE)
                    SELECT NEWID(),
                           i.ENFORCEMENTACTIONID,
                           'EnforcementActionTypeCode',
                           i.EATYPECODE
                    FROM #Add_Enforcement_Actions AS i
                    WHERE i.EATYPECODE <> 'NOV';

                    -- Final orders
                    INSERT INTO NETWORKNODEFLOW.dbo.AIRDAFINALORDER
                        (AirDAFinalOrderId,
                         EnforcementActionId,
                         FinalOrderTypeCode,
                         FinalOrderIssuedEnteredDate,
                         AirEnforcementActionResolvedDate,
                         CashCivilPenaltyRequiredAmount,
                         OtherComments,
                         FinalOrderIdentifier)
                    SELECT NEWID(),
                           i.ENFORCEMENTACTIONID,
                           CASE
                               WHEN i.EATYPECODE = 'SCAAAO' -- Non-judicial
                                   THEN 'AFO'
                               WHEN i.EATYPECODE = 'CIV' -- Judicial
                                   THEN 'CDO'
                           END,
                           CASE
                               WHEN i.EATYPECODE = 'SCAAAO' -- Non-judicial
                                   THEN i.DATCOEXECUTED
                               WHEN i.EATYPECODE = 'CIV' -- Judicial
                                   THEN NULL -- APB does not currently track Final Order Entered (FOE)
                           END,
                           CASE
                               WHEN i.EATYPECODE = 'SCAAAO' -- Non-judicial
                                   AND i.STRCORESOLVED = 'True'
                                   THEN IIF(i.DATCORESOLVED >= i.DATCOEXECUTED, i.DATCORESOLVED, NULL)
                               WHEN i.EATYPECODE = 'CIV' -- Judicial
                                   AND i.STRAORESOLVED = 'True'
                                   THEN IIF(i.DATAORESOLVED >= i.DATAOEXECUTED AND
                                            (i.DATAORESOLVED >= i.DATAOAPPEALED OR i.DATAOAPPEALED < i.DATAOEXECUTED),
                                            i.DATAORESOLVED, NULL)
                           END,
                           CASE -- (Non-judicial only)
                               WHEN i.EATYPECODE = 'SCAAAO'
                                   THEN REPLACE(REPLACE(i.STRCOPENALTYAMOUNT, '$', ''), ',', '')
                           END,
                           i.ENFORCEMENTACTIONNAME,
                           1 -- FinalOrderIdentifier (Currently GA only issues one final order for any EA)
                    FROM AIRBRANCH.dbo.VW_ICIS_ENFORCEMENTACTION AS i
                        INNER JOIN NETWORKNODEFLOW.dbo.ENFORCEMENTACTION AS ie
                        ON ie.ENFORCEMENTACTIONID = i.ENFORCEMENTACTIONID
                        INNER JOIN #Add_Enforcement_Actions AS k
                        ON i.ENFORCEMENTACTIONID = k.ENFORCEMENTACTIONID
                    WHERE i.EATYPECODE <> 'NOV';

                    -- Facility associated with each final order
                    INSERT INTO NETWORKNODEFLOW.dbo.AIRDAFINALORDERAIRFACILITY
                        (AirDAFinalOrderId,
                         AirFacilityId)
                    SELECT fo.AIRDAFINALORDERID,
                           k.AIRFACILITYID
                    FROM NETWORKNODEFLOW.dbo.ENFORCEMENTACTION AS ie
                        INNER JOIN NETWORKNODEFLOW.dbo.AIRDAFINALORDER AS fo
                        ON ie.ENFORCEMENTACTIONID = fo.ENFORCEMENTACTIONID
                        INNER JOIN #Add_Enforcement_Actions AS k
                        ON ie.ENFORCEMENTACTIONID = k.ENFORCEMENTACTIONID;

                    -- Insert EA Milestones
                    -- Multiple milestones are possible for each EA (RSAGJ and CMF)

                    -- * If Formal-Judicial (EATYPECODE = 'CIV') and strAoExecuted = True,
                    --   Then create 'RSAGJ' milestone
                    INSERT INTO NETWORKNODEFLOW.dbo.EnforcementActionMilestone
                        (ENFORCEMENTACTIONID,
                         MILESTONEACTUALDATE,
                         TYPE,
                         TRANSACTIONID)
                    SELECT ae.ENFORCEMENTACTIONID,
                           ae.DATAOEXECUTED,
                           'RSAGJ',
                           NEWID()
                    FROM AIRBRANCH.dbo.VW_ICIS_ENFORCEMENTACTION AS ae
                        INNER JOIN NETWORKNODEFLOW.dbo.ENFORCEMENTACTION AS ie
                        ON ie.ENFORCEMENTACTIONID = ae.ENFORCEMENTACTIONID
                        INNER JOIN #Add_Enforcement_Actions AS k
                        ON ae.ENFORCEMENTACTIONID = k.ENFORCEMENTACTIONID
                            AND ae.EATYPECODE = 'CIV'
                            AND ae.STRAOEXECUTED = 'True';

                    -- * If Formal-Judicial (EATYPECODE = 'CIV') and strAoAppealed = True,
                    --   Then create 'CMF' milestone
                    INSERT INTO NETWORKNODEFLOW.dbo.EnforcementActionMilestone
                        (ENFORCEMENTACTIONID,
                         MILESTONEACTUALDATE,
                         TYPE,
                         TRANSACTIONID)
                    SELECT ae.ENFORCEMENTACTIONID,
                           ae.DATAOAPPEALED,
                           'CMF',
                           NEWID()
                    FROM AIRBRANCH.dbo.VW_ICIS_ENFORCEMENTACTION AS ae
                        INNER JOIN NETWORKNODEFLOW.dbo.ENFORCEMENTACTION AS ie
                        ON ie.ENFORCEMENTACTIONID = ae.ENFORCEMENTACTIONID
                        INNER JOIN #Add_Enforcement_Actions AS k
                        ON ae.ENFORCEMENTACTIONID = k.ENFORCEMENTACTIONID
                            AND ae.EATYPECODE = 'CIV'
                            AND ae.STRAOAPPEALED = 'True'
                    WHERE ae.DATAOEXECUTED <= ae.DATAOAPPEALED;

                    -- End of EA Milestones
                END;
            -- End of enforcement actions
            DROP TABLE #Add_Enforcement_Actions;

            -- Insert case file to compliance monitoring linkages
            INSERT INTO NETWORKNODEFLOW.dbo.CaseFile2CMLink
                (CaseFileId,
                 ComplianceMonitoringId,
                 TransactionID)
            SELECT acf.CaseFileId,
                   cm.ComplianceMonitoringId,
                   NEWID()
            FROM #New_Case_Files AS acf
                INNER JOIN NETWORKNODEFLOW.dbo.CaseFile AS cf
                ON acf.CaseFileId = cf.CaseFileId
                INNER JOIN SSCP_EnforcementEvents ee
                ON ee.EnforcementNumber = acf.EnforcementNumber
                INNER JOIN VW_ICIS_COMPLIANCEMONITORING cm
                ON cm.ApbTrackingNumber = ee.TrackingNumber
                INNER JOIN NETWORKNODEFLOW.dbo.ComplianceMonitoring AS co
                ON cm.ComplianceMonitoringId = co.ComplianceMonitoringId;

            -- Reset the status indicator for the case file to 'P' for "Processed"
            UPDATE enf
            SET enf.ICIS_STATUSIND = 'P'
            FROM airbranch.dbo.SSCP_AUDITEDENFORCEMENT enf
                INNER JOIN #New_Case_Files AS j
                ON enf.STRENFORCEMENTNUMBER = j.ENFORCEMENTNUMBER;

        END;

    DROP TABLE #New_Case_Files;

    /* *** END: New Case Files *** */

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

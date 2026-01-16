USE [NETWORKNODEFLOW];
GO

CREATE OR ALTER TRIGGER dbo.TG_ICIS_EDT_ERRORS
    ON dbo.SUBMISSIONSTATUS
    AFTER UPDATE
    AS

/**************************************************************************************************

Author:     Doug Waldron
Overview:   This trigger keeps the ICIS_EDT_ERRORS table in the airbranch
            database up to date with details about rejected records and 
            warnings when the SUBMISSIONSTATUS table STATUSDETAIL 
            column is updated.
   
Tables written to:
    airbranch.dbo.ICIS_EDT_ERRORS

Tables accessed:
    NETWORKNODEFLOW.dbo.SUBMISSIONSTATUS

Modification History:
When        Who                 What
----------  ------------------  -------------------------------------------------------------------
2015-02     SPatel              Initially created in Oracle
2016-11-22  DWaldron            Migrated to SQL Server

***************************************************************************************************/

BEGIN
    SET NOCOUNT ON

    IF UPDATE(STATUSDETAIL)
        BEGIN

            INSERT INTO airbranch.dbo.ICIS_EDT_ERRORS
                (ERRORID,
                 TABLENAME,
                 EDTID,
                 ERRORCODE,
                 FOREIGNKEY,
                 OPERATION,
                 CREATEDATE,
                 STATUS,
                 SUBMITDATE,
                 STATUSDETAIL,
                 RESOLVED)
            SELECT NEXT VALUE FOR airbranch.dbo.ICIS_ERRORID,
                   i.TABLENAME,
                   i.ID,
                   SUBSTRING(i.STATUSDETAIL, 1, CHARINDEX(':', i.STATUSDETAIL) - 1),
                   i.FOREIGNKEY,
                   i.OPERATION,
                   i.CREATEDATE,
                   i.STATUS,
                   i.SUBMITDATE,
                   i.STATUSDETAIL,
                   'False'
            FROM inserted AS i
            WHERE i.STATUSDETAIL IS NOT NULL
              AND CHARINDEX(':', i.STATUSDETAIL) > 1;

        END;

END
GO

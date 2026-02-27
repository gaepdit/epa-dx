USE NETWORKNODEFLOW
GO

CREATE OR ALTER TRIGGER dbo.TG_ICIS_SubmissionStatus
    ON dbo.SubmissionStatus
    AFTER INSERT
    AS

/**************************************************************************************************

Author:     Doug Waldron
Overview:   This trigger populates the dbo.[Transaction] table with new 
            transaction records whenever the [SubmissionStatus] table
            gets a new "insert" record.

Tables written to:
    Transaction

Tables accessed:
    SubmissionStatus

Modification History:
When        Who                 What
----------  ------------------  -------------------------------------------------------------------
2017-02-07  DWaldron            First!

***************************************************************************************************/

BEGIN
    SET NOCOUNT ON

    INSERT INTO [Transaction]
        (TransactionID,
         TransactionType,
         TransactionTimestamp)
    SELECT TransactionID,
           'R',
           GETDATE()
    FROM inserted AS i
    WHERE i.Operation = 'insert';

END
GO


CREATE TRIGGER dbo.TG_ICIS_SubmissionStatus ON dbo.SubmissionStatus
AFTER INSERT
AS

/*****************************************************************************

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
----------  ------------------- ----------------------------------------
2017-02-07  DWaldron            First!

*******************************************************************************/

     SET XACT_ABORT, NOCOUNT ON;
    BEGIN TRY

        BEGIN TRANSACTION;

        INSERT INTO [Transaction]
        ( TransactionID
        , TransactionType
        , TransactionTimestamp
        )
        SELECT TransactionID
             , 'R'
             , GETDATE()
        FROM   inserted AS i
        WHERE  i.Operation = 'insert';

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@trancount > 0
            ROLLBACK TRANSACTION;
        DECLARE @msg nvarchar(2048) = ERROR_MESSAGE();
        RAISERROR(@msg, 16, 1);
    END CATCH;


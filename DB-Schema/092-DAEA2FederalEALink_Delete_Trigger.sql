CREATE TRIGGER [dbo].[DAEA2FederalEALink_Delete_Trigger]
ON [dbo].[DAEA2FederalEALink]
AFTER DELETE
AS
BEGIN
    SET NOCOUNT ON;

    INSERT
        [dbo].[SubmissionStatus]
        (TransactionID, TableName, ID, ForeignKey, Operation)
        SELECT
            i.TransactionID,
            'DAEA2FederalEALink',
            i.EnforcementActionId,
            i.LinkedEAId,
            'delete'
        FROM
            deleted i

END;


CREATE TRIGGER [dbo].[DAEA2DAEALink_Delete_Trigger]
ON [dbo].[DAEA2DAEALink]
AFTER DELETE
AS
BEGIN
    SET NOCOUNT ON;

    INSERT
        [dbo].[SubmissionStatus]
        (TransactionID, TableName, ID, ForeignKey, Operation)
        SELECT
            i.TransactionID,
            'DAEA2DAEALink',
            i.EnforcementActionId,
            i.LinkedEAId,
            'delete'
        FROM
            deleted i

END;


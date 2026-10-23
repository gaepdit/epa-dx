CREATE TRIGGER [dbo].[CaseFile2DAEALink_Delete_Trigger]
ON [dbo].[CaseFile2DAEALink]
AFTER DELETE
AS
BEGIN
    SET NOCOUNT ON;

    INSERT
        [dbo].[SubmissionStatus]
        (TransactionID, TableName, ID, ForeignKey, Operation)
        SELECT
            i.TransactionID,
            'CaseFile2DAEALink',
            i.CaseFileId,
            i.EnforcementActionId,
            'delete'
        FROM
            deleted i

END;


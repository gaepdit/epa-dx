CREATE TRIGGER [dbo].[CaseFile2CaseFileLink_Delete_Trigger]
ON [dbo].[CaseFile2CaseFileLink]
AFTER DELETE
AS
BEGIN
    SET NOCOUNT ON;

    INSERT
        [dbo].[SubmissionStatus]
        (TransactionID, TableName, ID, ForeignKey, Operation)
        SELECT
            i.TransactionID,
            'CaseFile2CaseFileLink',
            i.CaseFileId,
            i.LinkedCaseFileId,
            'delete'
        FROM
            deleted i

END;


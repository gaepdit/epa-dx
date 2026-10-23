CREATE TRIGGER [dbo].[CaseFile2FederalEALink_Delete_Trigger]
ON [dbo].[CaseFile2FederalEALink]
AFTER DELETE
AS
BEGIN
    SET NOCOUNT ON;

    INSERT
        [dbo].[SubmissionStatus]
        (TransactionID, TableName, ID, ForeignKey, Operation)
        SELECT
            i.TransactionID,
            'CaseFile2FederalEALink',
            i.CaseFileId,
            i.EnforcementActionId,
            'delete'
        FROM
            deleted i

END;


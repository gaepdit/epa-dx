CREATE TRIGGER [dbo].[CaseFile2CMLink_Delete_Trigger]
ON [dbo].[CaseFile2CMLink]
AFTER DELETE
AS
BEGIN
    SET NOCOUNT ON;

    INSERT
        [dbo].[SubmissionStatus]
        (TransactionID, TableName, ID, ForeignKey, Operation)
        SELECT
            i.TransactionID,
            'CaseFile2CMLink',
            i.CaseFileId,
            i.ComplianceMonitoringId,
            'delete'
        FROM
            deleted i

END;


CREATE TRIGGER [dbo].[CM2CMLink_Delete_Trigger]
ON [dbo].[CM2CMLink]
AFTER DELETE
AS
BEGIN
    SET NOCOUNT ON;

    INSERT
        [dbo].[SubmissionStatus]
        (TransactionID, TableName, ID, ForeignKey, Operation)
        SELECT
            i.TransactionID,
            'CM2CMLink',
            i.ComplianceMonitoringId,
            i.LinkedCMId,
            'delete'
        FROM
            deleted i

END;


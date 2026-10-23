CREATE TRIGGER [dbo].[CM2DAEALink_Delete_Trigger]
ON [dbo].[CM2DAEALink]
AFTER DELETE
AS
BEGIN
    SET NOCOUNT ON;

    INSERT
        [dbo].[SubmissionStatus]
        (TransactionID, TableName, ID, ForeignKey, Operation)
        SELECT
            i.TransactionID,
            'CM2DAEALink',
            i.ComplianceMonitoringId,
            i.EnforcementActionId,
            'delete'
        FROM
            deleted i

END;


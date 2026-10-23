CREATE TRIGGER [dbo].[CM2FederalEALink_Delete_Trigger]
ON [dbo].[CM2FederalEALink]
AFTER DELETE
AS
BEGIN
    SET NOCOUNT ON;

    INSERT
        [dbo].[SubmissionStatus]
        (TransactionID, TableName, ID, ForeignKey, Operation)
        SELECT
            i.TransactionID,
            'CM2FederalEALink',
            i.ComplianceMonitoringId,
            i.EnforcementActionId,
            'delete'
        FROM
            deleted i

END;


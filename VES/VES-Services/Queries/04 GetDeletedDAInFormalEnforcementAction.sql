use NETWORKNODEFLOW;
GO

SELECT EnforcementAction.EnforcementActionId, EnforcementAction.ReasonDeletingRecord, EnforcementAction.TransactionID,
       CONVERT(varchar(30), [Transaction].TransactionTimestamp, 126) as TransactionTimestamp
FROM DeletedEnforcementAction EnforcementAction
    INNER JOIN [Transaction]
    ON EnforcementAction.TransactionId = [Transaction].TransactionID AND EnforcementAction.Type = 'DAInFormal'
    INNER JOIN SubmissionStatus
    ON [Transaction].TransactionID = SubmissionStatus.TransactionID AND
       SubmissionStatus.TableName = 'EnforcementAction' AND
       SubmissionStatus.ID = EnforcementAction.EnforcementActionId AND SubmissionStatus.Status is NULL AND
       SubmissionStatus.Operation = 'delete'
-- WHERE SubmissionStatus.ID in ('{$EnforcementActionID}')
--   AND [Transaction].TransactionTimestamp between '{$fromDate}' and '{$toDate}'
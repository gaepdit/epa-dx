use NETWORKNODEFLOW;
GO

SELECT EnforcementActionMilestone.EnforcementActionMilestoneId, EnforcementActionMilestone.EnforcementActionId,
       EnforcementActionMilestone.MilestonePlannedDate, EnforcementActionMilestone.MilestoneActualDate,
       EnforcementActionMilestone.Type, EnforcementActionMilestone.TransactionID, [Transaction].TransactionType,
       CONVERT(varchar(30), [Transaction].TransactionTimestamp, 126) AS TransactionTimestamp
FROM EnforcementActionMilestone
    INNER JOIN [Transaction]
    ON EnforcementActionMilestone.TransactionId = [Transaction].TransactionID
    INNER JOIN SubmissionStatus
    ON [Transaction].TransactionID = SubmissionStatus.TransactionID AND
       SubmissionStatus.TableName = 'EnforcementActionMilestone' AND SubmissionStatus.Status IS NULL AND
       SubmissionStatus.Operation <> 'delete'
-- WHERE EnforcementActionMilestone.EnforcementActionId IN ('{$EnforcementActionID}')
--   AND [Transaction].TransactionTimestamp BETWEEN '{$fromDate}' AND '{$toDate}'
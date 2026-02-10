use NETWORKNODEFLOW;
GO

SELECT SubmissionStatus.ID                                           as CaseFileId, [Transaction].TransactionID,
       CONVERT(varchar(30), [Transaction].TransactionTimestamp, 126) as TransactionTimestamp
FROM [Transaction]
    INNER JOIN
SubmissionStatus
    ON [Transaction].TransactionID = SubmissionStatus.TransactionID
        AND SubmissionStatus.TableName = 'CaseFile' AND SubmissionStatus.Status is NULL AND
       SubmissionStatus.Operation = 'delete'
-- WHERE SubmissionStatus.ID in ('{$CaseFileID}')
--   AND [Transaction].TransactionTimestamp between '{$fromDate}' and '{$toDate}'
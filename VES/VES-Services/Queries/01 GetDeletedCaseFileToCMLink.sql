use NETWORKNODEFLOW;
GO

SELECT [Transaction].TransactionId, 'X'                              as TransactionType,
       CONVERT(varchar(30), [Transaction].TransactionTimestamp, 126) as TransactionTimestamp,
       SubmissionStatus.ID                                           AS CaseFileId,
       SubmissionStatus.ForeignKey                                   as ComplianceMonitoringId
FROM [Transaction]
    INNER JOIN SubmissionStatus
    ON [Transaction].TransactionID = SubmissionStatus.TransactionID And SubmissionStatus.Status is null AND
       SubmissionStatus.operation = 'delete' AND SubmissionStatus.TableName = 'CaseFile2CMLink'
-- Where ID = '{$CaseFileId}'
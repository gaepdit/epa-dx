use NETWORKNODEFLOW;
GO

SELECT DISTINCT CaseFile2CMLink.CaseFileId,
                CaseFile2CMLink.ComplianceMonitoringId,
                CaseFile2CMLink.TransactionId,
                [Transaction].TransactionType,
                CONVERT(varchar(30), [Transaction].TransactionTimestamp, 126) as TransactionTimestamp
FROM CaseFile2CMLink
    INNER JOIN [Transaction]
        ON CaseFile2CMLink.TransactionId = [Transaction].TransactionID
    INNER JOIN SubmissionStatus
        ON CaseFile2CMLink.CaseFileId = SubmissionStatus.ID And SubmissionStatus.TableName = 'CaseFile2CMLink' And
           SubmissionStatus.Status is null AND SubmissionStatus.operation <> 'delete' AND
           [Transaction].TransactionID = SubmissionStatus.TransactionID
WHERE CaseFileId = '{$CaseFileId}'

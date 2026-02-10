use NETWORKNODEFLOW;
GO

SELECT DISTINCT CaseFile2DAEALink.*, [Transaction].TransactionType,
                CONVERT(varchar(30), [Transaction].TransactionTimestamp, 126) as TransactionTimestamp
FROM CaseFile2DAEALink
    INNER JOIN [Transaction]
    ON CaseFile2DAEALink.TransactionId = [Transaction].TransactionID
    INNER JOIN SubmissionStatus
    ON CaseFile2DAEALink.CaseFileId = SubmissionStatus.ID And SubmissionStatus.TableName = 'CaseFile2DAEALink' And
       SubmissionStatus.Status is null AND SubmissionStatus.operation <> 'delete' AND
       [Transaction].TransactionID = SubmissionStatus.TransactionID
-- Where CaseFileId = '{$CaseFileId}'
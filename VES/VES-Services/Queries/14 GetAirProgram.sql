use NETWORKNODEFLOW;
GO

SELECT TransactionType, CONVERT(varchar(30), TransactionTimestamp, 126) as TransactionTimestamp, AirPrograms.*,
       AirProgramSubpart.AirProgramSubpartID, AirProgramSubpart.AirProgramSubpartCode,
       AirProgramSubpart.AirProgramSubpartStatusIndicator
FROM [Transaction]
    INNER JOIN AirPrograms
    ON [Transaction].TransactionID = AirPrograms.TransactionID
    INNER JOIN SubmissionStatus
    ON AirPrograms.TransactionID = SubmissionStatus.TransactionID
    LEFT JOIN AirProgramSubpart
    on AirProgramSubpart.AirProgramID = AirPrograms.AirProgramID
WHERE SubmissionStatus.TableName = 'AirPrograms'
  AND SubmissionStatus.Status is NULL
  AND SubmissionStatus.Operation <> 'delete'
--   AND SubmissionStatus.ForeignKey in ('{$AirFacilityID}')
--   AND TransactionTimestamp between '{$fromDate}' and '{$toDate}'
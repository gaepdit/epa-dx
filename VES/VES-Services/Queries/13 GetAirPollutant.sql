use NETWORKNODEFLOW;
GO

SELECT TransactionType,
       CONVERT(varchar(30), TransactionTimestamp, 126) as TransactionTimestamp,
       AirPollutants.AirPollutantID,
       AirPollutants.AirFacilityID,
       AirPollutants.AirPollutantsCode,
       AirPollutants.AirPollutantStatusIndicator,
       AirPollutants.AirPollutantEPAClassificationCode,
       AirPollutants.AirPollutantEPAClassificationStartDate,
       AirPollutants.AirPollutantDAClassificationCode,
       AirPollutants.AirPollutantDAClassificationStartDate,
       AirPollutants.TransactionID
FROM [Transaction]
    INNER JOIN AirPollutants
        ON [Transaction].TransactionID = AirPollutants.TransactionID
    INNER JOIN SubmissionStatus
        ON AirPollutants.TransactionID = SubmissionStatus.TransactionID
WHERE SubmissionStatus.TableName = 'AirPollutants'
  AND SubmissionStatus.Status is NULL
  AND SubmissionStatus.Operation <> 'delete'
  AND SubmissionStatus.ForeignKey in ('{$AirFacilityID}')
  AND TransactionTimestamp between '{$fromDate}' and '{$toDate}'

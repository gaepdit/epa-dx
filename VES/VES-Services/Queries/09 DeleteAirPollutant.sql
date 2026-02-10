use NETWORKNODEFLOW;
GO

Select SubmissionStatus.TransactionID, SubmissionStatus.ForeignKey as   AirFacilityID,
       SubmissionStatus.ID as                                           AirPollutantsCode,
       [Transaction].TransactionType,
       CONVERT(varchar(30), [Transaction].TransactionTimestamp, 126) as TransactionTimestamp
from SubmissionStatus
    INNER JOIN [Transaction]
    on SubmissionStatus.TransactionID = [Transaction].TransactionID
where SubmissionStatus.TableName = 'AirPollutants'
  AND SubmissionStatus.Status is NULL
  AND SubmissionStatus.Operation = 'delete'
--   AND SubmissionStatus.ForeignKey in ('{$AirFacilityID}')
--   AND SubmissionStatus.ID = '{$AirPollutantsCode}'
--   AND [Transaction].TransactionTimestamp between '{$fromDate}' and '{$toDate}'
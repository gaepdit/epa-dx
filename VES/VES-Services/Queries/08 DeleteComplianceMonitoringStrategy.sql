use NETWORKNODEFLOW;
GO

Select SubmissionStatus.TransactionID, SubmissionStatus.ID           as AirFacilityID, [Transaction].TransactionType,
       CONVERT(varchar(30), [Transaction].TransactionTimestamp, 126) as TransactionTimestamp
from SubmissionStatus
    INNER JOIN [Transaction]
    on SubmissionStatus.TransactionID = [Transaction].TransactionID
where SubmissionStatus.TableName = 'AirComplianceMonitoringStrategy'
  AND SubmissionStatus.Status is NULL
  AND SubmissionStatus.Operation = 'delete'
--   AND SubmissionStatus.ID in ('{$AirFacilityID}')
--   AND [Transaction].TransactionTimestamp between '{$fromDate}' and '{$toDate}'
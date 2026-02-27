use NETWORKNODEFLOW;
GO

SELECT A.ComplianceMonitoringStrategyID, A.AirFacilityId, A.AirCMSMinimumFrequency, A.AirCMSSourceCategoryCode,
       A.AirCMSStartDate, A.AirActiveCMSPlanIndicator, A.AirRemovedPlanDate, A.Comments, A.TransactionID,
       [Transaction].TransactionType,
       CONVERT(varchar(30), [Transaction].TransactionTimestamp, 126) AS TransactionTimestamp
FROM AirComplianceMonitoringStrategy AS A
    INNER JOIN [Transaction]
    ON A.TransactionID = [Transaction].TransactionID
    INNER JOIN SubmissionStatus
    ON A.AirFacilityID = SubmissionStatus.ID
WHERE SubmissionStatus.TableName = 'AirComplianceMonitoringStrategy'
  AND SubmissionStatus.Status IS NULL
  AND SubmissionStatus.Operation <> 'delete'
--   AND SubmissionStatus.ID IN ('{$AirFacilityID}')
--   AND [Transaction].TransactionTimestamp BETWEEN '{$fromDate}' AND '{$toDate}'
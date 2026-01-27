use NETWORKNODEFLOW;
GO

SELECT C.ComplianceMonitoringId, C.ComplianceMonitoringDate, C.StartDate, C.InspectionTypeCode, C.ActivityName,
       C.NationalPrioritiesCode, C.MultimediaIndicator, C.PlannedStartDate, C.PlannedEndDate, C.RegionalPriorityCode,
       C.DeficienciesObservedIndicator, C.AirFacilityID, C.LeadAgencyCode, C.ProgramCode, C.OtherProgramDescriptionText,
       C.AirPollutantCode, C.OtherAgencyInitiativeText, C.InspectionUserDefinedField1, C.InspectionUserDefinedField2,
       C.InspectionUserDefinedField3, C.InspectionUserDefinedField4, C.InspectionUserDefinedField5,
       C.InspectionUserDefinedField6, AirPermit.AirPermitIdentifier, AirPermit.CertificationPeriodStartDate,
       AirPermit.CertificationPeriodEndDate, C.TVACCDueDate, C.FacilityReportedComplianceStatusCode, C.TransactionID,
       TVACCReviewData.TVACCReviewDataId, TVACCReviewData.TVACCReviewedDate,
       TVACCReviewData.FacilityReportDeviationsIndicator, TVACCReviewData.PermitConditionsText,
       TVACCReviewData.ExceedanceExcursionIndicator, TVACCReviewData.ReviewerAgencyCode,
       TVACCReviewData.TVACCReviewerName, TVACCReviewData.ReviewerComment, ComplianceMonitoringContact.ContactId,
       Contact.AffiliationTypeText, Contact.FirstName, Contact.MiddleName, Contact.LastName,
       Contact.IndividualTitleText, Contact.OrganizationFormalName, Contact.StateCode, Telephone.TelephoneID,
       Telephone.TelephoneNumberTypeCode, Telephone.TelephoneNumber, Telephone.TelephoneExtensionNumber,
       InspectionGovernmentContact.ContactId AS                         GContactId,
       GContact.AffiliationTypeText AS                                  GAffiliationTypeText,
       GContact.ElectronicAddressText AS                                GElectronicAddressText,
       [Transaction].TransactionType,
       CONVERT(varchar(30), [Transaction].TransactionTimestamp, 126) as TransactionTimestamp,
       ComplianceMonitoringCodeId, CodeName, CodeValue, ComplianceMonitoringCommentId, CommentName, CommentText
FROM ComplianceMonitoring C
    LEFT JOIN ComplianceMonitoringCode
    ON C.ComplianceMonitoringId = ComplianceMonitoringCode.ComplianceMonitoringId
    LEFT JOIN ComplianceMonitoringComment
    ON C.ComplianceMonitoringId = ComplianceMonitoringComment.ComplianceMonitoringId
    LEFT JOIN TVACCReviewData
    ON C.ComplianceMonitoringId = TVACCReviewData.ComplianceMonitoringId
    LEFT JOIN ComplianceMonitoringContact
    ON C.ComplianceMonitoringId = ComplianceMonitoringContact.ComplianceMonitoringId
    LEFT JOIN AirPermit
    on AirPermit.ComplianceMonitoringId = C.ComplianceMonitoringId
    LEFT JOIN Contact
    ON ComplianceMonitoringContact.ContactId = Contact.ContactID
    LEFT JOIN Telephone
    ON Contact.ContactID = Telephone.ContactID
    LEFT JOIN InspectionGovernmentContact
    ON C.ComplianceMonitoringId = InspectionGovernmentContact.ComplianceMonitoringId
    LEFT JOIN Contact GContact
    ON InspectionGovernmentContact.ContactId = GContact.ContactID
    INNER JOIN [Transaction]
    ON C.TransactionID = [Transaction].TransactionID
    INNER JOIN SubmissionStatus
    ON C.ComplianceMonitoringId = SubmissionStatus.ID
WHERE C.MonitoringType = 'TVACC'
  AND SubmissionStatus.TableName = 'ComplianceMonitoring'
  AND SubmissionStatus.Status is NULL
  AND SubmissionStatus.Operation <> 'delete'
--   AND SubmissionStatus.ID in ('{$ComplianceMonitoringID}')
--   AND [Transaction].TransactionTimestamp between '{$fromDate}' and '{$toDate}'
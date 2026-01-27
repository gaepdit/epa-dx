use NETWORKNODEFLOW;
GO

SELECT EnforcementAction.EnforcementActionId, EnforcementAction.EnforcementActionName, EnforcementAction.Forum,
       EnforcementAction.ResolutionTypeCode, EnforcementAction.AirDACombinedOrSupersededByEAID,
       EnforcementAction.ReasonDeletingRecord, EnforcementAction.AchievedDate, EnforcementAction.FileNumber,
       EnforcementAction.EAUserDefinedField1, EnforcementAction.EAUserDefinedField2,
       EnforcementAction.EAUserDefinedField3, EnforcementAction.EAUserDefinedField4,
       EnforcementAction.EAUserDefinedField5, EnforcementAction.EAUserDefinedField6, EnforcementAction.LeadAgencyCode,
       EnforcementAction.EnforcementAgencyName, EnforcementAction.OtherAgencyInitiativeText,
       EnforcementAction.StateSectionsViolatedText, EnforcementAction.SensitiveDataInd,
       EnforcementActionAirFacility.AirFacilityId, EnforcementActionCode.CodeName, EnforcementActionCode.CodeValue,
       EnforcementActionCode.EnforcementActionCodeId, EAComment.EAInspectionCommentId, EAComment.CommentName,
       EAComment.CommentText, EAGovernmentContact.ContactId, Contact.AffiliationTypeText, Contact.ElectronicAddressText,
       Contact.StartDateOfContactAssociation, Contact.EndDateOfContactAssociation, EnforcementAction.TransactionID,
       CONVERT(varchar(30), [Transaction].TransactionTimestamp, 126)                  AS TransactionTimestamp,
       AirDAFinalOrder.AirDAFinalOrderId, AirDAFinalOrder.FinalOrderTypeCode,
       AirDAFinalOrder.FinalOrderIssuedEnteredDate, AirDAFinalOrder.AirEnforcementActionResolvedDate,
       AirDAFinalOrder.CashCivilPenaltyRequiredAmount, AirDAFinalOrder.OtherComments,
       AirDAFinalOrder.FinalOrderIdentifier, AirDAFinalOrderAirFacility.AirFacilityId AS FinalOrderAirFacilityIdentifier
FROM EnforcementAction
    INNER JOIN EnforcementActionAirFacility
    ON EnforcementAction.EnforcementActionId = EnforcementActionAirFacility.EnforcementActionId AND
       EnforcementAction.Type = 'DAFormal'
    LEFT JOIN EnforcementActionCode
    ON EnforcementAction.EnforcementActionId = EnforcementActionCode.EnforcementActionId
    LEFT JOIN EAComment
    ON EnforcementAction.EnforcementActionId = EAComment.EnforcementActionId
    LEFT JOIN AirDAFinalOrder
    ON EnforcementAction.EnforcementActionId = AirDAFinalOrder.EnforcementActionId
    LEFT JOIN AirDAFinalOrderAirFacility
    ON AirDAFinalOrder.AirDAFinalOrderId = AirDAFinalOrderAirFacility.AirDAFinalOrderId
    LEFT JOIN EAGovernmentContact
    ON EnforcementAction.EnforcementActionId = EAGovernmentContact.EnforcementActionId
    LEFT JOIN Contact
    ON EAGovernmentContact.ContactId = Contact.ContactID
    INNER JOIN [Transaction]
    ON EnforcementAction.TransactionId = [Transaction].TransactionID
    INNER JOIN SubmissionStatus
    ON [Transaction].TransactionID = SubmissionStatus.TransactionID AND
       EnforcementAction.EnforcementActionId = SubmissionStatus.ID AND
       SubmissionStatus.TableName = 'EnforcementAction' AND SubmissionStatus.Status IS NULL AND
       SubmissionStatus.Operation <> 'delete'
-- WHERE SubmissionStatus.ID IN ('{$EnforcementActionID}')
--   AND [Transaction].TransactionTimestamp BETWEEN '{$fromDate}' AND '{$toDate}'
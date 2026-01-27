use NETWORKNODEFLOW;
GO

SELECT EnforcementAction.EnforcementActionId,
       EnforcementAction.EnforcementActionTypeCode,
       EnforcementAction.EnforcementActionName,
       EnforcementAction.ResolutionTypeCode,
       EnforcementAction.ReasonDeletingRecord,
       EnforcementAction.AchievedDate,
       EnforcementAction.FileNumber,
       EnforcementAction.EAUserDefinedField1,
       EnforcementAction.EAUserDefinedField2,
       EnforcementAction.EAUserDefinedField3,
       EnforcementAction.EAUserDefinedField4,
       EnforcementAction.EAUserDefinedField5,
       EnforcementAction.EAUserDefinedField6,
       EnforcementAction.LeadAgencyCode,
       EnforcementAction.EnforcementAgencyName,
       EnforcementAction.OtherAgencyInitiativeText,
       EnforcementAction.StateSectionsViolatedText,
       EnforcementAction.SensitiveDataInd,
       EnforcementActionAirFacility.AirFacilityId,
       EnforcementActionCode.CodeName,
       EnforcementActionCode.CodeValue,
       EnforcementActionCode.EnforcementActionCodeId,
       EAComment.EAInspectionCommentId,
       EAComment.CommentName,
       EAComment.CommentText,
       EAGovernmentContact.ContactId,
       Contact.AffiliationTypeText,
       Contact.FirstName,
       Contact.MiddleName,
       Contact.LastName,
       Contact.IndividualTitleText,
       Contact.OrganizationFormalName,
       Contact.StateCode,
       Contact.RegionCode,
       Contact.ElectronicAddressText,
       Contact.StartDateOfContactAssociation,
       Contact.EndDateOfContactAssociation,
       EnforcementAction.TransactionID,
       CONVERT(VARCHAR(30), [Transaction].TransactionTimestamp, 126) as TransactionTimestamp
FROM EnforcementAction
    INNER JOIN EnforcementActionAirFacility
        ON EnforcementAction.EnforcementActionId = EnforcementActionAirFacility.EnforcementActionId AND
           EnforcementAction.Type = 'DAInFormal'
    Left JOIN EnforcementActionCode
        ON EnforcementAction.EnforcementActionId = EnforcementActionCode.EnforcementActionId
    Left JOIN EAComment
        ON EnforcementAction.EnforcementActionId = EAComment.EnforcementActionId
    Left JOIN EAGovernmentContact
        ON EnforcementAction.EnforcementActionId = EAGovernmentContact.EnforcementActionId
    Left JOIN Contact
        ON EAGovernmentContact.ContactId = Contact.ContactID
    INNER JOIN [Transaction]
        ON EnforcementAction.TransactionId = [Transaction].TransactionID
    INNER JOIN SubmissionStatus
        ON [Transaction].TransactionID = SubmissionStatus.TransactionID AND
           EnforcementAction.EnforcementActionId = SubmissionStatus.ID AND
           SubmissionStatus.TableName = 'EnforcementAction' AND SubmissionStatus.Status is NULL AND
           SubmissionStatus.Operation <> 'delete'
-- WHERE SubmissionStatus.ID in ('{$EnforcementActionID}') AND
--       [Transaction].TransactionTimestamp between '{$fromDate}' and '{$toDate}'

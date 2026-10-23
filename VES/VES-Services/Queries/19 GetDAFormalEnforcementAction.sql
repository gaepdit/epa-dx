use NETWORKNODEFLOW;
GO

SELECT ea.EnforcementActionId,
       ea.EnforcementActionName,
       ea.Forum,
       ea.ResolutionTypeCode,
       ea.AirDACombinedOrSupersededByEAID,
       ea.ReasonDeletingRecord,
       ea.AchievedDate,
       ea.FileNumber,
       ea.EAUserDefinedField1,
       ea.EAUserDefinedField2,
       ea.EAUserDefinedField3,
       ea.EAUserDefinedField4,
       ea.EAUserDefinedField5,
       ea.EAUserDefinedField6,
       ea.LeadAgencyCode,
       ea.EnforcementAgencyName,
       ea.OtherAgencyInitiativeText,
       ea.StateSectionsViolatedText,
       ea.SensitiveDataInd,
       fa.AirFacilityId,
       cd.CodeName,
       cd.CodeValue,
       cd.EnforcementActionCodeId,
       cm.EAInspectionCommentId,
       cm.CommentName,
       cm.CommentText,
       gc.ContactId,
       cn.AffiliationTypeText,
       cn.ElectronicAddressText,
       cn.StartDateOfContactAssociation,
       cn.EndDateOfContactAssociation,
       ea.TransactionID,
       CONVERT(varchar(30), tr.TransactionTimestamp, 126) AS TransactionTimestamp,
       fo.AirDAFinalOrderId,
       fo.FinalOrderTypeCode,
       fo.FinalOrderIssuedEnteredDate,
       fo.AirEnforcementActionResolvedDate,
       fo.CashCivilPenaltyRequiredAmount,
       fo.OtherComments,
       fo.FinalOrderIdentifier,
       ff.AirFacilityId                                   AS FinalOrderAirFacilityIdentifier,
       sp.StipulatedPenaltiesId,
       sp.DemandStipulatedPenaltyAmount,
       sp.DemandStipulatedPenaltyPaidDate
FROM EnforcementAction ea
    INNER JOIN EnforcementActionAirFacility fa
        ON ea.EnforcementActionId = fa.EnforcementActionId AND
           ea.Type = 'DAFormal'
    LEFT JOIN EnforcementActionCode cd
        ON ea.EnforcementActionId = cd.EnforcementActionId
    LEFT JOIN EAComment cm
        ON ea.EnforcementActionId = cm.EnforcementActionId
    LEFT JOIN AirDAFinalOrder fo
        ON ea.EnforcementActionId = fo.EnforcementActionId
    LEFT JOIN AirDAFinalOrderAirFacility ff
        ON fo.AirDAFinalOrderId = ff.AirDAFinalOrderId
    LEFT JOIN EAGovernmentContact gc
        ON ea.EnforcementActionId = gc.EnforcementActionId
    LEFT JOIN Contact cn
        ON gc.ContactId = cn.ContactID
    LEFT JOIN StipulatedPenalties sp
        on fo.AirDAFinalOrderId = sp.AirDAFinalOrderId
    INNER JOIN [Transaction] tr
        ON ea.TransactionId = tr.TransactionID
    INNER JOIN SubmissionStatus ss
        ON tr.TransactionID = ss.TransactionID
        AND ea.EnforcementActionId = ss.ID
        AND ss.TableName = 'EnforcementAction'
        AND ss.Status IS NULL
        AND ss.Operation <> 'delete'
WHERE ss.ID IN ('{$EnforcementActionID}')
  AND tr.TransactionTimestamp BETWEEN '{$fromDate}' AND '{$toDate}'

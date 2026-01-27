use NETWORKNODEFLOW;
GO

SELECT CaseFile.CaseFileId, CaseFile.CaseFileName, CaseFile.LeadAgencyCode, CaseFile.AirFacilityId,
       CaseFile.OtherProgramDescription, CaseFile.SensitiveDataIndicator, CaseFile.LeadAgencyChangeSuperseded,
       CaseFile.AdvisementMethodTypeCode, CaseFile.AdvisementMethodDate, CaseFile.CaseFileUserDefinedField1,
       CaseFile.CaseFileUserDefinedField2, CaseFile.CaseFileUserDefinedField3, CaseFile.CaseFileUserDefinedField4,
       CaseFile.CaseFileUserDefinedField5, CaseFile.CaseFileUserDefinedField6, CaseFile.TransactionID,
       CaseFileCode.CaseFileCodeId, CaseFileCode.CodeName, CaseFileCode.CodeValue, CaseFileComment.CaseFileCommentId,
       CaseFileComment.CommentName, CaseFileComment.CommentText, OtherPathwayActivityData.OtherPathwayActivityDataId,
       OtherPathwayActivityData.OtherPathwayCategoryCode, OtherPathwayActivityData.OtherPathwayTypeCode,
       format(OtherPathwayActivityData.OtherPathwayDate, 'yyyy-MM-dd')                                         AS OtherPathwayDate,
       AirViolationData.AirViolationDataId, AirViolationData.AirViolationTypeCode,
       AirViolationData.AirViolationProgramCode, AIRVIOLATIONDATA.AIRVIOLATIONPROGRAMDESC,
       AirViolationData.AirViolationPollutantCode,
       format(AirViolationData.FRVDeterminationDate, 'yyyy-MM-dd')                                             AS FRVDeterminationDate,
       format(AirViolationData.HPVDayZeroDate, 'yyyy-MM-dd')                                                   AS HPVDayZeroDate,
       format(AirViolationData.OccurrenceStartDate, 'yyyy-MM-dd')                                              AS OccurrenceStartDate,
       format(AirViolationData.OccurrenceEndDate, 'yyyy-MM-dd')                                                AS OccurrenceEndDate,
       AIRVIOLATIONDATA.HPVREMOVALTYPECODE,
       format(AirViolationData.HPVREMOVALDATE, 'yyyy-MM-dd')                                                   AS HPVREMOVALDATE,
       [Transaction].TransactionType,
       CONVERT(varchar(30), [Transaction].TransactionTimestamp, 126)                                           AS TransactionTimestamp
FROM CaseFile
    LEFT JOIN CaseFileCode
    ON CaseFile.CaseFileId = CaseFileCode.CaseFileId
    LEFT JOIN CaseFileComment
    ON CaseFile.CaseFileId = CaseFileComment.CaseFileId
    LEFT JOIN OtherPathwayActivityData
    ON CaseFile.CaseFileId = OtherPathwayActivityData.CaseFileId
    LEFT JOIN AirViolationData
    ON CaseFile.CaseFileId = AirViolationData.CaseFileId
    LEFT JOIN [Transaction]
    ON CaseFile.TransactionID = [Transaction].TransactionID
    INNER JOIN SubmissionStatus
    ON [Transaction].TransactionID = SubmissionStatus.TransactionID AND SubmissionStatus.ID = CaseFile.CaseFileId AND
       SubmissionStatus.TableName = 'CaseFile' AND SubmissionStatus.Status IS NULL AND
       SubmissionStatus.Operation <> 'delete'
-- WHERE SubmissionStatus.ID IN ('{$CaseFileID}')
--   AND [Transaction].TransactionTimestamp BETWEEN '{$fromDate}' AND '{$toDate}'
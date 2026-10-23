USE [NETWORKNODEFLOW];
GO
SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO

/*****************************************************************************

Author:     Doug Waldron
Overview:   This file updates triggers created in the VES schema

Modification History:
When        Who             What
----------  --------------  ----------------------------------------
2017-11-07  DWaldron        Fix references to `deleted` table (DX-61)

*******************************************************************************/

ALTER TRIGGER [dbo].[CaseFile2FederalEALink_Delete_Trigger]
ON [dbo].[CaseFile2FederalEALink]
AFTER DELETE
AS
BEGIN
    SET NOCOUNT ON;

    INSERT
        [dbo].[SubmissionStatus]
        (TransactionID, TableName, ID, ForeignKey, Operation)
        SELECT
            i.TransactionID,
            'CaseFile2FederalEALink',
            i.CaseFileId,
            i.EnforcementActionId,
            'delete'
        FROM
            deleted i

END
GO

ALTER TRIGGER [dbo].[CaseFile2DAEALink_Delete_Trigger]
ON [dbo].[CaseFile2DAEALink]
AFTER DELETE
AS
BEGIN
    SET NOCOUNT ON;

    INSERT
        [dbo].[SubmissionStatus]
        (TransactionID, TableName, ID, ForeignKey, Operation)
        SELECT
            i.TransactionID,
            'CaseFile2DAEALink',
            i.CaseFileId,
            i.EnforcementActionId,
            'delete'
        FROM
            deleted i

END
GO

ALTER TRIGGER [dbo].[CaseFile2CMLink_Delete_Trigger]
ON [dbo].[CaseFile2CMLink]
AFTER DELETE
AS
BEGIN
    SET NOCOUNT ON;

    INSERT
        [dbo].[SubmissionStatus]
        (TransactionID, TableName, ID, ForeignKey, Operation)
        SELECT
            i.TransactionID,
            'CaseFile2CMLink',
            i.CaseFileId,
            i.ComplianceMonitoringId,
            'delete'
        FROM
            deleted i

END
GO

ALTER TRIGGER [dbo].[CaseFile2CaseFileLink_Delete_Trigger]
ON [dbo].[CaseFile2CaseFileLink]
AFTER DELETE
AS
BEGIN
    SET NOCOUNT ON;

    INSERT
        [dbo].[SubmissionStatus]
        (TransactionID, TableName, ID, ForeignKey, Operation)
        SELECT
            i.TransactionID,
            'CaseFile2CaseFileLink',
            i.CaseFileId,
            i.LinkedCaseFileId,
            'delete'
        FROM
            deleted i

END
GO

ALTER TRIGGER [dbo].[CM2DAEALink_Delete_Trigger]
ON [dbo].[CM2DAEALink]
AFTER DELETE
AS
BEGIN
    SET NOCOUNT ON;

    INSERT
        [dbo].[SubmissionStatus]
        (TransactionID, TableName, ID, ForeignKey, Operation)
        SELECT
            i.TransactionID,
            'CM2DAEALink',
            i.ComplianceMonitoringId,
            i.EnforcementActionId,
            'delete'
        FROM
            deleted i

END
GO

ALTER TRIGGER [dbo].[CM2CMLink_Delete_Trigger]
ON [dbo].[CM2CMLink]
AFTER DELETE
AS
BEGIN
    SET NOCOUNT ON;

    INSERT
        [dbo].[SubmissionStatus]
        (TransactionID, TableName, ID, ForeignKey, Operation)
        SELECT
            i.TransactionID,
            'CM2CMLink',
            i.ComplianceMonitoringId,
            i.LinkedCMId,
            'delete'
        FROM
            deleted i

END
GO

ALTER TRIGGER [dbo].[CM2FederalEALink_Delete_Trigger]
ON [dbo].[CM2FederalEALink]
AFTER DELETE
AS
BEGIN
    SET NOCOUNT ON;

    INSERT
        [dbo].[SubmissionStatus]
        (TransactionID, TableName, ID, ForeignKey, Operation)
        SELECT
            i.TransactionID,
            'CM2FederalEALink',
            i.ComplianceMonitoringId,
            i.EnforcementActionId,
            'delete'
        FROM
            deleted i

END
GO

ALTER TRIGGER [dbo].[DAEA2DAEALink_Delete_Trigger]
ON [dbo].[DAEA2DAEALink]
AFTER DELETE
AS
BEGIN
    SET NOCOUNT ON;

    INSERT
        [dbo].[SubmissionStatus]
        (TransactionID, TableName, ID, ForeignKey, Operation)
        SELECT
            i.TransactionID,
            'DAEA2DAEALink',
            i.EnforcementActionId,
            i.LinkedEAId,
            'delete'
        FROM
            deleted i

END
GO

ALTER TRIGGER [dbo].[DAEA2FederalEALink_Delete_Trigger]
ON [dbo].[DAEA2FederalEALink]
AFTER DELETE
AS
BEGIN
    SET NOCOUNT ON;

    INSERT
        [dbo].[SubmissionStatus]
        (TransactionID, TableName, ID, ForeignKey, Operation)
        SELECT
            i.TransactionID,
            'DAEA2FederalEALink',
            i.EnforcementActionId,
            i.LinkedEAId,
            'delete'
        FROM
            deleted i

END
GO

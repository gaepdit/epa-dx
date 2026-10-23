create table CaseFile2CMLink
(
    CaseFileId             varchar(50) not null,
    ComplianceMonitoringId varchar(50) not null,
    TransactionId          varchar(40),
    constraint PK_CaseFile2CMLink
        primary key (CaseFileId, ComplianceMonitoringId)
            with (fillfactor = 80)
);


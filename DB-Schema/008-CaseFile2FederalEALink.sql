create table CaseFile2FederalEALink
(
    CaseFileId          varchar(50) not null,
    EnforcementActionId varchar(50) not null,
    TransactionId       varchar(40),
    constraint PK_CaseFile2FederalEALink
        primary key (CaseFileId, EnforcementActionId)
            with (fillfactor = 80)
);


create table CaseFile2DAEALink
(
    CaseFileId          varchar(50) not null,
    EnforcementActionId varchar(50) not null,
    TransactionId       varchar(40),
    constraint PK_CaseFile2DAEALink
        primary key (CaseFileId, EnforcementActionId)
            with (fillfactor = 80)
);


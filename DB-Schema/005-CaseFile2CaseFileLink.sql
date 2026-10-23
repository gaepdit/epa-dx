create table CaseFile2CaseFileLink
(
    CaseFileId       varchar(50) not null,
    LinkedCaseFileId varchar(50) not null,
    TransactionId    varchar(40),
    constraint PK_CaseFile2CaseFlieLink
        primary key (CaseFileId, LinkedCaseFileId)
            with (fillfactor = 80)
);


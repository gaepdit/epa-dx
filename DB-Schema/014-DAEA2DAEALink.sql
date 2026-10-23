create table DAEA2DAEALink
(
    EnforcementActionId varchar(50) not null,
    LinkedEAId          varchar(50) not null,
    TransactionId       varchar(40),
    constraint PK_DAEA2DAEALink
        primary key (EnforcementActionId, LinkedEAId)
            with (fillfactor = 80)
);


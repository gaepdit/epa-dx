create table DAEA2FederalEALink
(
    EnforcementActionId varchar(50) not null,
    LinkedEAId          varchar(50) not null,
    TransactionId       varchar(40),
    constraint PK_DAEA2FederalEALink
        primary key (EnforcementActionId, LinkedEAId)
            with (fillfactor = 80)
);


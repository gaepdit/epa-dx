create table DeletedEnforcementAction
(
    EnforcementActionId  varchar(25)  not null,
    ReasonDeletingRecord varchar(200) not null,
    Type                 varchar(10)  not null,
    DeletedTimeStamp     datetime     not null,
    TransactionId        varchar(50)  not null
);


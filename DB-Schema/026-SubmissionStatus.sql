create table SubmissionStatus
(
    TransactionID varchar(50)                             not null,
    TableName     varchar(50)                             not null,
    ID            varchar(50)                             not null,
    ForeignKey    varchar(50),
    Operation     varchar(15)                             not null,
    CreateDate    datetime
        constraint DF_Table_1_TimeStamp default getdate() not null,
    Status        varchar(15),
    SubmitDate    datetime,
    StatusDetail  varchar(1000)
);

create index SubmissionStatus_Status_ID_index
    on SubmissionStatus (Status, ID) include (SubmitDate);


create table [Transaction]
(
    TransactionID        varchar(50)
        constraint DF_Transaction_TransactionID default CONVERT([varchar](50), newid(), 0) not null,
    TransactionType      varchar(10)                                                       not null,
    TransactionTimestamp datetime,
    constraint PK_Transaction
        primary key (TransactionID)
            with (fillfactor = 80)
);


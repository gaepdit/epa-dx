create table CM2CMLink
(
    ComplianceMonitoringId varchar(50) not null,
    LinkedCMId             varchar(50) not null,
    TransactionId          varchar(40),
    constraint PK_CM2CMLink
        primary key (ComplianceMonitoringId, LinkedCMId)
            with (fillfactor = 80)
);


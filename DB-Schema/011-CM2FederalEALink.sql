create table CM2FederalEALink
(
    ComplianceMonitoringId varchar(50) not null,
    EnforcementActionId    varchar(50) not null,
    TransactionId          varchar(40),
    constraint PK_CM2FederalEALink
        primary key (ComplianceMonitoringId, EnforcementActionId)
            with (fillfactor = 80)
);


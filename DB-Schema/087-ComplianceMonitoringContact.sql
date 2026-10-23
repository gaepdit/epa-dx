create table ComplianceMonitoringContact
(
    ComplianceMonitoringId varchar(25) not null,
    ContactId              int         not null,
    constraint PK_ComplianceMonitoringContact
        primary key (ComplianceMonitoringId, ContactId)
            with (fillfactor = 80),
    constraint FK_ComplianceMonitoringContact_ComplianceMonitoring
        foreign key (ComplianceMonitoringId) references ComplianceMonitoring,
    constraint FK_ComplianceMonitoringContact_Contact
        foreign key (ContactId) references Contact
);


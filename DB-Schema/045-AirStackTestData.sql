create table AirStackTestData
(
    ComplianceMonitoringId    varchar(25) not null,
    StackTestStatusCode       varchar(10),
    ConductorTypeCode         varchar(10),
    StackIdentifier           varchar(25),
    StackTestPurposeCode      varchar(10),
    OtherStackTestPurposeName varchar(50),
    ObservedAgencyTypeCode    varchar(10),
    ReportReceivedDate        date,
    ResultsReviewedDate       date,
    constraint PK_AirStackTestData
        primary key (ComplianceMonitoringId)
            with (fillfactor = 80),
    constraint FK_AirStackTestData_ComplianceMonitoring
        foreign key (ComplianceMonitoringId) references ComplianceMonitoring
            on delete cascade
);


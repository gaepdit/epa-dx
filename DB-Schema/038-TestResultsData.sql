create table TestResultsData
(
    TestResultsDataId      int identity,
    AirTestedPollutantCode varchar(10) not null,
    TestResultCode         varchar(10),
    MethodCode             varchar(10),
    AllowableValue         varchar(10),
    AllowableUnitCode      varchar(10),
    ActualResult           varchar(10),
    FailureReasonCode      varchar(10),
    OtherFailureReasonText varchar(500),
    ComplianceMonitoringId varchar(25),
    constraint PK_TestResultsData
        primary key (TestResultsDataId)
            with (fillfactor = 80),
    constraint FK_TestResultsData_ComplianceMonitoring
        foreign key (ComplianceMonitoringId) references ComplianceMonitoring
);


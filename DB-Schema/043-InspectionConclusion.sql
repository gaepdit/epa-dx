create table InspectionConclusion
(
    InspectionConclusionId                  int identity,
    ComplianceMonitoringId                  varchar(25) not null,
    DeficienciesObservedInd                 char,
    DeficiencyCommunicatedFacilityInd       char,
    FacilityActionObservedInd               char,
    NationalPolicyGeneralAssistanceInd      char,
    NationalPolicySiteSpecificAssistanceInd char,
    constraint PK_InspectionConclusion
        primary key (InspectionConclusionId)
            with (fillfactor = 80),
    constraint FK_InspectionConclusion_ComplianceMonitoring
        foreign key (ComplianceMonitoringId) references ComplianceMonitoring
);


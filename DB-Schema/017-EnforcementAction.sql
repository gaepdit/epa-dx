create table EnforcementAction
(
    EnforcementActionId             varchar(25) not null,
    EnforcementActionTypeCode       varchar(20),
    EnforcementActionName           varchar(100),
    Forum                           varchar(100),
    ResolutionTypeCode              varchar(5),
    AirDACombinedOrSupersededByEAID varchar(50),
    ReasonDeletingRecord            varchar(5),
    AchievedDate                    date,
    FileNumber                      int,
    EAUserDefinedField1             varchar(3),
    EAUserDefinedField2             varchar(50),
    EAUserDefinedField3             varchar(50),
    EAUserDefinedField4             date,
    EAUserDefinedField5             date,
    EAUserDefinedField6             varchar(4000),
    LeadAgencyCode                  varchar(10),
    EnforcementAgencyName           varchar(100),
    OtherAgencyInitiativeText       varchar(4000),
    StateSectionsViolatedText       varchar(4000),
    SensitiveDataInd                varchar(3),
    Type                            varchar(20),
    TransactionID                   varchar(50),
    OtherProgramDescriptionText     varchar(4000),
    constraint PK_EnforcementAction
        primary key (EnforcementActionId)
            with (fillfactor = 80)
);


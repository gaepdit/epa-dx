create table CaseFile
(
    CaseFileId                 varchar(25)  not null,
    CaseFileName               varchar(100) not null,
    LeadAgencyCode             varchar(10)  not null,
    AirFacilityId              varchar(25)  not null,
    OtherProgramDescription    varchar(4000),
    SensitiveDataIndicator     char,
    LeadAgencyChangeSuperseded varchar(4000),
    AdvisementMethodTypeCode   varchar(10),
    AdvisementMethodDate       date,
    CaseFileUserDefinedField1  varchar(3),
    CaseFileUserDefinedField2  varchar(50),
    CaseFileUserDefinedField3  varchar(50),
    CaseFileUserDefinedField4  date,
    CaseFileUserDefinedField5  date,
    CaseFileUserDefinedField6  varchar(4000),
    TransactionID              varchar(50),
    constraint PK_CaseFile
        primary key (CaseFileId)
            with (fillfactor = 80)
);


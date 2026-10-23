create table InspectionConclusionCode
(
    InspectionConclusionCodeId int identity,
    InspectionConclusionId     int          not null,
    CodeName                   varchar(100) not null,
    CodeValue                  varchar(100) not null,
    constraint PK_InspectionConclusionCode
        primary key (InspectionConclusionCodeId)
            with (fillfactor = 80)
);


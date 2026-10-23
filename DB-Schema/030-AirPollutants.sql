create table AirPollutants
(
    AirPollutantID                         int identity,
    AirFacilityID                          varchar(20) not null,
    AirPollutantsCode                      varchar(10),
    AirPollutantStatusIndicator            char,
    AirPollutantEPAClassificationCode      varchar(10),
    AirPollutantEPAClassificationStartDate date,
    AirPollutantDAClassificationCode       varchar(10),
    AirPollutantDAClassificationStartDate  date,
    TransactionID                          varchar(50),
    constraint PK_AirPollutants_1
        primary key (AirPollutantID)
            with (fillfactor = 80),
    constraint FK_AirPollutants_AirFacility
        foreign key (AirFacilityID) references AirFacility
            on delete cascade
);


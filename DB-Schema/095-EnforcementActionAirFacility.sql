create table EnforcementActionAirFacility
(
    EnforcementActionId varchar(25) not null,
    AirFacilityId       varchar(20) not null,
    constraint PK_EnforcementActionAirFacility
        primary key (EnforcementActionId, AirFacilityId)
            with (fillfactor = 80),
    constraint FK_EnforcementActionAirFacility_EnforcementAction
        foreign key (EnforcementActionId) references EnforcementAction
            on delete cascade
);


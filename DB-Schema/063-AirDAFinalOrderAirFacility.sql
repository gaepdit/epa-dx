create table AirDAFinalOrderAirFacility
(
    AirDAFinalOrderId varchar(40) not null,
    AirFacilityId     varchar(20) not null,
    constraint PK_AirDAFinalOrderAirFacility
        primary key (AirDAFinalOrderId)
            with (fillfactor = 80),
    constraint FK_AirDAFinalOrderAirFacility_AirDAFinalOrder
        foreign key (AirDAFinalOrderId) references AirDAFinalOrder
            on delete cascade
);


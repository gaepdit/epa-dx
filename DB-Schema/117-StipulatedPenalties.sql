create table StipulatedPenalties
(
    StipulatedPenaltiesId           varchar(40) not null,
    AirDAFinalOrderId               varchar(40) not null,
    DemandStipulatedPenaltyAmount   varchar(10),
    DemandStipulatedPenaltyPaidDate date
        constraint PK_StipulatedPenalties
            primary key (StipulatedPenaltiesId)
    constraint FK_StipulatedPenalties_AirDAFinalOrder
        foreign key (AirDAFinalOrderId) references AirDAFinalOrder
            on delete cascade
);

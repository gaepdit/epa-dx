create table AirDAFinalOrder
(
    AirDAFinalOrderId                varchar(40) not null,
    EnforcementActionId              varchar(25) not null,
    FinalOrderTypeCode               varchar(10),
    FinalOrderIssuedEnteredDate      date,
    AirEnforcementActionResolvedDate date,
    CashCivilPenaltyRequiredAmount   varchar(10),
    OtherComments                    varchar(4000),
    FinalOrderIdentifier             int,
    constraint PK_AirDAFinalOrder
        primary key (AirDAFinalOrderId)
            with (fillfactor = 80),
    constraint FK_AirDAFinalOrder_EnforcementAction
        foreign key (EnforcementActionId) references EnforcementAction
            on delete cascade
);


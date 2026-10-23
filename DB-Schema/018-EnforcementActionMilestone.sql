create table EnforcementActionMilestone
(
    EnforcementActionMilestoneId int identity,
    EnforcementActionId          varchar(25) not null,
    MilestonePlannedDate         date,
    MilestoneActualDate          date,
    Type                         varchar(20) not null,
    TransactionID                varchar(50),
    constraint PK_EnforcementActionMilestone
        primary key (EnforcementActionMilestoneId)
            with (fillfactor = 80)
);


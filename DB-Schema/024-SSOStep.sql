create table SSOStep
(
    SSOStepId                       int identity,
    SSOInspectionId                 int        not null,
    StepsReducePreventMitigate      varchar(3) not null,
    OtherStepsReducePreventMitigate varchar(50),
    constraint PK_SSOStep
        primary key (SSOStepId)
            with (fillfactor = 80)
);


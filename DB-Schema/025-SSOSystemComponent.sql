create table SSOSystemComponent
(
    SSOSystemComponentId int identity,
    SSOInspectionId      int        not null,
    SystemComponent      varchar(3) not null,
    OtherSystemComponent varchar(50),
    constraint PK_SSOSystemComponent
        primary key (SSOSystemComponentId)
            with (fillfactor = 80)
);


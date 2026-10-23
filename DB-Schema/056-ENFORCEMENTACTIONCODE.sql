create table ENFORCEMENTACTIONCODE
(
    ENFORCEMENTACTIONCODEID varchar(40) not null,
    ENFORCEMENTACTIONID     varchar(25) not null,
    CODENAME                varchar(50) not null,
    CODEVALUE               varchar(20) not null,
    constraint SYS_C00138189
        primary key (ENFORCEMENTACTIONCODEID)
            with (fillfactor = 80),
    constraint FK_EnforcementActionCode_EnforcementAction
        foreign key (ENFORCEMENTACTIONID) references EnforcementAction
            on delete cascade
);


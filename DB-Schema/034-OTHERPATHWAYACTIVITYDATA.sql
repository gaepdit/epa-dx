create table OTHERPATHWAYACTIVITYDATA
(
    OTHERPATHWAYACTIVITYDATAID varchar(40) not null,
    CASEFILEID                 varchar(25) not null,
    OTHERPATHWAYCATEGORYCODE   varchar(10),
    OTHERPATHWAYTYPECODE       varchar(10),
    OTHERPATHWAYDATE           datetime2(0),
    constraint SYS_C00138198
        primary key (OTHERPATHWAYACTIVITYDATAID)
            with (fillfactor = 80),
    constraint FK_OtherPathwayActivityData_CaseFile
        foreign key (CASEFILEID) references CaseFile
            on delete cascade
);


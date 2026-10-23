create table AIRVIOLATIONDATA
(
    AIRVIOLATIONDATAID        varchar(40) not null,
    CASEFILEID                varchar(25) not null,
    AIRVIOLATIONTYPECODE      varchar(10) not null,
    AIRVIOLATIONPROGRAMCODE   varchar(10) not null,
    AIRVIOLATIONPROGRAMDESC   varchar(4000),
    AIRVIOLATIONPOLLUTANTCODE varchar(10),
    FRVDETERMINATIONDATE      datetime2(0),
    HPVDAYZERODATE            datetime2(0),
    OCCURRENCESTARTDATE       datetime2(0),
    OCCURRENCEENDDATE         datetime2(0),
    HPVREMOVALTYPECODE        varchar(10),
    HPVREMOVALDATE            datetime2(0),
    CLAIMSNUMBER              float,
    constraint SYS_C00138219
        primary key (AIRVIOLATIONDATAID)
            with (fillfactor = 80),
    constraint FK_AirViolationData_CaseFile
        foreign key (CASEFILEID) references CaseFile
            on delete cascade
);


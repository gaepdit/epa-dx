create table CASEFILECODE
(
    CASEFILECODEID varchar(40) not null,
    CASEFILEID     varchar(25) not null,
    CODENAME       varchar(50) not null,
    CODEVALUE      varchar(20) not null,
    constraint SYS_C00138222
        primary key (CASEFILECODEID)
            with (fillfactor = 80),
    constraint FK_CaseFileCode_CaseFile
        foreign key (CASEFILEID) references CaseFile
            on delete cascade
);


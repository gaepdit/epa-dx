create table AirProgramSubpart
(
    AirProgramSubpartID              int identity,
    AirProgramID                     int not null,
    AirProgramSubpartCode            varchar(20),
    AirProgramSubpartStatusIndicator char,
    constraint PK_AirProgramSubpart
        primary key (AirProgramSubpartID)
            with (fillfactor = 80)
);


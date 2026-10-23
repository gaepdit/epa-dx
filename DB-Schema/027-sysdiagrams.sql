create table sysdiagrams
(
    name         sysname not null,
    principal_id int     not null,
    diagram_id   int identity,
    version      int,
    definition   varbinary(max)
);


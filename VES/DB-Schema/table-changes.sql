USE NETWORKNODEFLOW;
GO

ALTER TABLE dbo.AirFacility ALTER COLUMN FacilitySiteName varchar(80);
ALTER TABLE dbo.AirProgramSubpart ALTER COLUMN AirProgramSubpartCode varchar(20) NULL;
ALTER TABLE dbo.GeographicCoordinate ADD GaAirFacilityID varchar(20);

ALTER TABLE dbo.AirDAFinalOrderAirFacility DROP CONSTRAINT FK_AirDAFinalOrderAirFacility_AirDAFinalOrder;
ALTER TABLE dbo.AirDAFinalOrderAirFacility DROP CONSTRAINT PK_AirDAFinalOrderAirFacility;
ALTER TABLE dbo.AirDAFinalOrder DROP CONSTRAINT PK_AirDAFinalOrder;
GO

ALTER TABLE dbo.AirDAFinalOrderAirFacility ALTER COLUMN AirDAFinalOrderId varchar(40) NOT NULL;
ALTER TABLE dbo.AirDAFinalOrder ALTER COLUMN AirDAFinalOrderId varchar(40) NOT NULL;
GO

ALTER TABLE dbo.AirDAFinalOrder ADD CONSTRAINT PK_AirDAFinalOrder PRIMARY KEY CLUSTERED(AirDAFinalOrderId);
ALTER TABLE dbo.AirDAFinalOrderAirFacility ADD CONSTRAINT PK_AirDAFinalOrderAirFacility PRIMARY KEY CLUSTERED(AirDAFinalOrderId);
ALTER TABLE dbo.AirDAFinalOrderAirFacility WITH CHECK ADD CONSTRAINT FK_AirDAFinalOrderAirFacility_AirDAFinalOrder FOREIGN KEY(AirDAFinalOrderId) REFERENCES AirDAFinalOrder(AirDAFinalOrderId) ON DELETE CASCADE;
GO

ALTER TABLE dbo.AirDAFinalOrder ADD FinalOrderIdentifier int NULL;
GO

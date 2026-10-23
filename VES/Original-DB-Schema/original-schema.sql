USE [NETWORKNODEFLOW]
GO
/****** Object:  Table [dbo].[AirProgramSubpart]    Script Date: 08/25/2014 16:13:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AirProgramSubpart](
	[AirProgramSubpartID] [int] IDENTITY(1,1) NOT NULL,
	[AirProgramID] [int] NOT NULL,
	[AirProgramSubpartCode] [varchar](10) NULL,
	[AirProgramSubpartStatusIndicator] [char](1) NULL,
 CONSTRAINT [PK_AirProgramSubpart] PRIMARY KEY CLUSTERED 
(
	[AirProgramSubpartID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[AirPermit]    Script Date: 08/25/2014 16:13:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AirPermit](
	[ComplianceMonitoringId] [varchar](25) NOT NULL,
	[AirPermitIdentifier] [varchar](100) NULL,
	[CertificationPeriodStartDate] [date] NULL,
	[CertificationPeriodEndDate] [date] NULL,
 CONSTRAINT [PK_AirPermit] PRIMARY KEY CLUSTERED 
(
	[ComplianceMonitoringId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Contact]    Script Date: 08/25/2014 16:13:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Contact](
	[ContactID] [int] IDENTITY(1,1) NOT NULL,
	[AffiliationTypeText] [varchar](10) NULL,
	[FirstName] [varchar](20) NULL,
	[MiddleName] [varchar](20) NULL,
	[LastName] [varchar](20) NULL,
	[IndividualTitleText] [varchar](50) NULL,
	[OrganizationFormalName] [varchar](50) NULL,
	[StateCode] [char](2) NULL,
	[RegionCode] [varchar](10) NULL,
	[ElectronicAddressText] [varchar](50) NULL,
	[StartDateOfContactAssociation] [date] NULL,
	[EndDateOfContactAssociation] [date] NULL,
 CONSTRAINT [PK_[Contact] PRIMARY KEY CLUSTERED 
(
	[ContactID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GeographicCoordinate]    Script Date: 08/25/2014 16:13:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GeographicCoordinate](
	[GeographicCoordinateID] [int] IDENTITY(1,1) NOT NULL,
	[LatitudeMeasure] [varchar](15) NULL,
	[LongitudeMeasure] [varchar](15) NULL,
	[HorizontalAccuracyMeasure] [varchar](10) NULL,
	[GeometricTypeCode] [varchar](10) NULL,
	[HorizontalCollectionMethodCode] [varchar](10) NULL,
	[HorizontalReferenceDatumCode] [varchar](10) NULL,
	[ReferencePointCode] [varchar](10) NULL,
	[SourceMapScaleNumber] [varchar](10) NULL,
	[UTMCoordinate1] [varchar](15) NULL,
	[UTMCoordinate2] [varchar](15) NULL,
	[UTMCoordinate3] [varchar](15) NULL,
 CONSTRAINT [PK_GeographicCoordinate] PRIMARY KEY CLUSTERED 
(
	[GeographicCoordinateID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SubmissionStatus]    Script Date: 08/25/2014 16:13:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SubmissionStatus](
	[TransactionID] [varchar](50) NOT NULL,
	[TableName] [varchar](50) NOT NULL,
	[ID] [varchar](50) NOT NULL,
	[ForeignKey] [varchar](50) NULL,
	[Operation] [varchar](15) NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[Status] [varchar](15) NULL,
	[SubmitDate] [datetime] NULL,
	[StatusDetail] [varchar](1000) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SSOSystemComponent]    Script Date: 08/25/2014 16:13:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SSOSystemComponent](
	[SSOSystemComponentId] [int] IDENTITY(1,1) NOT NULL,
	[SSOInspectionId] [int] NOT NULL,
	[SystemComponent] [varchar](3) NOT NULL,
	[OtherSystemComponent] [varchar](50) NULL,
 CONSTRAINT [PK_SSOSystemComponent] PRIMARY KEY CLUSTERED 
(
	[SSOSystemComponentId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SSOStep]    Script Date: 08/25/2014 16:13:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SSOStep](
	[SSOStepId] [int] IDENTITY(1,1) NOT NULL,
	[SSOInspectionId] [int] NOT NULL,
	[StepsReducePreventMitigate] [varchar](3) NOT NULL,
	[OtherStepsReducePreventMitigate] [varchar](50) NULL,
 CONSTRAINT [PK_SSOStep] PRIMARY KEY CLUSTERED 
(
	[SSOStepId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SIC]    Script Date: 08/25/2014 16:13:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SIC](
	[SICId] [int] IDENTITY(1,1) NOT NULL,
	[SICCode] [varchar](10) NULL,
	[SICPrimaryIndicatorCode] [char](1) NULL,
	[AirFacilityID] [varchar](20) NULL,
	[ComplianceMonitoringId] [varchar](25) NULL,
 CONSTRAINT [PK_SIC] PRIMARY KEY CLUSTERED 
(
	[SICId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DeletedEnforcementAction]    Script Date: 08/25/2014 16:13:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DeletedEnforcementAction](
	[EnforcementActionId] [varchar](25) NOT NULL,
	[ReasonDeletingRecord] [varchar](200) NOT NULL,
	[Type] [varchar](10) NOT NULL,
	[DeletedTimeStamp] [datetime] NOT NULL,
	[TransactionId] [varchar](50) NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[NAICS]    Script Date: 08/25/2014 16:13:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[NAICS](
	[NAICSId] [int] IDENTITY(1,1) NOT NULL,
	[NAICSCode] [varchar](10) NOT NULL,
	[NAICSPrimaryIndicatorCode] [char](1) NULL,
	[AirFacilityID] [varchar](20) NULL,
	[ComplianceMonitoringId] [varchar](25) NULL,
 CONSTRAINT [PK_NAIC] PRIMARY KEY CLUSTERED 
(
	[NAICSId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[InspectionGovernmentContact]    Script Date: 08/25/2014 16:13:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[InspectionGovernmentContact](
	[ComplianceMonitoringId] [varchar](25) NOT NULL,
	[ContactId] [int] NOT NULL,
 CONSTRAINT [PK_InspectionGovernmentContact] PRIMARY KEY CLUSTERED 
(
	[ComplianceMonitoringId] ASC,
	[ContactId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[InspectionConclusionCode]    Script Date: 08/25/2014 16:13:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[InspectionConclusionCode](
	[InspectionConclusionCodeId] [int] IDENTITY(1,1) NOT NULL,
	[InspectionConclusionId] [int] NOT NULL,
	[CodeName] [varchar](100) NOT NULL,
	[CodeValue] [varchar](100) NOT NULL,
 CONSTRAINT [PK_InspectionConclusionCode] PRIMARY KEY CLUSTERED 
(
	[InspectionConclusionCodeId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Transaction]    Script Date: 08/25/2014 16:13:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Transaction](
	[TransactionID] [varchar](50) NOT NULL,
	[TransactionType] [varchar](10) NOT NULL,
	[TransactionTimestamp] [datetime] NULL,
 CONSTRAINT [PK_Transaction] PRIMARY KEY CLUSTERED 
(
	[TransactionID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[UniverseIndicator]    Script Date: 08/25/2014 16:13:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UniverseIndicator](
	[UniverseIndicatorId] [int] IDENTITY(1,1) NOT NULL,
	[UniverseIndicatorCode] [varchar](10) NOT NULL,
	[AirFacilityID] [varchar](20) NULL,
 CONSTRAINT [PK_UniversityIndicator] PRIMARY KEY CLUSTERED 
(
	[UniverseIndicatorId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Telephone]    Script Date: 08/25/2014 16:13:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Telephone](
	[TelephoneID] [int] IDENTITY(1,1) NOT NULL,
	[ContactID] [int] NULL,
	[TelephoneNumberTypeCode] [varchar](10) NULL,
	[TelephoneNumber] [varchar](15) NULL,
	[TelephoneExtensionNumber] [varchar](5) NULL,
 CONSTRAINT [PK_[Telephone] PRIMARY KEY CLUSTERED 
(
	[TelephoneID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DAEA2DAEALink]    Script Date: 08/25/2014 16:13:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DAEA2DAEALink](
	[EnforcementActionId] [varchar](50) NOT NULL,
	[LinkedEAId] [varchar](50) NOT NULL,
	[TransactionId] [varchar](40) NULL,
 CONSTRAINT [PK_DAEA2DAEALink] PRIMARY KEY CLUSTERED 
(
	[EnforcementActionId] ASC,
	[LinkedEAId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DAEA2FederalEALink]    Script Date: 08/25/2014 16:13:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DAEA2FederalEALink](
	[EnforcementActionId] [varchar](50) NOT NULL,
	[LinkedEAId] [varchar](50) NOT NULL,
	[TransactionId] [varchar](40) NULL,
 CONSTRAINT [PK_DAEA2FederalEALink] PRIMARY KEY CLUSTERED 
(
	[EnforcementActionId] ASC,
	[LinkedEAId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[EnforcementAction]    Script Date: 08/25/2014 16:13:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[EnforcementAction](
	[EnforcementActionId] [varchar](25) NOT NULL,
	[EnforcementActionTypeCode] [varchar](20) NULL,
	[EnforcementActionName] [varchar](100) NULL,
	[Forum] [varchar](100) NULL,
	[ResolutionTypeCode] [varchar](5) NULL,
	[AirDACombinedOrSupersededByEAID] [varchar](50) NULL,
	[ReasonDeletingRecord] [varchar](5) NULL,
	[AchievedDate] [date] NULL,
	[FileNumber] [int] NULL,
	[EAUserDefinedField1] [varchar](3) NULL,
	[EAUserDefinedField2] [varchar](50) NULL,
	[EAUserDefinedField3] [varchar](50) NULL,
	[EAUserDefinedField4] [date] NULL,
	[EAUserDefinedField5] [date] NULL,
	[EAUserDefinedField6] [varchar](4000) NULL,
	[LeadAgencyCode] [varchar](10) NULL,
	[EnforcementAgencyName] [varchar](100) NULL,
	[OtherAgencyInitiativeText] [varchar](4000) NULL,
	[StateSectionsViolatedText] [varchar](4000) NULL,
	[SensitiveDataInd] [varchar](3) NULL,
	[Type] [varchar](20) NULL,
	[TransactionID] [varchar](50) NULL,
	[OtherProgramDescriptionText] [varchar](4000) NULL,
 CONSTRAINT [PK_EnforcementAction] PRIMARY KEY CLUSTERED 
(
	[EnforcementActionId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[EnforcementActionMilestone]    Script Date: 08/25/2014 16:13:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[EnforcementActionMilestone](
	[EnforcementActionMilestoneId] [int] IDENTITY(1,1) NOT NULL,
	[EnforcementActionId] [varchar](25) NOT NULL,
	[MilestonePlannedDate] [date] NULL,
	[MilestoneActualDate] [date] NULL,
	[Type] [varchar](20) NOT NULL,
	[TransactionID] [varchar](50) NULL,
 CONSTRAINT [PK_EnforcementActionMilestone] PRIMARY KEY CLUSTERED 
(
	[EnforcementActionMilestoneId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ComplianceMonitoring]    Script Date: 08/25/2014 16:13:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ComplianceMonitoring](
	[ComplianceMonitoringId] [varchar](25) NOT NULL,
	[ProgramSystemAcronym] [varchar](10) NULL,
	[ProgramSystemIdentifier] [varchar](25) NULL,
	[FederalStatuteCode] [varchar](10) NULL,
	[ActivityTypeCode] [varchar](10) NULL,
	[CategoryCode] [varchar](10) NULL,
	[ComplianceMonitoringDate] [date] NULL,
	[StartDate] [date] NULL,
	[EndDate] [date] NULL,
	[TVACCDueDate] [date] NULL,
	[InspectionTypeCode] [varchar](10) NULL,
	[ActivityName] [varchar](100) NULL,
	[ActionReasonCode] [varchar](10) NULL,
	[AgencyTypeCode] [varchar](10) NULL,
	[AgencyCode] [varchar](10) NULL,
	[AirFacilityID] [varchar](20) NULL,
	[ProgramCode] [varchar](10) NULL,
	[OtherProgramDescriptionText] [varchar](250) NULL,
	[AirPollutantCode] [varchar](10) NULL,
	[EPAAssistanceIndicator] [char](1) NULL,
	[StateFederalJointIndicator] [char](1) NULL,
	[JointInspectionReasonCode] [varchar](10) NULL,
	[LeadParty] [varchar](10) NULL,
	[Days] [int] NULL,
	[Hours] [int] NULL,
	[ActionOutcomeCode] [varchar](10) NULL,
	[InspectionRatingCode] [varchar](10) NULL,
	[NationalPrioritiesCode] [varchar](10) NULL,
	[MultimediaIndicator] [varchar](10) NULL,
	[FederalFacilityIndicator] [char](1) NULL,
	[FederalFacilityIndicatorComment] [varchar](500) NULL,
	[OtherAgencyInitiativeText] [varchar](500) NULL,
	[InspectionUserDefinedField1] [varchar](250) NULL,
	[InspectionUserDefinedField2] [varchar](250) NULL,
	[InspectionUserDefinedField3] [varchar](250) NULL,
	[InspectionUserDefinedField4] [varchar](250) NULL,
	[InspectionUserDefinedField5] [varchar](250) NULL,
	[InspectionUserDefinedField6] [varchar](250) NULL,
	[PlannedStartDate] [date] NULL,
	[PlannedEndDate] [date] NULL,
	[EPARegion] [varchar](10) NULL,
	[LawSectionCode] [varchar](10) NULL,
	[MediaTypeCode] [varchar](10) NULL,
	[RegionalPriorityCode] [varchar](10) NULL,
	[LeadAgencyCode] [varchar](10) NULL,
	[InspectionCommentText] [varchar](250) NULL,
	[SensitiveCommentText] [varchar](250) NULL,
	[FacilityReportedComplianceStatusCode] [varchar](10) NULL,
	[DeficienciesObservedIndicator] [varchar](10) NULL,
	[MonitoringType] [varchar](20) NULL,
	[TransactionID] [varchar](50) NULL,
 CONSTRAINT [PK_ComplianceMonitoring] PRIMARY KEY CLUSTERED 
(
	[ComplianceMonitoringId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CM2DAEALink]    Script Date: 08/25/2014 16:13:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CM2DAEALink](
	[ComplianceMonitoringId] [varchar](50) NOT NULL,
	[EnforcementActionId] [varchar](50) NOT NULL,
	[TransactionId] [varchar](40) NULL,
 CONSTRAINT [PK_CM2DAEALink] PRIMARY KEY CLUSTERED 
(
	[ComplianceMonitoringId] ASC,
	[EnforcementActionId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CM2FederalEALink]    Script Date: 08/25/2014 16:13:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CM2FederalEALink](
	[ComplianceMonitoringId] [varchar](50) NOT NULL,
	[EnforcementActionId] [varchar](50) NOT NULL,
	[TransactionId] [varchar](40) NULL,
 CONSTRAINT [PK_CM2FederalEALink] PRIMARY KEY CLUSTERED 
(
	[ComplianceMonitoringId] ASC,
	[EnforcementActionId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[AirFacility]    Script Date: 08/25/2014 16:13:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AirFacility](
	[AirFacilityID] [varchar](20) NOT NULL,
	[FacilitySiteName] [varchar](50) NULL,
	[LocationAddressText] [varchar](250) NULL,
	[SupplementalLocationText] [varchar](250) NULL,
	[GNISCityCode] [varchar](11) NULL,
	[LocationStateCode] [char](2) NULL,
	[LocationZipCode] [varchar](11) NULL,
	[LCONCode] [varchar](10) NULL,
	[TribalLandCode] [varchar](10) NULL,
	[FacilityDescription] [varchar](250) NULL,
	[FacilityTypeOfOwnershipCode] [varchar](10) NULL,
	[RegistrationNumber] [varchar](10) NULL,
	[SmallBusinessIndicator] [char](1) NULL,
	[FederallyReportableIndicator] [char](1) NULL,
	[SourceUniformResourceLocatorURL] [varchar](150) NULL,
	[EnvironmentalJusticeCode] [varchar](50) NULL,
	[FacilityCongressionalDistrictNumber] [varchar](10) NULL,
	[FacilityComments] [varchar](500) NULL,
	[FacilityUserDefinedField1] [varchar](100) NULL,
	[FacilityUserDefinedField2] [varchar](100) NULL,
	[FacilityUserDefinedField3] [varchar](100) NULL,
	[FacilityUserDefinedField4] [varchar](100) NULL,
	[FacilityUserDefinedField5] [varchar](100) NULL,
	[TransactionID] [varchar](50) NULL,
	[LocalityName] [varchar](60) NULL,
	[LocationAddressCountyCode] [varchar](5) NULL,
 CONSTRAINT [PK_AirFacility] PRIMARY KEY CLUSTERED 
(
	[AirFacilityID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[AirComplianceMonitoringStrategy]    Script Date: 08/25/2014 16:13:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AirComplianceMonitoringStrategy](
	[ComplianceMonitoringStrategyID] [int] IDENTITY(1,1) NOT NULL,
	[AirFacilityId] [varchar](20) NOT NULL,
	[AirCMSSourceCategoryCode] [varchar](10) NULL,
	[AirCMSMinimumFrequency] [int] NULL,
	[AirCMSStartDate] [date] NULL,
	[AirActiveCMSPlanIndicator] [char](1) NULL,
	[AirRemovedPlanDate] [date] NULL,
	[Comments] [varchar](500) NULL,
	[TransactionID] [varchar](50) NULL,
 CONSTRAINT [PK_AirComplianceMonitoringStrategy] PRIMARY KEY CLUSTERED 
(
	[ComplianceMonitoringStrategyID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CaseFile]    Script Date: 08/25/2014 16:13:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CaseFile](
	[CaseFileId] [varchar](25) NOT NULL,
	[CaseFileName] [varchar](100) NOT NULL,
	[LeadAgencyCode] [varchar](10) NOT NULL,
	[AirFacilityId] [varchar](25) NOT NULL,
	[OtherProgramDescription] [varchar](4000) NULL,
	[SensitiveDataIndicator] [char](1) NULL,
	[LeadAgencyChangeSuperseded] [varchar](4000) NULL,
	[AdvisementMethodTypeCode] [varchar](10) NULL,
	[AdvisementMethodDate] [date] NULL,
	[CaseFileUserDefinedField1] [varchar](3) NULL,
	[CaseFileUserDefinedField2] [varchar](50) NULL,
	[CaseFileUserDefinedField3] [varchar](50) NULL,
	[CaseFileUserDefinedField4] [date] NULL,
	[CaseFileUserDefinedField5] [date] NULL,
	[CaseFileUserDefinedField6] [varchar](4000) NULL,
	[TransactionID] [varchar](50) NULL,
 CONSTRAINT [PK_CaseFile] PRIMARY KEY CLUSTERED 
(
	[CaseFileId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CaseFile2CaseFileLink]    Script Date: 08/25/2014 16:13:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CaseFile2CaseFileLink](
	[CaseFileId] [varchar](50) NOT NULL,
	[LinkedCaseFileId] [varchar](50) NOT NULL,
	[TransactionId] [varchar](40) NULL,
 CONSTRAINT [PK_CaseFile2CaseFlieLink] PRIMARY KEY CLUSTERED 
(
	[CaseFileId] ASC,
	[LinkedCaseFileId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CaseFile2CMLink]    Script Date: 08/25/2014 16:13:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CaseFile2CMLink](
	[CaseFileId] [varchar](50) NOT NULL,
	[ComplianceMonitoringId] [varchar](50) NOT NULL,
	[TransactionId] [varchar](40) NULL,
 CONSTRAINT [PK_CaseFile2CMLink] PRIMARY KEY CLUSTERED 
(
	[CaseFileId] ASC,
	[ComplianceMonitoringId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CaseFile2DAEALink]    Script Date: 08/25/2014 16:13:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CaseFile2DAEALink](
	[CaseFileId] [varchar](50) NOT NULL,
	[EnforcementActionId] [varchar](50) NOT NULL,
	[TransactionId] [varchar](40) NULL,
 CONSTRAINT [PK_CaseFile2DAEALink] PRIMARY KEY CLUSTERED 
(
	[CaseFileId] ASC,
	[EnforcementActionId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CaseFile2FederalEALink]    Script Date: 08/25/2014 16:13:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CaseFile2FederalEALink](
	[CaseFileId] [varchar](50) NOT NULL,
	[EnforcementActionId] [varchar](50) NOT NULL,
	[TransactionId] [varchar](40) NULL,
 CONSTRAINT [PK_CaseFile2FederalEALink] PRIMARY KEY CLUSTERED 
(
	[CaseFileId] ASC,
	[EnforcementActionId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CM2CMLink]    Script Date: 08/25/2014 16:13:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CM2CMLink](
	[ComplianceMonitoringId] [varchar](50) NOT NULL,
	[LinkedCMId] [varchar](50) NOT NULL,
	[TransactionId] [varchar](40) NULL,
 CONSTRAINT [PK_CM2CMLink] PRIMARY KEY CLUSTERED 
(
	[ComplianceMonitoringId] ASC,
	[LinkedCMId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Citation]    Script Date: 08/25/2014 16:13:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Citation](
	[CitationId] [int] IDENTITY(1,1) NOT NULL,
	[ComplianceMonitoringId] [varchar](25) NOT NULL,
	[CitationTitle] [varchar](40) NOT NULL,
	[CitationPart] [varchar](40) NOT NULL,
	[CitationSection] [varchar](100) NULL,
 CONSTRAINT [PK_Citation] PRIMARY KEY CLUSTERED 
(
	[CitationId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CaseFileComment]    Script Date: 08/25/2014 16:13:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CaseFileComment](
	[CaseFileCommentId] [int] IDENTITY(1,1) NOT NULL,
	[CaseFileId] [varchar](25) NOT NULL,
	[CommentName] [varchar](50) NOT NULL,
	[CommentText] [varchar](4000) NOT NULL,
 CONSTRAINT [PK_CaseFileComment] PRIMARY KEY CLUSTERED 
(
	[CaseFileCommentId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CaseFileCode]    Script Date: 08/25/2014 16:13:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CaseFileCode](
	[CaseFileCodeId] [int] IDENTITY(1,1) NOT NULL,
	[CaseFileId] [varchar](25) NOT NULL,
	[CodeName] [varchar](50) NOT NULL,
	[CodeValue] [varchar](20) NOT NULL,
 CONSTRAINT [PK_CaseFileCode] PRIMARY KEY CLUSTERED 
(
	[CaseFileCodeId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Trigger [CaseFile2FederalEALink_Update_Trigger]    Script Date: 08/25/2014 16:13:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Peter Gu
-- Create date: 2013-12-20
-- Description:	This update trigger will create
-- a record in SubmitStatus table
-- =============================================
Create TRIGGER [dbo].[CaseFile2FederalEALink_Update_Trigger] 
   ON  [dbo].[CaseFile2FederalEALink] 
   AFTER Update
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
    insert
        [dbo].[SubmissionStatus]
        (TransactionID, TableName, ID, ForeignKey, Operation)
    SELECT 
        i.TransactionID,'CaseFile2FederalEALink', i.CaseFileId, i.EnforcementActionId, 'update'
    FROM 
        inserted i


END
GO
/****** Object:  Trigger [CaseFile2FederalEALink_Insert_Trigger]    Script Date: 08/25/2014 16:13:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Peter Gu
-- Create date: 2013-12-20
-- Description:	This update trigger will create
-- a record in SubmitStatus table
-- =============================================
Create TRIGGER [dbo].[CaseFile2FederalEALink_Insert_Trigger] 
   ON  [dbo].[CaseFile2FederalEALink] 
   AFTER Insert
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
    insert
        [dbo].[SubmissionStatus]
        (TransactionID, TableName, ID, ForeignKey, Operation)
    SELECT 
        i.TransactionID,'CaseFile2FederalEALink', i.CaseFileId, i.EnforcementActionId, 'insert'
    FROM 
        inserted i


END
GO
/****** Object:  Trigger [CaseFile2FederalEALink_Delete_Trigger]    Script Date: 08/25/2014 16:13:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Peter Gu
-- Create date: 2013-12-20
-- Description:	This update trigger will create
-- a record in SubmitStatus table
-- =============================================
Create TRIGGER [dbo].[CaseFile2FederalEALink_Delete_Trigger] 
   ON  [dbo].[CaseFile2FederalEALink] 
   AFTER Delete
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
    insert
        [dbo].[SubmissionStatus]
        (TransactionID, TableName, ID, ForeignKey, Operation)
    SELECT 
        i.TransactionID,'CaseFile2FederalEALink', i.CaseFileId, i.EnforcementActionId, 'delete'
    FROM 
        inserted i


END
GO
/****** Object:  Trigger [CaseFile2DAEALink_Update_Trigger]    Script Date: 08/25/2014 16:13:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Peter Gu
-- Create date: 2013-12-20
-- Description:	This update trigger will create
-- a record in SubmitStatus table
-- =============================================
Create TRIGGER [dbo].[CaseFile2DAEALink_Update_Trigger] 
   ON  [dbo].[CaseFile2DAEALink] 
   AFTER Update
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
    insert
        [dbo].[SubmissionStatus]
        (TransactionID, TableName, ID, ForeignKey, Operation)
    SELECT 
        i.TransactionID,'CaseFile2DAEALink', i.CaseFileId, i.EnforcementActionId, 'update'
    FROM 
        inserted i


END
GO
/****** Object:  Trigger [CaseFile2DAEALink_Insert_Trigger]    Script Date: 08/25/2014 16:13:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Peter Gu
-- Create date: 2013-12-20
-- Description:	This update trigger will create
-- a record in SubmitStatus table
-- =============================================
Create TRIGGER [dbo].[CaseFile2DAEALink_Insert_Trigger] 
   ON  [dbo].[CaseFile2DAEALink] 
   AFTER Insert
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
    insert
        [dbo].[SubmissionStatus]
        (TransactionID, TableName, ID, ForeignKey, Operation)
    SELECT 
        i.TransactionID,'CaseFile2DAEALink', i.CaseFileId, i.EnforcementActionId, 'insert'
    FROM 
        inserted i


END
GO
/****** Object:  Trigger [CaseFile2DAEALink_Delete_Trigger]    Script Date: 08/25/2014 16:13:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Peter Gu
-- Create date: 2013-12-20
-- Description:	This update trigger will create
-- a record in SubmitStatus table
-- =============================================
Create TRIGGER [dbo].[CaseFile2DAEALink_Delete_Trigger] 
   ON  [dbo].[CaseFile2DAEALink] 
   AFTER Delete
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
    insert
        [dbo].[SubmissionStatus]
        (TransactionID, TableName, ID, ForeignKey, Operation)
    SELECT 
        i.TransactionID,'CaseFile2DAEALink', i.CaseFileId, i.EnforcementActionId, 'delete'
    FROM 
        inserted i


END
GO
/****** Object:  Trigger [CaseFile2CMLink_Update_Trigger]    Script Date: 08/25/2014 16:13:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Peter Gu
-- Create date: 2013-12-20
-- Description:	This update trigger will create
-- a record in SubmitStatus table
-- =============================================
CREATE TRIGGER [dbo].[CaseFile2CMLink_Update_Trigger] 
   ON  [dbo].[CaseFile2CMLink] 
   AFTER Update
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
    insert
        [dbo].[SubmissionStatus]
        (TransactionID, TableName, ID, ForeignKey, Operation)
    SELECT 
        i.TransactionID,'CaseFile2CMLink', i.CaseFileId, i.ComplianceMonitoringId, 'update'
    FROM 
        inserted i


END
GO
/****** Object:  Trigger [CaseFile2CMLink_Insert_Trigger]    Script Date: 08/25/2014 16:13:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Peter Gu
-- Create date: 2013-12-20
-- Description:	This update trigger will create
-- a record in SubmitStatus table
-- =============================================
CREATE TRIGGER [dbo].[CaseFile2CMLink_Insert_Trigger] 
   ON  [dbo].[CaseFile2CMLink] 
   AFTER Insert
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
    insert
        [dbo].[SubmissionStatus]
        (TransactionID, TableName, ID, ForeignKey, Operation)
    SELECT 
        i.TransactionID,'CaseFile2CMLink', i.CaseFileId, i.ComplianceMonitoringId, 'insert'
    FROM 
        inserted i


END
GO
/****** Object:  Trigger [CaseFile2CMLink_Delete_Trigger]    Script Date: 08/25/2014 16:13:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Peter Gu
-- Create date: 2013-12-20
-- Description:	This update trigger will create
-- a record in SubmitStatus table
-- =============================================
CREATE TRIGGER [dbo].[CaseFile2CMLink_Delete_Trigger] 
   ON  [dbo].[CaseFile2CMLink] 
   AFTER DELETE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
    insert
        [dbo].[SubmissionStatus]
        (TransactionID, TableName, ID, ForeignKey, Operation)
    SELECT 
        i.TransactionID,'CaseFile2CMLink', i.CaseFileId, i.ComplianceMonitoringId, 'delete'
    FROM 
        inserted i


END
GO
/****** Object:  Trigger [CaseFile2CaseFileLink_Update_Trigger]    Script Date: 08/25/2014 16:13:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Peter Gu
-- Create date: 2013-12-20
-- Description:	This update trigger will create
-- a record in SubmitStatus table
-- =============================================
CREATE TRIGGER [dbo].[CaseFile2CaseFileLink_Update_Trigger] 
   ON  [dbo].[CaseFile2CaseFileLink] 
   AFTER UPDATE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
    insert
        [dbo].[SubmissionStatus]
        (TransactionID, TableName, ID, ForeignKey, Operation)
    SELECT 
        i.TransactionID,'CaseFile2CaseFileLink', i.CaseFileId, i.LinkedCaseFileId, 'update'
    FROM 
        inserted i


END
GO
/****** Object:  Trigger [CaseFile2CaseFileLink_Insert_Trigger]    Script Date: 08/25/2014 16:13:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Peter Gu
-- Create date: 2013-12-20
-- Description:	This insert trigger will create
-- a record in SubmitStatus table
-- =============================================
Create TRIGGER [dbo].[CaseFile2CaseFileLink_Insert_Trigger] 
   ON  [dbo].[CaseFile2CaseFileLink] 
   AFTER INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
    insert
        [dbo].[SubmissionStatus]
        (TransactionID, TableName, ID, ForeignKey, Operation)
    SELECT 
        i.TransactionID,'CaseFile2CaseFileLink', i.CaseFileId, i.LinkedCaseFileId, 'insert'
    FROM 
        inserted i


END
GO
/****** Object:  Trigger [CaseFile2CaseFileLink_Delete_Trigger]    Script Date: 08/25/2014 16:13:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Peter Gu
-- Create date: 2013-12-20
-- Description:	This update trigger will create
-- a record in SubmitStatus table
-- =============================================
Create TRIGGER [dbo].[CaseFile2CaseFileLink_Delete_Trigger] 
   ON  [dbo].[CaseFile2CaseFileLink] 
   AFTER DELETE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
    insert
        [dbo].[SubmissionStatus]
        (TransactionID, TableName, ID, ForeignKey, Operation)
    SELECT 
        i.TransactionID,'CaseFile2CaseFileLink', i.CaseFileId, i.LinkedCaseFileId, 'delete'
    FROM 
        inserted i


END
GO
/****** Object:  Trigger [CaseFile_Update_Trigger]    Script Date: 08/25/2014 16:13:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Peter Gu
-- Create date: 2013-12-20
-- Description:	This Update trigger will create
-- a record in SubmitStatus table
-- =============================================
Create TRIGGER [dbo].[CaseFile_Update_Trigger] 
   ON  [dbo].[CaseFile] 
   AFTER UPDATE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
    insert
        [dbo].[SubmissionStatus]
        (TransactionID, TableName, ID, Operation)
    SELECT 
        i.TransactionID,'CaseFile', i.CaseFileId, 'update'
    FROM 
        inserted i


END
GO
/****** Object:  Trigger [CaseFile_Insert_Trigger]    Script Date: 08/25/2014 16:13:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Peter Gu
-- Create date: 2013-12-20
-- Description:	This insert trigger will create
-- a record in SubmitStatus table
-- =============================================
Create TRIGGER [dbo].[CaseFile_Insert_Trigger] 
   ON  [dbo].[CaseFile] 
   AFTER INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
    insert
        [dbo].[SubmissionStatus]
        (TransactionID, TableName, ID, Operation)
    SELECT 
        i.TransactionID,'CaseFile', i.CaseFileId, 'insert'
    FROM 
        inserted i


END
GO
/****** Object:  Trigger [CaseFile_Delete_Trigger]    Script Date: 08/25/2014 16:13:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Peter Gu
-- Create date: 2013-12-20
-- Description:	This Update trigger will create
-- a record in SubmitStatus table
-- =============================================
Create TRIGGER [dbo].[CaseFile_Delete_Trigger] 
   ON  [dbo].[CaseFile] 
   AFTER DELETE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
    insert
        [dbo].[SubmissionStatus]
        (TransactionID, TableName, ID, Operation)
    SELECT 
        i.TransactionID,'CaseFile', i.CaseFileId, 'delete'
    FROM 
        deleted i


END
GO
/****** Object:  Table [dbo].[CAFOInspection]    Script Date: 08/25/2014 16:13:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CAFOInspection](
	[CAFOInspectionId] [int] IDENTITY(1,1) NOT NULL,
	[ComplianceMonitoringId] [varchar](25) NOT NULL,
	[CAFOClassificationCode] [varchar](20) NULL,
	[IsAnimalFacilityTypeCAFOInd] [char](1) NULL,
	[CAFODesignationDate] [date] NULL,
	[CAFODesignationReasonText] [varchar](1000) NULL,
 CONSTRAINT [PK_CAFOInspection] PRIMARY KEY CLUSTERED 
(
	[CAFOInspectionId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[AirViolationData]    Script Date: 08/25/2014 16:13:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AirViolationData](
	[AirViolationDataId] [int] IDENTITY(1,1) NOT NULL,
	[CaseFileId] [varchar](25) NOT NULL,
	[AirViolationTypeCode] [varchar](10) NOT NULL,
	[AirViolationProgramCode] [varchar](10) NOT NULL,
	[AirViolationProgramDescriptionText] [varchar](4000) NULL,
	[AirViolationPollutantCode] [varchar](10) NULL,
	[FRVDeterminationDate] [date] NULL,
	[HPVDayZeroDate] [date] NULL,
	[OccurrenceStartDate] [date] NULL,
	[OccurrenceEndDate] [date] NULL,
	[HPVDesignationRemovalTypeCode] [varchar](10) NULL,
	[HPVDesignationRemovalDate] [date] NULL,
	[ClaimsNumber] [int] NULL,
 CONSTRAINT [PK_AirViolationData] PRIMARY KEY CLUSTERED 
(
	[AirViolationDataId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[AirStackTestData]    Script Date: 08/25/2014 16:13:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AirStackTestData](
	[ComplianceMonitoringId] [varchar](25) NOT NULL,
	[StackTestStatusCode] [varchar](10) NULL,
	[ConductorTypeCode] [varchar](10) NULL,
	[StackIdentifier] [varchar](25) NULL,
	[StackTestPurposeCode] [varchar](10) NULL,
	[OtherStackTestPurposeName] [varchar](50) NULL,
	[ObservedAgencyTypeCode] [varchar](10) NULL,
	[ReportReceivedDate] [date] NULL,
	[ResultsReviewedDate] [date] NULL,
 CONSTRAINT [PK_AirStackTestData] PRIMARY KEY CLUSTERED 
(
	[ComplianceMonitoringId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[AirDAFinalOrder]    Script Date: 08/25/2014 16:13:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AirDAFinalOrder](
	[AirDAFinalOrderId] [varchar](20) NOT NULL,
	[EnforcementActionId] [varchar](25) NOT NULL,
	[FinalOrderTypeCode] [varchar](10) NULL,
	[FinalOrderIssuedEnteredDate] [date] NULL,
	[AirEnforcementActionResolvedDate] [date] NULL,
	[CashCivilPenaltyRequiredAmount] [varchar](10) NULL,
	[OtherComments] [varchar](4000) NULL,
 CONSTRAINT [PK_AirDAFinalOrder] PRIMARY KEY CLUSTERED 
(
	[AirDAFinalOrderId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Trigger [AirComplianceMonitoringStrategy_Update_Trigger]    Script Date: 08/25/2014 16:13:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Peter Gu
-- Create date: 2013-12-20
-- Description:	This update trigger will create
-- a record in SubmissionStatus table
-- =============================================
CREATE TRIGGER [dbo].[AirComplianceMonitoringStrategy_Update_Trigger] 
   ON  [dbo].[AirComplianceMonitoringStrategy] 
   AFTER Update
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
    insert
        [dbo].[SubmissionStatus]
        (TransactionID, TableName, ID,Operation)
    SELECT 
        i.TransactionID,'AirComplianceMonitoringStrategy', i.AirFacilityId, 'update'
    FROM  inserted i
END
GO
/****** Object:  Trigger [AirComplianceMonitoringStrategy_Insert_Trigger]    Script Date: 08/25/2014 16:13:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Peter Gu
-- Create date: 2013-12-20
-- Description:	This insert trigger will create
-- a record in SubmissionStatus table
-- =============================================
CREATE TRIGGER [dbo].[AirComplianceMonitoringStrategy_Insert_Trigger] 
   ON  [dbo].[AirComplianceMonitoringStrategy] 
   AFTER INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
    insert
        [dbo].[SubmissionStatus]
        (TransactionID, TableName,ID, Operation)
    SELECT 
        i.TransactionID,'AirComplianceMonitoringStrategy', i.AirFacilityId,'insert'
    FROM 
        inserted i
END
GO
/****** Object:  Trigger [AirComplianceMonitoringStrategy_Delete_Trigger]    Script Date: 08/25/2014 16:13:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Peter Gu
-- Create date: 2013-12-20
-- Description:	This delete trigger will create
-- a record in SubmissionStatus table
-- =============================================
CREATE TRIGGER [dbo].[AirComplianceMonitoringStrategy_Delete_Trigger] 
   ON  [dbo].[AirComplianceMonitoringStrategy] 
   AFTER DELETE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
    insert
        [dbo].[SubmissionStatus]
        (TransactionID, TableName, ID, Operation)
    SELECT 
        i.TransactionID,'AirComplianceMonitoringStrategy',  i.AirFacilityId,'delete'
    FROM 
        deleted i
END
GO
/****** Object:  Table [dbo].[AirPollutants]    Script Date: 08/25/2014 16:13:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AirPollutants](
	[AirPollutantID] [int] IDENTITY(1,1) NOT NULL,
	[AirFacilityID] [varchar](20) NOT NULL,
	[AirPollutantsCode] [varchar](10) NULL,
	[AirPollutantStatusIndicator] [char](1) NULL,
	[AirPollutantEPAClassificationCode] [varchar](10) NULL,
	[AirPollutantEPAClassificationStartDate] [date] NULL,
	[AirPollutantDAClassificationCode] [varchar](10) NULL,
	[AirPollutantDAClassificationStartDate] [date] NULL,
	[TransactionID] [varchar](50) NULL,
 CONSTRAINT [PK_AirPollutants_1] PRIMARY KEY CLUSTERED 
(
	[AirPollutantID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[AirGeographicCoordinate]    Script Date: 08/25/2014 16:13:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AirGeographicCoordinate](
	[AirFacilityID] [varchar](20) NOT NULL,
	[GeographicCoordinateID] [int] NOT NULL,
 CONSTRAINT [PK_AirGeographicCoordinate] PRIMARY KEY CLUSTERED 
(
	[AirFacilityID] ASC,
	[GeographicCoordinateID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Trigger [AirFacility_Update_Trigger]    Script Date: 08/25/2014 16:13:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Peter Gu
-- Create date: 2013-12-20
-- Description:	This update trigger will create
-- a record in SubmitStatus table
-- =============================================
CREATE TRIGGER [dbo].[AirFacility_Update_Trigger] 
   ON  [dbo].[AirFacility] 
   AFTER UPDATE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
    insert
        [dbo].[SubmissionStatus]
        (TransactionID, TableName, ID, Operation)
    SELECT 
        i.TransactionID,'AirFacility', i.AirFacilityID, 'update'
    FROM 
        inserted i
END
GO
/****** Object:  Trigger [AirFacility_Insert_Trigger]    Script Date: 08/25/2014 16:13:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Peter Gu
-- Create date: 2013-12-20
-- Description:	This insert trigger will create
-- a record in SubmitStatus table
-- =============================================
CREATE TRIGGER [dbo].[AirFacility_Insert_Trigger] 
   ON  [dbo].[AirFacility] 
   AFTER INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
    insert
        [dbo].[SubmissionStatus]
        (TransactionID, TableName, ID, Operation)
    SELECT 
        i.TransactionID,'AirFacility', i.AirFacilityID, 'insert'
    FROM 
        inserted i


END
GO
/****** Object:  Trigger [AirFacility_Delete_Trigger]    Script Date: 08/25/2014 16:13:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Peter Gu
-- Create date: 2013-12-20
-- Description:	This delete trigger will create
-- a record in SubmitStatus table
-- =============================================
CREATE TRIGGER [dbo].[AirFacility_Delete_Trigger] 
   ON  [dbo].[AirFacility] 
   AFTER DELETE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
    insert
        [dbo].[SubmissionStatus]
        (TransactionID, TableName, ID, Operation)
    SELECT 
        i.TransactionID,'AirFacility', i.AirFacilityID, 'delete'
    FROM 
        deleted i
END
GO
/****** Object:  Table [dbo].[AirPrograms]    Script Date: 08/25/2014 16:13:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AirPrograms](
	[AirProgramID] [int] IDENTITY(1,1) NOT NULL,
	[AirFacilityID] [varchar](20) NOT NULL,
	[AirProgramCode] [varchar](10) NULL,
	[OtherAirProgramText] [varchar](50) NULL,
	[AirProgramOperatingStatusCode] [varchar](10) NULL,
	[AirProgramOperatingStatusStartDate] [date] NULL,
	[TransactionID] [varchar](50) NULL,
 CONSTRAINT [PK_AirPrograms_1] PRIMARY KEY CLUSTERED 
(
	[AirProgramID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ComplianceMonitoringContact]    Script Date: 08/25/2014 16:13:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ComplianceMonitoringContact](
	[ComplianceMonitoringId] [varchar](25) NOT NULL,
	[ContactId] [int] NOT NULL,
 CONSTRAINT [PK_ComplianceMonitoringContact] PRIMARY KEY CLUSTERED 
(
	[ComplianceMonitoringId] ASC,
	[ContactId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ComplianceMonitoringComment]    Script Date: 08/25/2014 16:13:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ComplianceMonitoringComment](
	[ComplianceMonitoringCommentId] [int] IDENTITY(1,1) NOT NULL,
	[ComplianceMonitoringId] [varchar](25) NOT NULL,
	[CommentName] [varchar](50) NOT NULL,
	[CommentText] [varchar](4000) NOT NULL,
 CONSTRAINT [PK_ComplianceMonitoringComment] PRIMARY KEY CLUSTERED 
(
	[ComplianceMonitoringCommentId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ComplianceMonitoringCode]    Script Date: 08/25/2014 16:13:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ComplianceMonitoringCode](
	[ComplianceMonitoringCodeId] [int] IDENTITY(1,1) NOT NULL,
	[ComplianceMonitoringId] [varchar](25) NOT NULL,
	[CodeName] [varchar](50) NOT NULL,
	[CodeValue] [varchar](20) NOT NULL,
 CONSTRAINT [PK_ComplianceMonitoringCode] PRIMARY KEY CLUSTERED 
(
	[ComplianceMonitoringCodeId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Trigger [ComplianceMonitoring_Update_Trigger]    Script Date: 08/25/2014 16:13:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Peter Gu
-- Create date: 2013-12-20
-- Description:	This update trigger will create
-- a record in SubmissionStatus table
-- =============================================
CREATE TRIGGER [dbo].[ComplianceMonitoring_Update_Trigger] 
   ON  [dbo].[ComplianceMonitoring] 
   AFTER UPDATE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
    insert
        [dbo].[SubmissionStatus]
        (TransactionID, TableName, ID,Operation)
    SELECT 
        i.TransactionID,'ComplianceMonitoring', i.ComplianceMonitoringId, 'update'
    FROM 
        inserted i
END
GO
/****** Object:  Trigger [ComplianceMonitoring_Insert_Trigger]    Script Date: 08/25/2014 16:13:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Peter Gu
-- Create date: 2013-12-20
-- Description:	This insert trigger will create
-- a record in SubmissionStatus table
-- =============================================
CREATE TRIGGER [dbo].[ComplianceMonitoring_Insert_Trigger] 
   ON  [dbo].[ComplianceMonitoring] 
   AFTER INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
    insert
        [dbo].[SubmissionStatus]
        (TransactionID, TableName, ID,Operation)
    SELECT 
        i.TransactionID,'ComplianceMonitoring', i.ComplianceMonitoringId, 'insert'
    FROM 
        inserted i
END
GO
/****** Object:  Trigger [ComplianceMonitoring_Delete_Trigger]    Script Date: 08/25/2014 16:13:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Peter Gu
-- Create date: 2013-12-20
-- Description:	This insert trigger will create
-- a record in SubmissionStatus table
-- =============================================
CREATE TRIGGER [dbo].[ComplianceMonitoring_Delete_Trigger] 
   ON  [dbo].[ComplianceMonitoring] 
   AFTER DELETE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
    insert
        [dbo].[SubmissionStatus]
        (TransactionID, TableName, ID,ForeignKey, Operation)
    SELECT 
        i.TransactionID,'ComplianceMonitoring', i.ComplianceMonitoringId,i.MonitoringType, 'delete'
    FROM 
        deleted i
END
GO
/****** Object:  Trigger [CM2DAEALink_Update_Trigger]    Script Date: 08/25/2014 16:13:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Peter Gu
-- Create date: 2013-12-20
-- Description:	This update trigger will create
-- a record in SubmitStatus table
-- =============================================
Create TRIGGER [dbo].[CM2DAEALink_Update_Trigger] 
   ON  [dbo].[CM2DAEALink] 
   AFTER Update
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
    insert
        [dbo].[SubmissionStatus]
        (TransactionID, TableName, ID, ForeignKey, Operation)
    SELECT 
        i.TransactionID,'CM2DAEALink', i.ComplianceMonitoringId, i.EnforcementActionId, 'update'
    FROM 
        inserted i


END
GO
/****** Object:  Trigger [CM2DAEALink_Insert_Trigger]    Script Date: 08/25/2014 16:13:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Peter Gu
-- Create date: 2013-12-20
-- Description:	This update trigger will create
-- a record in SubmitStatus table
-- =============================================
Create TRIGGER [dbo].[CM2DAEALink_Insert_Trigger] 
   ON  [dbo].[CM2DAEALink] 
   AFTER Insert
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
    insert
        [dbo].[SubmissionStatus]
        (TransactionID, TableName, ID, ForeignKey, Operation)
    SELECT 
        i.TransactionID,'CM2DAEALink', i.ComplianceMonitoringId, i.EnforcementActionId, 'insert'
    FROM 
        inserted i


END
GO
/****** Object:  Trigger [CM2DAEALink_Delete_Trigger]    Script Date: 08/25/2014 16:13:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Peter Gu
-- Create date: 2013-12-20
-- Description:	This update trigger will create
-- a record in SubmitStatus table
-- =============================================
Create TRIGGER [dbo].[CM2DAEALink_Delete_Trigger] 
   ON  [dbo].[CM2DAEALink] 
   AFTER Delete
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
    insert
        [dbo].[SubmissionStatus]
        (TransactionID, TableName, ID, ForeignKey, Operation)
    SELECT 
        i.TransactionID,'CM2DAEALink', i.ComplianceMonitoringId, i.EnforcementActionId, 'delete'
    FROM 
        inserted i


END
GO
/****** Object:  Trigger [CM2CMLink_Update_Trigger]    Script Date: 08/25/2014 16:13:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Peter Gu
-- Create date: 2013-12-20
-- Description:	This update trigger will create
-- a record in SubmitStatus table
-- =============================================
Create TRIGGER [dbo].[CM2CMLink_Update_Trigger] 
   ON  [dbo].[CM2CMLink] 
   AFTER Update
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
    insert
        [dbo].[SubmissionStatus]
        (TransactionID, TableName, ID, ForeignKey, Operation)
    SELECT 
        i.TransactionID,'CM2CMLink', i.ComplianceMonitoringId, i.LinkedCMId, 'update'
    FROM 
        inserted i


END
GO
/****** Object:  Trigger [CM2CMLink_Insert_Trigger]    Script Date: 08/25/2014 16:13:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Peter Gu
-- Create date: 2013-12-20
-- Description:	This update trigger will create
-- a record in SubmitStatus table
-- =============================================
Create TRIGGER [dbo].[CM2CMLink_Insert_Trigger] 
   ON  [dbo].[CM2CMLink] 
   AFTER Insert
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
    insert
        [dbo].[SubmissionStatus]
        (TransactionID, TableName, ID, ForeignKey, Operation)
    SELECT 
        i.TransactionID,'CM2CMLink', i.ComplianceMonitoringId, i.LinkedCMId, 'insert'
    FROM 
        inserted i


END
GO
/****** Object:  Trigger [CM2CMLink_Delete_Trigger]    Script Date: 08/25/2014 16:13:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Peter Gu
-- Create date: 2013-12-20
-- Description:	This update trigger will create
-- a record in SubmitStatus table
-- =============================================
Create TRIGGER [dbo].[CM2CMLink_Delete_Trigger] 
   ON  [dbo].[CM2CMLink] 
   AFTER Delete
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
    insert
        [dbo].[SubmissionStatus]
        (TransactionID, TableName, ID, ForeignKey, Operation)
    SELECT 
        i.TransactionID,'CM2CMLink', i.ComplianceMonitoringId, i.LinkedCMId, 'delete'
    FROM 
        inserted i


END
GO
/****** Object:  Trigger [CM2FederalEALink_Update_Trigger]    Script Date: 08/25/2014 16:13:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Peter Gu
-- Create date: 2013-12-20
-- Description:	This update trigger will create
-- a record in SubmitStatus table
-- =============================================
Create TRIGGER [dbo].[CM2FederalEALink_Update_Trigger] 
   ON  [dbo].[CM2FederalEALink] 
   AFTER Update
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
    insert
        [dbo].[SubmissionStatus]
        (TransactionID, TableName, ID, ForeignKey, Operation)
    SELECT 
        i.TransactionID,'CM2FederalEALink', i.ComplianceMonitoringId, i.EnforcementActionId, 'update'
    FROM 
        inserted i


END
GO
/****** Object:  Trigger [CM2FederalEALink_Insert_Trigger]    Script Date: 08/25/2014 16:13:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Peter Gu
-- Create date: 2013-12-20
-- Description:	This update trigger will create
-- a record in SubmitStatus table
-- =============================================
Create TRIGGER [dbo].[CM2FederalEALink_Insert_Trigger] 
   ON  [dbo].[CM2FederalEALink] 
   AFTER Insert
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
    insert
        [dbo].[SubmissionStatus]
        (TransactionID, TableName, ID, ForeignKey, Operation)
    SELECT 
        i.TransactionID,'CM2FederalEALink', i.ComplianceMonitoringId, i.EnforcementActionId, 'insert'
    FROM 
        inserted i


END
GO
/****** Object:  Trigger [CM2FederalEALink_Delete_Trigger]    Script Date: 08/25/2014 16:13:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Peter Gu
-- Create date: 2013-12-20
-- Description:	This update trigger will create
-- a record in SubmitStatus table
-- =============================================
Create TRIGGER [dbo].[CM2FederalEALink_Delete_Trigger] 
   ON  [dbo].[CM2FederalEALink] 
   AFTER Delete
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
    insert
        [dbo].[SubmissionStatus]
        (TransactionID, TableName, ID, ForeignKey, Operation)
    SELECT 
        i.TransactionID,'CM2FederalEALink', i.ComplianceMonitoringId, i.EnforcementActionId, 'delete'
    FROM 
        inserted i


END
GO
/****** Object:  Table [dbo].[FacilityContact]    Script Date: 08/25/2014 16:13:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[FacilityContact](
	[AirFacilityId] [varchar](20) NOT NULL,
	[ContactId] [int] NOT NULL,
 CONSTRAINT [PK_FacilityContact] PRIMARY KEY CLUSTERED 
(
	[AirFacilityId] ASC,
	[ContactId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[FacilityAddress]    Script Date: 08/25/2014 16:13:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[FacilityAddress](
	[FacilityAddressID] [int] IDENTITY(1,1) NOT NULL,
	[AirFacilityID] [varchar](20) NOT NULL,
	[AffiliationTypeText] [varchar](10) NULL,
	[OrganizationFormalName] [varchar](50) NULL,
	[OrganizationDUNSNumber] [varchar](10) NULL,
	[MailingAddressText] [varchar](100) NULL,
	[SupplementalAddressText] [varchar](100) NULL,
	[MailingAddressCityName] [varchar](50) NULL,
	[MailingAddressStateCode] [char](2) NULL,
	[MailingAddressZipCode] [varchar](10) NULL,
	[CountyName] [varchar](50) NULL,
	[MailingAddressCountryCode] [varchar](20) NULL,
	[DivisionName] [varchar](20) NULL,
	[TelephoneNumberTypeCode] [varchar](10) NULL,
	[TelephoneNumber] [varchar](15) NULL,
	[TelephoneExtensionNumber] [varchar](5) NULL,
	[ElectronicAddressText] [varchar](50) NULL,
	[StartDateOfAddressAssociation] [date] NULL,
	[EndDateOfAddressAssociation] [date] NULL,
	[LocationProvince] [varchar](20) NULL,
 CONSTRAINT [PK_FacilityAddress] PRIMARY KEY CLUSTERED 
(
	[FacilityAddressID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Trigger [EnforcementActiony_Update_Trigger]    Script Date: 08/25/2014 16:13:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Peter Gu
-- Create date: 2013-12-20
-- Description:	This update trigger will create
-- a record in SubmitStatus table
-- =============================================
CREATE TRIGGER [dbo].[EnforcementActiony_Update_Trigger] 
   ON  [dbo].[EnforcementAction] 
   AFTER UPDATE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
    insert
        [dbo].[SubmissionStatus]
        (TransactionID, TableName, ID, Operation)
    SELECT 
        i.TransactionID,'EnforcementAction', i.EnforcementActionId, 'update'
    FROM 
        inserted i
END
GO
/****** Object:  Trigger [EnforcementActionMilestone_Update_Trigger]    Script Date: 08/25/2014 16:13:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Peter Gu
-- Create date: 2013-12-20
-- Description:	This update trigger will create
-- a record in SubmitStatus table
-- =============================================
CREATE TRIGGER [dbo].[EnforcementActionMilestone_Update_Trigger] 
   ON  [dbo].[EnforcementActionMilestone] 
   AFTER UPDATE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
    insert
        [dbo].[SubmissionStatus]
        (TransactionID, TableName, ID, Operation)
    SELECT 
        i.TransactionID,'EnforcementActionMilestone', i.EnforcementActionId + i.Type, 'update'
    FROM 
        inserted i
END
GO
/****** Object:  Trigger [EnforcementActionMilestone_Insert_Trigger]    Script Date: 08/25/2014 16:13:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Peter Gu
-- Create date: 2013-12-20
-- Description:	This insert trigger will create
-- a record in SubmitStatus table
-- =============================================
CREATE TRIGGER [dbo].[EnforcementActionMilestone_Insert_Trigger] 
   ON  [dbo].[EnforcementActionMilestone] 
   AFTER INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
    insert
        [dbo].[SubmissionStatus]
        (TransactionID, TableName, ID, Operation)
    SELECT 
        i.TransactionID,'EnforcementActionMilestone', i.EnforcementActionId + i.Type, 'insert'
    FROM 
        inserted i


END
GO
/****** Object:  Trigger [EnforcementActionMileStone_Delete_Trigger]    Script Date: 08/25/2014 16:13:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Peter Gu
-- Create date: 2013-12-20
-- Description:	This delete trigger will create
-- a record in SubmitStatus table
-- =============================================
CREATE TRIGGER [dbo].[EnforcementActionMileStone_Delete_Trigger] 
   ON  [dbo].[EnforcementActionMilestone] 
   AFTER DELETE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
    insert
        [dbo].[SubmissionStatus]
        (TransactionID, TableName, ID, Operation)
    SELECT 
        i.TransactionID,'EnforcementActionMileStone', i.EnforcementActionId + i.Type, 'delete'
    FROM 
        deleted i
END
GO
/****** Object:  Table [dbo].[EnforcementActionCode]    Script Date: 08/25/2014 16:13:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[EnforcementActionCode](
	[EnforcementActionCodeId] [int] IDENTITY(1,1) NOT NULL,
	[EnforcementActionId] [varchar](25) NOT NULL,
	[CodeName] [varchar](50) NOT NULL,
	[CodeValue] [varchar](20) NOT NULL,
 CONSTRAINT [PK_EnforcementActionCode] PRIMARY KEY CLUSTERED 
(
	[EnforcementActionCodeId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[EnforcementActionAirFacility]    Script Date: 08/25/2014 16:13:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[EnforcementActionAirFacility](
	[EnforcementActionId] [varchar](25) NOT NULL,
	[AirFacilityId] [varchar](20) NOT NULL,
 CONSTRAINT [PK_EnforcementActionAirFacility] PRIMARY KEY CLUSTERED 
(
	[EnforcementActionId] ASC,
	[AirFacilityId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Trigger [EnforcementAction_Insert_Trigger]    Script Date: 08/25/2014 16:13:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Peter Gu
-- Create date: 2013-12-20
-- Description:	This insert trigger will create
-- a record in SubmitStatus table
-- =============================================
Create TRIGGER [dbo].[EnforcementAction_Insert_Trigger] 
   ON  [dbo].[EnforcementAction] 
   AFTER INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
    insert
        [dbo].[SubmissionStatus]
        (TransactionID, TableName, ID, Operation)
    SELECT 
        i.TransactionID,'EnforcementAction', i.EnforcementActionId, 'insert'
    FROM 
        inserted i


END
GO
/****** Object:  Trigger [EnforcementAction_Delete_Trigger]    Script Date: 08/25/2014 16:13:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Peter Gu
-- Create date: 2013-12-20
-- Description:	This delete trigger will create
-- a record in SubmitStatus table
-- =============================================
CREATE TRIGGER [dbo].[EnforcementAction_Delete_Trigger] 
   ON  [dbo].[EnforcementAction] 
   AFTER DELETE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
    insert
        [dbo].[SubmissionStatus]
        (TransactionID, TableName, ID, Operation)
    SELECT 
        i.TransactionID,'EnforcementAction', i.EnforcementActionId, 'delete'
    FROM 
        deleted i

	-- insert to deleted record
	INSERT [dbo].[DeletedEnforcementAction]
           ([EnforcementActionId],[ReasonDeletingRecord],[Type],[DeletedTimeStamp],[TransactionId])
    SELECT
           i.EnforcementActionId,'Data Entry Error',i.Type,GETDATE(),i.TransactionID
	FROM 
        deleted i

END
GO
/****** Object:  Table [dbo].[EAGovernmentContact]    Script Date: 08/25/2014 16:13:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[EAGovernmentContact](
	[EnforcementActionId] [varchar](25) NOT NULL,
	[ContactId] [int] NOT NULL,
 CONSTRAINT [PK_EnforcementActionGovernmentContact] PRIMARY KEY CLUSTERED 
(
	[EnforcementActionId] ASC,
	[ContactId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[EAComment]    Script Date: 08/25/2014 16:13:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[EAComment](
	[EAInspectionCommentId] [int] IDENTITY(1,1) NOT NULL,
	[EnforcementActionId] [varchar](25) NOT NULL,
	[CommentName] [varchar](50) NOT NULL,
	[CommentText] [varchar](4000) NOT NULL,
 CONSTRAINT [PK_EAInspectionComment] PRIMARY KEY CLUSTERED 
(
	[EAInspectionCommentId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Trigger [DAEA2DAEALink_Update_Trigger]    Script Date: 08/25/2014 16:13:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Peter Gu
-- Create date: 2013-12-20
-- Description:	This update trigger will create
-- a record in SubmitStatus table
-- =============================================
Create TRIGGER [dbo].[DAEA2DAEALink_Update_Trigger] 
   ON  [dbo].[DAEA2DAEALink] 
   AFTER Update
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
    insert
        [dbo].[SubmissionStatus]
        (TransactionID, TableName, ID, ForeignKey, Operation)
    SELECT 
        i.TransactionID,'DAEA2DAEALink', i.EnforcementActionId, i.LinkedEAId, 'update'
    FROM 
        inserted i


END
GO
/****** Object:  Trigger [DAEA2DAEALink_Inserte_Trigger]    Script Date: 08/25/2014 16:13:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Peter Gu
-- Create date: 2013-12-20
-- Description:	This update trigger will create
-- a record in SubmitStatus table
-- =============================================
Create TRIGGER [dbo].[DAEA2DAEALink_Inserte_Trigger] 
   ON  [dbo].[DAEA2DAEALink] 
   AFTER Insert
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
    insert
        [dbo].[SubmissionStatus]
        (TransactionID, TableName, ID, ForeignKey, Operation)
    SELECT 
        i.TransactionID,'DAEA2DAEALink', i.EnforcementActionId, i.LinkedEAId, 'insert'
    FROM 
        inserted i


END
GO
/****** Object:  Trigger [DAEA2DAEALink_Delete_Trigger]    Script Date: 08/25/2014 16:13:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Peter Gu
-- Create date: 2013-12-20
-- Description:	This update trigger will create
-- a record in SubmitStatus table
-- =============================================
Create TRIGGER [dbo].[DAEA2DAEALink_Delete_Trigger] 
   ON  [dbo].[DAEA2DAEALink] 
   AFTER Delete
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
    insert
        [dbo].[SubmissionStatus]
        (TransactionID, TableName, ID, ForeignKey, Operation)
    SELECT 
        i.TransactionID,'DAEA2DAEALink', i.EnforcementActionId, i.LinkedEAId, 'delete'
    FROM 
        inserted i


END
GO
/****** Object:  Table [dbo].[CSOInspection]    Script Date: 08/25/2014 16:13:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CSOInspection](
	[CSOInspectionId] [int] IDENTITY(1,1) NOT NULL,
	[ComplianceMonitoringId] [varchar](25) NOT NULL,
	[DryOrWetWeatherInd] [varchar](5) NULL,
	[PermittedFeatureId] [varchar](25) NULL,
	[CSOOverflowLocationStreet] [varchar](4000) NULL,
	[DurationCSOOverflowEvent] [varchar](10) NULL,
	[DischargeVolumeTreated] [int] NULL,
	[DischargeVolumeUntreated] [int] NULL,
	[CorrectiveActionTakenDescriptionText] [varchar](4000) NULL,
	[InchesPrecipitation] [varchar](6) NULL,
 CONSTRAINT [PK_CSOInspection] PRIMARY KEY CLUSTERED 
(
	[CSOInspectionId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Subactivity]    Script Date: 08/25/2014 16:13:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Subactivity](
	[SubactivityId] [int] IDENTITY(1,1) NOT NULL,
	[ComplianceMonitoringId] [varchar](25) NOT NULL,
	[SubactivityTypeCode] [varchar](10) NOT NULL,
	[SubactivityPlannedDate] [date] NULL,
	[SubactivityDate] [date] NULL,
 CONSTRAINT [PK_Subactivity] PRIMARY KEY CLUSTERED 
(
	[SubactivityId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[StormWaterMS4Inspection]    Script Date: 08/25/2014 16:13:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[StormWaterMS4Inspection](
	[StormWaterMS4InspectionId] [int] IDENTITY(1,1) NOT NULL,
	[ComplianceMonitoringId] [varchar](25) NOT NULL,
	[LegalEntityTypeCode] [varchar](5) NULL,
	[MS4PermitClassCode] [varchar](5) NULL,
	[MS4TypeCode] [varchar](5) NULL,
	[MS4AcreageCoveredNumber] [int] NULL,
	[MS4PopulationServedNumber] [int] NULL,
	[UrbanizedAreaIncorporatedPlaceName] [varchar](50) NULL,
 CONSTRAINT [PK_StormWaterMS4Inspection] PRIMARY KEY CLUSTERED 
(
	[StormWaterMS4InspectionId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[StormWaterConstructionInspection]    Script Date: 08/25/2014 16:13:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[StormWaterConstructionInspection](
	[StormWaterConstructionInspectionId] [int] IDENTITY(1,1) NOT NULL,
	[ComplianceMonitoringId] [varchar](25) NOT NULL,
	[ProjectTypeCode] [varchar](20) NULL,
	[ProjectTypeCodeOtherDescription] [varchar](1000) NULL,
	[EstimatedStartDate] [date] NULL,
	[EstimatedCompleteDate] [date] NULL,
	[EstimatedAreaDisturbedAcresNumber] [int] NULL,
	[ProjectPlanSizeCode] [varchar](5) NULL,
 CONSTRAINT [PK_StormWaterConstructionInspection] PRIMARY KEY CLUSTERED 
(
	[StormWaterConstructionInspectionId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TVACCReviewData]    Script Date: 08/25/2014 16:13:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TVACCReviewData](
	[TVACCReviewDataId] [int] IDENTITY(1,1) NOT NULL,
	[TVACCReviewedDate] [date] NOT NULL,
	[FacilityReportDeviationsIndicator] [char](1) NULL,
	[PermitConditionsText] [varchar](250) NULL,
	[ExceedanceExcursionIndicator] [char](1) NULL,
	[ReviewerAgencyCode] [varchar](10) NULL,
	[TVACCReviewerName] [varchar](100) NULL,
	[ReviewerComment] [varchar](500) NULL,
	[ComplianceMonitoringId] [varchar](25) NULL,
 CONSTRAINT [PK_TVACCReviewData] PRIMARY KEY CLUSTERED 
(
	[TVACCReviewDataId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TestResultsData]    Script Date: 08/25/2014 16:13:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TestResultsData](
	[TestResultsDataId] [int] IDENTITY(1,1) NOT NULL,
	[AirTestedPollutantCode] [varchar](10) NOT NULL,
	[TestResultCode] [varchar](10) NULL,
	[MethodCode] [varchar](10) NULL,
	[AllowableValue] [varchar](10) NULL,
	[AllowableUnitCode] [varchar](10) NULL,
	[ActualResult] [varchar](10) NULL,
	[FailureReasonCode] [varchar](10) NULL,
	[OtherFailureReasonText] [varchar](500) NULL,
	[ComplianceMonitoringId] [varchar](25) NULL,
 CONSTRAINT [PK_TestResultsData] PRIMARY KEY CLUSTERED 
(
	[TestResultsDataId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[InspectionConclusion]    Script Date: 08/25/2014 16:13:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[InspectionConclusion](
	[InspectionConclusionId] [int] IDENTITY(1,1) NOT NULL,
	[ComplianceMonitoringId] [varchar](25) NOT NULL,
	[DeficienciesObservedInd] [char](1) NULL,
	[DeficiencyCommunicatedFacilityInd] [char](1) NULL,
	[FacilityActionObservedInd] [char](1) NULL,
	[NationalPolicyGeneralAssistanceInd] [char](1) NULL,
	[NationalPolicySiteSpecificAssistanceInd] [char](1) NULL,
 CONSTRAINT [PK_InspectionConclusion] PRIMARY KEY CLUSTERED 
(
	[InspectionConclusionId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Trigger [DAEA2FederalEALink_Update_Trigger]    Script Date: 08/25/2014 16:13:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Peter Gu
-- Create date: 2013-12-20
-- Description:	This update trigger will create
-- a record in SubmitStatus table
-- =============================================
Create TRIGGER [dbo].[DAEA2FederalEALink_Update_Trigger] 
   ON  [dbo].[DAEA2FederalEALink] 
   AFTER Update
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
    insert
        [dbo].[SubmissionStatus]
        (TransactionID, TableName, ID, ForeignKey, Operation)
    SELECT 
        i.TransactionID,'DAEA2FederalEALink', i.EnforcementActionId, i.LinkedEAId, 'updete'
    FROM 
        inserted i


END
GO
/****** Object:  Trigger [DAEA2FederalEALink_Inserte_Trigger]    Script Date: 08/25/2014 16:13:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Peter Gu
-- Create date: 2013-12-20
-- Description:	This update trigger will create
-- a record in SubmitStatus table
-- =============================================
Create TRIGGER [dbo].[DAEA2FederalEALink_Inserte_Trigger] 
   ON  [dbo].[DAEA2FederalEALink] 
   AFTER Insert
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
    insert
        [dbo].[SubmissionStatus]
        (TransactionID, TableName, ID, ForeignKey, Operation)
    SELECT 
        i.TransactionID,'DAEA2FederalEALink', i.EnforcementActionId, i.LinkedEAId, 'insert'
    FROM 
        inserted i


END
GO
/****** Object:  Trigger [DAEA2FederalEALink_Delete_Trigger]    Script Date: 08/25/2014 16:13:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Peter Gu
-- Create date: 2013-12-20
-- Description:	This update trigger will create
-- a record in SubmitStatus table
-- =============================================
Create TRIGGER [dbo].[DAEA2FederalEALink_Delete_Trigger] 
   ON  [dbo].[DAEA2FederalEALink] 
   AFTER Delete
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
    insert
        [dbo].[SubmissionStatus]
        (TransactionID, TableName, ID, ForeignKey, Operation)
    SELECT 
        i.TransactionID,'DAEA2FederalEALink', i.EnforcementActionId, i.LinkedEAId, 'delete'
    FROM 
        inserted i


END
GO
/****** Object:  Table [dbo].[Pretreatment]    Script Date: 08/25/2014 16:13:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Pretreatment](
	[PretreatmentId] [int] IDENTITY(1,1) NOT NULL,
	[ComplianceMonitoringId] [varchar](25) NOT NULL,
	[SUOReference] [varchar](15) NULL,
	[SUODate] [date] NULL,
	[AcceptanceHazardousWaste] [varchar](3) NULL,
	[AcceptanceNonHazardousIndustrialWaste] [varchar](3) NULL,
	[AcceptanceHauledDomesticWastes] [varchar](3) NULL,
	[AnnualPretreatmentBudget] [varchar](10) NULL,
	[InadequacySamplingInspectionInd] [varchar](3) NULL,
	[AdequacyPretreatmentResources] [varchar](3) NULL,
	[DeficienciesIdentifiedDuringIUFileReview] [varchar](3) NULL,
	[ControlMechanismDeficiencies] [varchar](3) NULL,
	[LegalAuthorityDeficiencies] [varchar](3) NULL,
	[DeficienciesInterpretationApplicationPretreatmentStandards] [varchar](3) NULL,
	[DeficienciesDataManagementPublicParticipation] [varchar](3) NULL,
	[ViolationIUScheduleRemedialMeasures] [varchar](3) NULL,
	[FormalResponseViolationIUScheduleRemedialMeasures] [varchar](3) NULL,
	[AnnualFrequencyInfluentToxicantSampling] [int] NULL,
	[AnnualFrequencyEffluentToxicantSampling] [int] NULL,
	[AnnualFrequencySludgeToxicantSampling] [int] NULL,
	[NumberSIUs] [int] NULL,
	[SIUsWithoutControlMechanism] [int] NULL,
	[SIUsNotInspected] [int] NULL,
	[SIUsNotSampled] [int] NULL,
	[SIUsOnSchedule] [int] NULL,
	[SIUsSNCWithPretreatmentStandards] [int] NULL,
	[SIUsSNCWithReportingRequirements] [int] NULL,
	[SIUsSNCWithPretreatmentSchedule] [int] NULL,
	[SIUsSNCPublishedNewspaper] [int] NULL,
	[ViolationNoticesIssuedSIUs] [int] NULL,
	[AdministrativeOrdersIssuedSIUs] [int] NULL,
	[CivilSuitsFiledAgainstSIUs] [int] NULL,
	[CriminalSuitsFiledAgainstSIUs] [int] NULL,
	[DollarAmountPenaltiesCollected] [int] NULL,
	[IUsWhichPenaltiesHaveBeenCollected] [varchar](10) NULL,
	[NumberCIUs] [int] NULL,
	[CIUsInSNC] [int] NULL,
	[PassThroughInterferenceIndicator] [varchar](3) NULL,
 CONSTRAINT [PK_Pretreatment] PRIMARY KEY CLUSTERED 
(
	[PretreatmentId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PortableSource]    Script Date: 08/25/2014 16:13:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PortableSource](
	[PortableSourceID] [int] IDENTITY(1,1) NOT NULL,
	[AirFacilityID] [varchar](20) NOT NULL,
	[PortableSourceIndicator] [char](1) NULL,
	[PortableSourceSiteName] [varchar](50) NULL,
	[PortableSourceStartDate] [date] NULL,
	[PortableSourceEndDate] [date] NULL,
 CONSTRAINT [PK_AirFacility_Portable1] PRIMARY KEY CLUSTERED 
(
	[PortableSourceID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[OtherPathwayActivityData]    Script Date: 08/25/2014 16:13:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[OtherPathwayActivityData](
	[OtherPathwayActivityDataId] [int] IDENTITY(1,1) NOT NULL,
	[CaseFileId] [varchar](25) NOT NULL,
	[OtherPathwayCategoryCode] [varchar](10) NULL,
	[OtherPathwayTypeCode] [varchar](10) NULL,
	[OtherPathwayDate] [date] NULL,
 CONSTRAINT [PK_OtherPathwayActivityData] PRIMARY KEY CLUSTERED 
(
	[OtherPathwayActivityDataId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SSOInspection]    Script Date: 08/25/2014 16:13:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SSOInspection](
	[SSOInspectionId] [int] IDENTITY(1,1) NOT NULL,
	[ComplianceMonitoringId] [varchar](25) NOT NULL,
	[CauseSSOOverflowEvent] [varchar](1100) NULL,
	[SSOOverflowLocationStreet] [varchar](4000) NULL,
	[DurationSSOOverflowEvent] [varchar](8) NULL,
	[SSOVolume] [int] NULL,
	[NameReceivingWater] [varchar](1000) NULL,
	[ImpactSSOEvent] [varchar](3) NULL,
	[DescriptionStepsTaken] [varchar](4000) NULL,
 CONSTRAINT [PK_SSOInspection] PRIMARY KEY CLUSTERED 
(
	[SSOInspectionId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SSOInspectionGeographicCoordinate]    Script Date: 08/25/2014 16:13:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SSOInspectionGeographicCoordinate](
	[SSOInspectionId] [int] NOT NULL,
	[GeographicCoordinateID] [int] NOT NULL,
 CONSTRAINT [PK_SSOInspectionGeographicCoordinate] PRIMARY KEY CLUSTERED 
(
	[SSOInspectionId] ASC,
	[GeographicCoordinateID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CSOInspectioGeographicCoordinate]    Script Date: 08/25/2014 16:13:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CSOInspectioGeographicCoordinate](
	[CSOInspectionId] [int] NOT NULL,
	[GeographicCoordinateID] [int] NOT NULL,
 CONSTRAINT [PK_CSOInspectioGeographicCoordinate] PRIMARY KEY CLUSTERED 
(
	[CSOInspectionId] ASC,
	[GeographicCoordinateID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Trigger [AirPrograms_Update_Trigger]    Script Date: 08/25/2014 16:13:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Peter Gu
-- Create date: 2013-12-20
-- Description:	This update trigger will create
-- a record in SubmitStatus table
-- =============================================
CREATE TRIGGER [dbo].[AirPrograms_Update_Trigger] 
   ON  [dbo].[AirPrograms] 
   AFTER UPDATE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
    insert
        [dbo].[SubmissionStatus]
        (TransactionID, TableName, ID,ForeignKey, Operation)
    SELECT 
        i.TransactionID,'AirPrograms', i.AirProgramCode, i.AirFacilityID, 'update'
    FROM 
        inserted i
END
GO
/****** Object:  Trigger [AirPrograms_Insert_Trigger]    Script Date: 08/25/2014 16:13:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Peter Gu
-- Create date: 2013-12-20
-- Description:	This insert trigger will create
-- a record in SubmitStatus table
-- =============================================
CREATE TRIGGER [dbo].[AirPrograms_Insert_Trigger] 
   ON  [dbo].[AirPrograms] 
   AFTER INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
    insert
        [dbo].[SubmissionStatus]
        (TransactionID, TableName, ID,ForeignKey, Operation)
    SELECT 
        i.TransactionID,'AirPrograms', i.AirProgramCode, i.AirFacilityID, 'insert'
    FROM 
        inserted i
END
GO
/****** Object:  Trigger [AirPrograms_Delete_Trigger]    Script Date: 08/25/2014 16:13:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Peter Gu
-- Create date: 2013-12-20
-- Description:	This delete trigger will create
-- a record in SubmitStatus table
-- =============================================
CREATE TRIGGER [dbo].[AirPrograms_Delete_Trigger] 
   ON  [dbo].[AirPrograms] 
   AFTER DELETE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
    insert
        [dbo].[SubmissionStatus]
        (TransactionID, TableName, ID, ForeignKey, Operation)
    SELECT 
        i.TransactionID,'AirPrograms', i.AirProgramCode, i.AirFacilityID, 'delete'
    FROM 
        deleted i
END
GO
/****** Object:  Trigger [AirPollutants_Update_Trigger]    Script Date: 08/25/2014 16:13:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Peter Gu
-- Create date: 2013-12-20
-- Description:	This update trigger will create
-- a record in SubmissionStatus table
-- =============================================
CREATE TRIGGER [dbo].[AirPollutants_Update_Trigger] 
   ON  [dbo].[AirPollutants] 
   AFTER UPDATE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
    insert
        [dbo].[SubmissionStatus]
        (TransactionID, TableName, ID, ForeignKey, Operation)
    SELECT 
        i.TransactionID,'AirPollutants', i.AirPollutantsCode, i.AirFacilityID, 'update'
    FROM 
        inserted i
END
GO
/****** Object:  Trigger [AirPollutants_Insert_Trigger]    Script Date: 08/25/2014 16:13:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Peter Gu
-- Create date: 2013-12-20
-- Description:	This insert trigger will create
-- a record in SubmissionStatus table
-- =============================================
CREATE TRIGGER [dbo].[AirPollutants_Insert_Trigger] 
   ON  [dbo].[AirPollutants] 
   AFTER INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
    insert
        [dbo].[SubmissionStatus]
        (TransactionID, TableName, ID, ForeignKey, Operation)
    SELECT 
        i.TransactionID,'AirPollutants', i.AirPollutantsCode, i.AirFacilityID, 'insert'
    FROM 
        inserted i
END
GO
/****** Object:  Trigger [AirPollutants_Delete_Trigger]    Script Date: 08/25/2014 16:13:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Peter Gu
-- Create date: 2013-12-20
-- Description:	This delete trigger will create
-- a record in SubmissionStatus table
-- =============================================
CREATE TRIGGER [dbo].[AirPollutants_Delete_Trigger] 
   ON  [dbo].[AirPollutants] 
   AFTER DELETE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
    insert
        [dbo].[SubmissionStatus]
        (TransactionID, TableName, ID,ForeignKey, Operation)
    SELECT 
        i.TransactionID,'AirPollutants', i.AirPollutantsCode, i.AirFacilityID, 'delete'
    FROM 
        deleted i
END
GO
/****** Object:  Table [dbo].[AirDAFinalOrderAirFacility]    Script Date: 08/25/2014 16:13:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AirDAFinalOrderAirFacility](
	[AirDAFinalOrderId] [varchar](20) NOT NULL,
	[AirFacilityId] [varchar](20) NOT NULL,
 CONSTRAINT [PK_AirDAFinalOrderAirFacility] PRIMARY KEY CLUSTERED 
(
	[AirDAFinalOrderId] ASC,
	[AirFacilityId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Default [DF_Table_1_TimeStamp]    Script Date: 08/25/2014 16:13:24 ******/
ALTER TABLE [dbo].[SubmissionStatus] ADD  CONSTRAINT [DF_Table_1_TimeStamp]  DEFAULT (getdate()) FOR [CreateDate]
GO
/****** Object:  Default [DF_Transaction_TransactionID]    Script Date: 08/25/2014 16:13:24 ******/
ALTER TABLE [dbo].[Transaction] ADD  CONSTRAINT [DF_Transaction_TransactionID]  DEFAULT (CONVERT([varchar](50),newid(),(0))) FOR [TransactionID]
GO
/****** Object:  ForeignKey [FK_AirDAFinalOrder_EnforcementAction]    Script Date: 08/25/2014 16:13:24 ******/
ALTER TABLE [dbo].[AirDAFinalOrder]  WITH CHECK ADD  CONSTRAINT [FK_AirDAFinalOrder_EnforcementAction] FOREIGN KEY([EnforcementActionId])
REFERENCES [dbo].[EnforcementAction] ([EnforcementActionId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AirDAFinalOrder] CHECK CONSTRAINT [FK_AirDAFinalOrder_EnforcementAction]
GO
/****** Object:  ForeignKey [FK_AirDAFinalOrderAirFacility_AirDAFinalOrder]    Script Date: 08/25/2014 16:13:24 ******/
ALTER TABLE [dbo].[AirDAFinalOrderAirFacility]  WITH CHECK ADD  CONSTRAINT [FK_AirDAFinalOrderAirFacility_AirDAFinalOrder] FOREIGN KEY([AirDAFinalOrderId])
REFERENCES [dbo].[AirDAFinalOrder] ([AirDAFinalOrderId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AirDAFinalOrderAirFacility] CHECK CONSTRAINT [FK_AirDAFinalOrderAirFacility_AirDAFinalOrder]
GO
/****** Object:  ForeignKey [FK_AirGeographicCoordinate_AirFacility]    Script Date: 08/25/2014 16:13:24 ******/
ALTER TABLE [dbo].[AirGeographicCoordinate]  WITH CHECK ADD  CONSTRAINT [FK_AirGeographicCoordinate_AirFacility] FOREIGN KEY([AirFacilityID])
REFERENCES [dbo].[AirFacility] ([AirFacilityID])
GO
ALTER TABLE [dbo].[AirGeographicCoordinate] CHECK CONSTRAINT [FK_AirGeographicCoordinate_AirFacility]
GO
/****** Object:  ForeignKey [FK_AirGeographicCoordinate_GeographicCoordinate]    Script Date: 08/25/2014 16:13:24 ******/
ALTER TABLE [dbo].[AirGeographicCoordinate]  WITH CHECK ADD  CONSTRAINT [FK_AirGeographicCoordinate_GeographicCoordinate] FOREIGN KEY([GeographicCoordinateID])
REFERENCES [dbo].[GeographicCoordinate] ([GeographicCoordinateID])
GO
ALTER TABLE [dbo].[AirGeographicCoordinate] CHECK CONSTRAINT [FK_AirGeographicCoordinate_GeographicCoordinate]
GO
/****** Object:  ForeignKey [FK_AirPollutants_AirFacility]    Script Date: 08/25/2014 16:13:24 ******/
ALTER TABLE [dbo].[AirPollutants]  WITH CHECK ADD  CONSTRAINT [FK_AirPollutants_AirFacility] FOREIGN KEY([AirFacilityID])
REFERENCES [dbo].[AirFacility] ([AirFacilityID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AirPollutants] CHECK CONSTRAINT [FK_AirPollutants_AirFacility]
GO
/****** Object:  ForeignKey [FK_AirPrograms_AirFacility]    Script Date: 08/25/2014 16:13:24 ******/
ALTER TABLE [dbo].[AirPrograms]  WITH CHECK ADD  CONSTRAINT [FK_AirPrograms_AirFacility] FOREIGN KEY([AirFacilityID])
REFERENCES [dbo].[AirFacility] ([AirFacilityID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AirPrograms] CHECK CONSTRAINT [FK_AirPrograms_AirFacility]
GO
/****** Object:  ForeignKey [FK_AirStackTestData_ComplianceMonitoring]    Script Date: 08/25/2014 16:13:24 ******/
ALTER TABLE [dbo].[AirStackTestData]  WITH CHECK ADD  CONSTRAINT [FK_AirStackTestData_ComplianceMonitoring] FOREIGN KEY([ComplianceMonitoringId])
REFERENCES [dbo].[ComplianceMonitoring] ([ComplianceMonitoringId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AirStackTestData] CHECK CONSTRAINT [FK_AirStackTestData_ComplianceMonitoring]
GO
/****** Object:  ForeignKey [FK_AirViolationData_CaseFile]    Script Date: 08/25/2014 16:13:24 ******/
ALTER TABLE [dbo].[AirViolationData]  WITH CHECK ADD  CONSTRAINT [FK_AirViolationData_CaseFile] FOREIGN KEY([CaseFileId])
REFERENCES [dbo].[CaseFile] ([CaseFileId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AirViolationData] CHECK CONSTRAINT [FK_AirViolationData_CaseFile]
GO
/****** Object:  ForeignKey [FK_CAFOInspection_ComplianceMonitoring]    Script Date: 08/25/2014 16:13:24 ******/
ALTER TABLE [dbo].[CAFOInspection]  WITH CHECK ADD  CONSTRAINT [FK_CAFOInspection_ComplianceMonitoring] FOREIGN KEY([ComplianceMonitoringId])
REFERENCES [dbo].[ComplianceMonitoring] ([ComplianceMonitoringId])
GO
ALTER TABLE [dbo].[CAFOInspection] CHECK CONSTRAINT [FK_CAFOInspection_ComplianceMonitoring]
GO
/****** Object:  ForeignKey [FK_CaseFileCode_CaseFile]    Script Date: 08/25/2014 16:13:24 ******/
ALTER TABLE [dbo].[CaseFileCode]  WITH CHECK ADD  CONSTRAINT [FK_CaseFileCode_CaseFile] FOREIGN KEY([CaseFileId])
REFERENCES [dbo].[CaseFile] ([CaseFileId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CaseFileCode] CHECK CONSTRAINT [FK_CaseFileCode_CaseFile]
GO
/****** Object:  ForeignKey [FK_CaseFileComment_CaseFile]    Script Date: 08/25/2014 16:13:24 ******/
ALTER TABLE [dbo].[CaseFileComment]  WITH CHECK ADD  CONSTRAINT [FK_CaseFileComment_CaseFile] FOREIGN KEY([CaseFileId])
REFERENCES [dbo].[CaseFile] ([CaseFileId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CaseFileComment] CHECK CONSTRAINT [FK_CaseFileComment_CaseFile]
GO
/****** Object:  ForeignKey [FK_Citation_ComplianceMonitoring]    Script Date: 08/25/2014 16:13:24 ******/
ALTER TABLE [dbo].[Citation]  WITH CHECK ADD  CONSTRAINT [FK_Citation_ComplianceMonitoring] FOREIGN KEY([ComplianceMonitoringId])
REFERENCES [dbo].[ComplianceMonitoring] ([ComplianceMonitoringId])
GO
ALTER TABLE [dbo].[Citation] CHECK CONSTRAINT [FK_Citation_ComplianceMonitoring]
GO
/****** Object:  ForeignKey [FK_ComplianceMonitoringCode_ComplianceMonitoring]    Script Date: 08/25/2014 16:13:24 ******/
ALTER TABLE [dbo].[ComplianceMonitoringCode]  WITH CHECK ADD  CONSTRAINT [FK_ComplianceMonitoringCode_ComplianceMonitoring] FOREIGN KEY([ComplianceMonitoringId])
REFERENCES [dbo].[ComplianceMonitoring] ([ComplianceMonitoringId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ComplianceMonitoringCode] CHECK CONSTRAINT [FK_ComplianceMonitoringCode_ComplianceMonitoring]
GO
/****** Object:  ForeignKey [FK_ComplianceMonitoringComment_ComplianceMonitoring]    Script Date: 08/25/2014 16:13:24 ******/
ALTER TABLE [dbo].[ComplianceMonitoringComment]  WITH CHECK ADD  CONSTRAINT [FK_ComplianceMonitoringComment_ComplianceMonitoring] FOREIGN KEY([ComplianceMonitoringId])
REFERENCES [dbo].[ComplianceMonitoring] ([ComplianceMonitoringId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ComplianceMonitoringComment] CHECK CONSTRAINT [FK_ComplianceMonitoringComment_ComplianceMonitoring]
GO
/****** Object:  ForeignKey [FK_ComplianceMonitoringContact_ComplianceMonitoring]    Script Date: 08/25/2014 16:13:24 ******/
ALTER TABLE [dbo].[ComplianceMonitoringContact]  WITH CHECK ADD  CONSTRAINT [FK_ComplianceMonitoringContact_ComplianceMonitoring] FOREIGN KEY([ComplianceMonitoringId])
REFERENCES [dbo].[ComplianceMonitoring] ([ComplianceMonitoringId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ComplianceMonitoringContact] CHECK CONSTRAINT [FK_ComplianceMonitoringContact_ComplianceMonitoring]
GO
/****** Object:  ForeignKey [FK_ComplianceMonitoringContact_Contact]    Script Date: 08/25/2014 16:13:24 ******/
ALTER TABLE [dbo].[ComplianceMonitoringContact]  WITH CHECK ADD  CONSTRAINT [FK_ComplianceMonitoringContact_Contact] FOREIGN KEY([ContactId])
REFERENCES [dbo].[Contact] ([ContactID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ComplianceMonitoringContact] CHECK CONSTRAINT [FK_ComplianceMonitoringContact_Contact]
GO
/****** Object:  ForeignKey [FK_CSOInspectioGeographicCoordinate_CSOInspection]    Script Date: 08/25/2014 16:13:24 ******/
ALTER TABLE [dbo].[CSOInspectioGeographicCoordinate]  WITH CHECK ADD  CONSTRAINT [FK_CSOInspectioGeographicCoordinate_CSOInspection] FOREIGN KEY([CSOInspectionId])
REFERENCES [dbo].[CSOInspection] ([CSOInspectionId])
GO
ALTER TABLE [dbo].[CSOInspectioGeographicCoordinate] CHECK CONSTRAINT [FK_CSOInspectioGeographicCoordinate_CSOInspection]
GO
/****** Object:  ForeignKey [FK_CSOInspectioGeographicCoordinate_GeographicCoordinate]    Script Date: 08/25/2014 16:13:24 ******/
ALTER TABLE [dbo].[CSOInspectioGeographicCoordinate]  WITH CHECK ADD  CONSTRAINT [FK_CSOInspectioGeographicCoordinate_GeographicCoordinate] FOREIGN KEY([GeographicCoordinateID])
REFERENCES [dbo].[GeographicCoordinate] ([GeographicCoordinateID])
GO
ALTER TABLE [dbo].[CSOInspectioGeographicCoordinate] CHECK CONSTRAINT [FK_CSOInspectioGeographicCoordinate_GeographicCoordinate]
GO
/****** Object:  ForeignKey [FK_CSOInspection_ComplianceMonitoring]    Script Date: 08/25/2014 16:13:24 ******/
ALTER TABLE [dbo].[CSOInspection]  WITH CHECK ADD  CONSTRAINT [FK_CSOInspection_ComplianceMonitoring] FOREIGN KEY([ComplianceMonitoringId])
REFERENCES [dbo].[ComplianceMonitoring] ([ComplianceMonitoringId])
GO
ALTER TABLE [dbo].[CSOInspection] CHECK CONSTRAINT [FK_CSOInspection_ComplianceMonitoring]
GO
/****** Object:  ForeignKey [FK_EAComment_EnforcementAction]    Script Date: 08/25/2014 16:13:24 ******/
ALTER TABLE [dbo].[EAComment]  WITH CHECK ADD  CONSTRAINT [FK_EAComment_EnforcementAction] FOREIGN KEY([EnforcementActionId])
REFERENCES [dbo].[EnforcementAction] ([EnforcementActionId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[EAComment] CHECK CONSTRAINT [FK_EAComment_EnforcementAction]
GO
/****** Object:  ForeignKey [FK_EAGovernmentContact_EnforcementAction]    Script Date: 08/25/2014 16:13:24 ******/
ALTER TABLE [dbo].[EAGovernmentContact]  WITH CHECK ADD  CONSTRAINT [FK_EAGovernmentContact_EnforcementAction] FOREIGN KEY([EnforcementActionId])
REFERENCES [dbo].[EnforcementAction] ([EnforcementActionId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[EAGovernmentContact] CHECK CONSTRAINT [FK_EAGovernmentContact_EnforcementAction]
GO
/****** Object:  ForeignKey [FK_EnforcementActionAirFacility_EnforcementAction]    Script Date: 08/25/2014 16:13:24 ******/
ALTER TABLE [dbo].[EnforcementActionAirFacility]  WITH CHECK ADD  CONSTRAINT [FK_EnforcementActionAirFacility_EnforcementAction] FOREIGN KEY([EnforcementActionId])
REFERENCES [dbo].[EnforcementAction] ([EnforcementActionId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[EnforcementActionAirFacility] CHECK CONSTRAINT [FK_EnforcementActionAirFacility_EnforcementAction]
GO
/****** Object:  ForeignKey [FK_EnforcementActionCode_EnforcementAction]    Script Date: 08/25/2014 16:13:24 ******/
ALTER TABLE [dbo].[EnforcementActionCode]  WITH CHECK ADD  CONSTRAINT [FK_EnforcementActionCode_EnforcementAction] FOREIGN KEY([EnforcementActionId])
REFERENCES [dbo].[EnforcementAction] ([EnforcementActionId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[EnforcementActionCode] CHECK CONSTRAINT [FK_EnforcementActionCode_EnforcementAction]
GO
/****** Object:  ForeignKey [FK_FacilityAddress_AirFacility]    Script Date: 08/25/2014 16:13:24 ******/
ALTER TABLE [dbo].[FacilityAddress]  WITH CHECK ADD  CONSTRAINT [FK_FacilityAddress_AirFacility] FOREIGN KEY([AirFacilityID])
REFERENCES [dbo].[AirFacility] ([AirFacilityID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[FacilityAddress] CHECK CONSTRAINT [FK_FacilityAddress_AirFacility]
GO
/****** Object:  ForeignKey [FK_FacilityContact_AirFacility]    Script Date: 08/25/2014 16:13:24 ******/
ALTER TABLE [dbo].[FacilityContact]  WITH CHECK ADD  CONSTRAINT [FK_FacilityContact_AirFacility] FOREIGN KEY([AirFacilityId])
REFERENCES [dbo].[AirFacility] ([AirFacilityID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[FacilityContact] CHECK CONSTRAINT [FK_FacilityContact_AirFacility]
GO
/****** Object:  ForeignKey [FK_FacilityContact_Contact]    Script Date: 08/25/2014 16:13:24 ******/
ALTER TABLE [dbo].[FacilityContact]  WITH CHECK ADD  CONSTRAINT [FK_FacilityContact_Contact] FOREIGN KEY([ContactId])
REFERENCES [dbo].[Contact] ([ContactID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[FacilityContact] CHECK CONSTRAINT [FK_FacilityContact_Contact]
GO
/****** Object:  ForeignKey [FK_InspectionConclusion_ComplianceMonitoring]    Script Date: 08/25/2014 16:13:24 ******/
ALTER TABLE [dbo].[InspectionConclusion]  WITH CHECK ADD  CONSTRAINT [FK_InspectionConclusion_ComplianceMonitoring] FOREIGN KEY([ComplianceMonitoringId])
REFERENCES [dbo].[ComplianceMonitoring] ([ComplianceMonitoringId])
GO
ALTER TABLE [dbo].[InspectionConclusion] CHECK CONSTRAINT [FK_InspectionConclusion_ComplianceMonitoring]
GO
/****** Object:  ForeignKey [FK_OtherPathwayActivityData_CaseFile]    Script Date: 08/25/2014 16:13:24 ******/
ALTER TABLE [dbo].[OtherPathwayActivityData]  WITH CHECK ADD  CONSTRAINT [FK_OtherPathwayActivityData_CaseFile] FOREIGN KEY([CaseFileId])
REFERENCES [dbo].[CaseFile] ([CaseFileId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[OtherPathwayActivityData] CHECK CONSTRAINT [FK_OtherPathwayActivityData_CaseFile]
GO
/****** Object:  ForeignKey [FK_PortableSource_AirFacility1]    Script Date: 08/25/2014 16:13:24 ******/
ALTER TABLE [dbo].[PortableSource]  WITH CHECK ADD  CONSTRAINT [FK_PortableSource_AirFacility1] FOREIGN KEY([AirFacilityID])
REFERENCES [dbo].[AirFacility] ([AirFacilityID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PortableSource] CHECK CONSTRAINT [FK_PortableSource_AirFacility1]
GO
/****** Object:  ForeignKey [FK_Pretreatment_ComplianceMonitoring]    Script Date: 08/25/2014 16:13:24 ******/
ALTER TABLE [dbo].[Pretreatment]  WITH CHECK ADD  CONSTRAINT [FK_Pretreatment_ComplianceMonitoring] FOREIGN KEY([ComplianceMonitoringId])
REFERENCES [dbo].[ComplianceMonitoring] ([ComplianceMonitoringId])
GO
ALTER TABLE [dbo].[Pretreatment] CHECK CONSTRAINT [FK_Pretreatment_ComplianceMonitoring]
GO
/****** Object:  ForeignKey [FK_SSOInspection_ComplianceMonitoring]    Script Date: 08/25/2014 16:13:24 ******/
ALTER TABLE [dbo].[SSOInspection]  WITH CHECK ADD  CONSTRAINT [FK_SSOInspection_ComplianceMonitoring] FOREIGN KEY([ComplianceMonitoringId])
REFERENCES [dbo].[ComplianceMonitoring] ([ComplianceMonitoringId])
GO
ALTER TABLE [dbo].[SSOInspection] CHECK CONSTRAINT [FK_SSOInspection_ComplianceMonitoring]
GO
/****** Object:  ForeignKey [FK_SSOInspectionGeographicCoordinate_GeographicCoordinate]    Script Date: 08/25/2014 16:13:24 ******/
ALTER TABLE [dbo].[SSOInspectionGeographicCoordinate]  WITH CHECK ADD  CONSTRAINT [FK_SSOInspectionGeographicCoordinate_GeographicCoordinate] FOREIGN KEY([GeographicCoordinateID])
REFERENCES [dbo].[GeographicCoordinate] ([GeographicCoordinateID])
GO
ALTER TABLE [dbo].[SSOInspectionGeographicCoordinate] CHECK CONSTRAINT [FK_SSOInspectionGeographicCoordinate_GeographicCoordinate]
GO
/****** Object:  ForeignKey [FK_SSOInspectionGeographicCoordinate_SSOInspection]    Script Date: 08/25/2014 16:13:24 ******/
ALTER TABLE [dbo].[SSOInspectionGeographicCoordinate]  WITH CHECK ADD  CONSTRAINT [FK_SSOInspectionGeographicCoordinate_SSOInspection] FOREIGN KEY([SSOInspectionId])
REFERENCES [dbo].[SSOInspection] ([SSOInspectionId])
GO
ALTER TABLE [dbo].[SSOInspectionGeographicCoordinate] CHECK CONSTRAINT [FK_SSOInspectionGeographicCoordinate_SSOInspection]
GO
/****** Object:  ForeignKey [FK_StormWaterConstructionInspection_ComplianceMonitoring]    Script Date: 08/25/2014 16:13:24 ******/
ALTER TABLE [dbo].[StormWaterConstructionInspection]  WITH CHECK ADD  CONSTRAINT [FK_StormWaterConstructionInspection_ComplianceMonitoring] FOREIGN KEY([ComplianceMonitoringId])
REFERENCES [dbo].[ComplianceMonitoring] ([ComplianceMonitoringId])
GO
ALTER TABLE [dbo].[StormWaterConstructionInspection] CHECK CONSTRAINT [FK_StormWaterConstructionInspection_ComplianceMonitoring]
GO
/****** Object:  ForeignKey [FK_StormWaterMS4Inspection_ComplianceMonitoring]    Script Date: 08/25/2014 16:13:24 ******/
ALTER TABLE [dbo].[StormWaterMS4Inspection]  WITH CHECK ADD  CONSTRAINT [FK_StormWaterMS4Inspection_ComplianceMonitoring] FOREIGN KEY([ComplianceMonitoringId])
REFERENCES [dbo].[ComplianceMonitoring] ([ComplianceMonitoringId])
GO
ALTER TABLE [dbo].[StormWaterMS4Inspection] CHECK CONSTRAINT [FK_StormWaterMS4Inspection_ComplianceMonitoring]
GO
/****** Object:  ForeignKey [FK_Subactivity_ComplianceMonitoring]    Script Date: 08/25/2014 16:13:24 ******/
ALTER TABLE [dbo].[Subactivity]  WITH CHECK ADD  CONSTRAINT [FK_Subactivity_ComplianceMonitoring] FOREIGN KEY([ComplianceMonitoringId])
REFERENCES [dbo].[ComplianceMonitoring] ([ComplianceMonitoringId])
GO
ALTER TABLE [dbo].[Subactivity] CHECK CONSTRAINT [FK_Subactivity_ComplianceMonitoring]
GO
/****** Object:  ForeignKey [FK_Telephone_Contact]    Script Date: 08/25/2014 16:13:24 ******/
ALTER TABLE [dbo].[Telephone]  WITH CHECK ADD  CONSTRAINT [FK_Telephone_Contact] FOREIGN KEY([ContactID])
REFERENCES [dbo].[Contact] ([ContactID])
GO
ALTER TABLE [dbo].[Telephone] CHECK CONSTRAINT [FK_Telephone_Contact]
GO
/****** Object:  ForeignKey [FK_TestResultsData_ComplianceMonitoring]    Script Date: 08/25/2014 16:13:24 ******/
ALTER TABLE [dbo].[TestResultsData]  WITH CHECK ADD  CONSTRAINT [FK_TestResultsData_ComplianceMonitoring] FOREIGN KEY([ComplianceMonitoringId])
REFERENCES [dbo].[ComplianceMonitoring] ([ComplianceMonitoringId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[TestResultsData] CHECK CONSTRAINT [FK_TestResultsData_ComplianceMonitoring]
GO
/****** Object:  ForeignKey [FK_TVACCReviewData_ComplianceMonitoring]    Script Date: 08/25/2014 16:13:24 ******/
ALTER TABLE [dbo].[TVACCReviewData]  WITH CHECK ADD  CONSTRAINT [FK_TVACCReviewData_ComplianceMonitoring] FOREIGN KEY([ComplianceMonitoringId])
REFERENCES [dbo].[ComplianceMonitoring] ([ComplianceMonitoringId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[TVACCReviewData] CHECK CONSTRAINT [FK_TVACCReviewData_ComplianceMonitoring]
GO

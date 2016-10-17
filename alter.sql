--ALTER TABLE [BDL].[AdvancedPricing]
--ALTER COLUMN [CountryId] [tinyint] NULL

--ALTER TABLE [BDL].[AdvancedPricing]
--ALTER COLUMN [ParameterId] [smallint] NULL

--ALTER TABLE [BDL].[ConversionData]
--ALTER COLUMN [CountryId] [tinyint] NULL

--ALTER TABLE [BDL].[ConversionData]
--ALTER COLUMN [ParameterId] [smallint] NULL

--ALTER TABLE [BDL].[EPI_Data]
--ALTER COLUMN [CountryId] [tinyint] NULL

--ALTER TABLE [BDL].[EPI_Data]
--ALTER COLUMN [ParameterId] [smallint] NULL

--ALTER TABLE [BDL].[Event]
--ALTER COLUMN [CountryId] [tinyint] NULL

--ALTER TABLE [BDL].[Event]
--ALTER COLUMN [ParameterId] [smallint] NULL

--ALTER TABLE [BDL].[HistoricalData]
--ALTER COLUMN [CountryId] [tinyint] NULL

--ALTER TABLE [BDL].[HistoricalData]
--ALTER COLUMN [ParameterId] [smallint] NULL


--ALTER TABLE [BDL].[OutputData] 
--ALTER COLUMN [CountryId] [tinyint] NULL

--ALTER TABLE [BDL].[OutputData] 
--ALTER COLUMN [ParameterId] [smallint] NULL

--ALTER TABLE [BDL].[ParameterSelectionType]
--ALTER COLUMN [CountryId] [tinyint] NULL

--ALTER TABLE [BDL].[ParameterSelectionType]
--ALTER COLUMN [ParameterId] [smallint] NULL

--ALTER TABLE [BDL].[SegmentDetails]
--ALTER COLUMN [SegmentLevelMasterId] [int] NULL

--ALTER TABLE [BDL].[SegmentVersion]
--ALTER COLUMN [SegmentMasterId] [int] NULL

--ALTER TABLE [BDL].[Share]
--ALTER COLUMN [CountryId] [tinyint] NULL

--ALTER TABLE [BDL].[Share]
--ALTER COLUMN [ParameterId] [smallint] NULL


--ALTER TABLE [BDL].[Source]
--ALTER COLUMN [CountryId] [tinyint] NULL

--ALTER TABLE [BDL].[Source]
--ALTER COLUMN [ParameterId] [smallint] NULL





ALTER TABLE [dbo].[UserMaster]
ALTER COLUMN [GlobalId] [int] NOT NULL

ALTER TABLE [dbo].[UserMaster]
ALTER COLUMN [SP_Account] [varchar](max) NULL

ALTER TABLE [dbo].[UserMaster]
ALTER COLUMN [IsActive] [bit] NULL

ALTER TABLE [dbo].[UserMaster]
ALTER COLUMN [RoleId] [int] NULL

ALTER TABLE [Generic].[AssumptionMaster]
ALTER COLUMN [ProjectID] [int] NOT NULL

ALTER TABLE [Generic].[AssumptionMaster]
ALTER COLUMN [PRODUCT] [int] NOT NULL

ALTER TABLE [Generic].[AssumptionMaster]
ALTER COLUMN [VERSION] [varchar](max) NOT NULL

ALTER TABLE [Generic].[AssumptionMaster]
ALTER COLUMN [SECTION] [int] NOT NULL


ALTER TABLE [Generic].[CompetitorMaster]
ALTER COLUMN [Name] [nvarchar](500) NOT NULL

ALTER TABLE [Generic].[Events]
ALTER COLUMN [EventOrder] [tinyint] NOT NULL



ALTER TABLE [Generic].[ForecastData]
ALTER COLUMN [ForecastValue] [decimal](20, 8) NULL







ALTER TABLE [Generic].[HistoricalData]
ALTER COLUMN [CompetitorID] [int] NOT NULL








ALTER TABLE [Generic].[PackInfo]
ALTER COLUMN [PackID] [int] NOT NULL



ALTER TABLE [Generic].[ParameterMaster]
ALTER COLUMN [Name] [varchar](50) NOT NULL


ALTER TABLE [Generic].[PenetrationTypeData]
ALTER COLUMN [LaunchPriceSelection] [int] NULL

ALTER TABLE [Generic].[PenetrationTypeData]
ALTER COLUMN 	[PriceBasedOn] [int] NULL

ALTER TABLE [Generic].[PenetrationTypeData]
	ALTER COLUMN [StartMonth1] [int] NULL

ALTER TABLE [Generic].[PenetrationTypeData]
	ALTER COLUMN [StartMonth2] [int] NULL

ALTER TABLE [Generic].[PenetrationTypeData]
	ALTER COLUMN [TrendType] [int] NULL

ALTER TABLE [Generic].[PenetrationTypeData]
	ALTER COLUMN [SelectedTrend] [int] NULL





ALTER TABLE [Generic].[PenetrationTypeData]
ALTER COLUMN [SKU_ID] [int] NOT NULL

ALTER TABLE [Generic].[PenetrationTypeData]
ALTER COLUMN [ScenarioId] [int] NOT NULL



ALTER TABLE [Generic].[PenetrationTypeDataVersions]
ALTER COLUMN [ID][int] NOT NULL
go
--sp_rename '[Generic].[PenetrationTypeDataVersions].[ID]','[ProjectVersionID]','COLUMN'


ALTER TABLE [Generic].[PenetrationTypeDataVersions]
ALTER COLUMN [Version][int] NOT NULL
GO
--sp_rename '[Generic].[PenetrationTypeDataVersions].[Version]','[ProjectVersionID]','COLUMN'



ALTER TABLE [Generic].[PenetrationTypeStaging1]
ALTER COLUMN [PenetrationType] [smallint] NULL

ALTER TABLE [Generic].[ProductDetailStaging]
ADD [ProductOrderInExcel] [int] NULL


ALTER TABLE  [Generic].[PenetrationTypeStaging2]
ALTER COLUMN [LaunchPriceSelection] [int]  NULL
	
	ALTER TABLE  [Generic].[PenetrationTypeStaging2]
	ALTER COLUMN [PriceBasedOn] [int]  NULL

	ALTER TABLE  [Generic].[PenetrationTypeStaging2]
	ALTER COLUMN [StartMonth2] [int]  NULL

	ALTER TABLE  [Generic].[PenetrationTypeStaging2]
	ALTER COLUMN [StartMonth1] [int]  NULL

ALTER TABLE  [Generic].[PenetrationTypeStaging2]	
ALTER COLUMN [TrendType] [int]  NULL

	ALTER TABLE  [Generic].[PenetrationTypeStaging2]
	ALTER COLUMN [SelectedTrend] [int]  NULL



ALTER TABLE [Generic].[ProjectVersion]
ALTER COLUMN [VersionLabel] [nvarchar](500) NOT NULL

ALTER TABLE [Generic].[ProjectVersion]
ALTER COLUMN  [CreationDate] [datetime] NOT NULL

ALTER TABLE [Generic].[ScenarioMaster]
ALTER COLUMN [Name] [nvarchar](500) NOT NULL

ALTER TABLE [Generic].[SKU_Master]
ALTER COLUMN [Name] [nvarchar](500) NOT NULL

ALTER TABLE [Generic].[UserForecastMapping]
ALTER COLUMN [Version] [varchar](max)NOT  NULL

ALTER TABLE [Generic].[UserForecastMapping]
ALTER COLUMN [Authorization] [int]NOT  NULL

ALTER TABLE [Generic].[UserForecastMapping]
ALTER COLUMN [ShareByID] [int] NOT NULL

ALTER TABLE [Generic].[UserForecastMapping]
ALTER COLUMN [CreationDate] [datetime]NOT  NULL













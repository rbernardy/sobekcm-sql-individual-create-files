USE [sobekexample]
GO

/****** Object:  Table [dbo].[SobekCM_Item]    Script Date: 1/2/2022 10:51:14 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[SobekCM_Item](
	[ItemID] [int] IDENTITY(1,1) NOT NULL,
	[VID] [varchar](5) NOT NULL,
	[PageCount] [int] NOT NULL,
	[TextSearchable] [bit] NOT NULL,
	[AssocFilePath] [varchar](50) NULL,
	[Deleted] [bit] NOT NULL,
	[Title] [nvarchar](500) NOT NULL,
	[AccessMethod] [int] NOT NULL,
	[Link] [varchar](500) NULL,
	[CreateDate] [datetime] NULL,
	[PubYear] [int] NULL,
	[Locked] [bit] NOT NULL,
	[MainThumbnail] [varchar](100) NULL,
	[MainJPEG] [varchar](100) NULL,
	[PubDate] [nvarchar](100) NULL,
	[SortDate] [bigint] NULL,
	[Country] [nvarchar](250) NULL,
	[State] [nvarchar](250) NULL,
	[County] [nvarchar](250) NULL,
	[City] [nvarchar](250) NULL,
	[MainLatitude] [varchar](25) NULL,
	[MainLongitude] [varchar](25) NULL,
	[FileCount] [int] NOT NULL,
	[Format] [varchar](100) NOT NULL,
	[Donor] [nvarchar](250) NULL,
	[Publisher] [nvarchar](1000) NULL,
	[Author] [nvarchar](1000) NULL,
	[Spatial_KML] [varchar](4000) NULL,
	[GroupID] [int] NOT NULL,
	[Level1_Text] [nvarchar](255) NULL,
	[Level1_Index] [int] NULL,
	[Level2_Text] [nvarchar](255) NULL,
	[Level2_Index] [int] NULL,
	[Level3_Text] [nvarchar](255) NULL,
	[Level3_Index] [int] NULL,
	[Level4_Text] [nvarchar](255) NULL,
	[Level4_Index] [int] NULL,
	[Level5_Text] [nvarchar](255) NULL,
	[Level5_Index] [int] NULL,
	[CheckoutRequired] [bit] NOT NULL,
	[Spatial_KML_Distance] [float] NOT NULL,
	[DiskSize_KB] [bigint] NOT NULL,
	[IP_Restriction_Mask] [smallint] NOT NULL,
	[IncludeInAll] [bit] NOT NULL,
	[SuppressOAI] [bit] NOT NULL,
	[LastSaved] [datetime] NULL,
	[VIDSource] [varchar](150) NULL,
	[CreateYear] [smallint] NOT NULL,
	[CreateMonth] [smallint] NOT NULL,
	[Internal_Comments] [nvarchar](1000) NULL,
	[TEMP_SourceCode] [varchar](10) NULL,
	[TEMP_HoldingCode] [varchar](10) NULL,
	[Dark] [bit] NOT NULL,
	[CopyrightIndicator] [smallint] NULL,
	[VolumeID] [int] NOT NULL,
	[Last_MileStone] [int] NOT NULL,
	[Milestone_DigitalAcquisition] [datetime] NULL,
	[Milestone_ImageProcessing] [datetime] NULL,
	[Milestone_QualityControl] [datetime] NULL,
	[Milestone_OnlineComplete] [datetime] NULL,
	[Born_Digital] [bit] NOT NULL,
	[Material_Received_Date] [datetime] NULL,
	[Disposition_Advice] [int] NULL,
	[Disposition_Date] [datetime] NULL,
	[Disposition_Type] [int] NULL,
	[Locally_Archived] [bit] NOT NULL,
	[Remotely_Archived] [bit] NOT NULL,
	[Material_Recd_Date_Estimated] [bit] NOT NULL,
	[Tracking_Box] [varchar](25) NULL,
	[AggregationCodes] [varchar](100) NULL,
	[Left_To_Right] [bit] NOT NULL,
	[Disposition_Advice_Notes] [varchar](150) NOT NULL,
	[Disposition_Notes] [varchar](150) NOT NULL,
	[Spatial_Display] [nvarchar](1000) NULL,
	[Institution_Display] [nvarchar](1000) NULL,
	[Edition_Display] [nvarchar](1000) NULL,
	[Material_Display] [nvarchar](1000) NULL,
	[Measurement_Display] [nvarchar](1000) NULL,
	[StylePeriod_Display] [nvarchar](1000) NULL,
	[Technique_Display] [nvarchar](1000) NULL,
	[Subjects_Display] [nvarchar](1000) NULL,
	[AdditionalWorkNeeded] [bit] NOT NULL,
	[ExposeFullTextForHarvesting] [bit] NOT NULL,
	[Total_Hits] [bigint] NOT NULL,
	[Total_Sessions] [bigint] NOT NULL,
	[SortTitle] [nvarchar](500) NOT NULL,
	[TivoliSize_MB] [bigint] NOT NULL,
	[TivoliSize_Calculated] [datetime] NOT NULL,
	[metadataProfile] [nvarchar](50) NOT NULL,
	[COinS_OpenURL] [varchar](max) NULL,
	[Complete_KML] [varchar](max) NULL,
	[SpatialFootprint] [varchar](255) NULL,
	[SpatialFootprintDistance] [float] NOT NULL,
	[CitationSet] [varchar](50) NULL,
	[MadePublicDate] [datetime] NULL,
	[RestrictionMessage] [nvarchar](1000) NULL,
 CONSTRAINT [PK_Item] PRIMARY KEY CLUSTERED 
(
	[ItemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[SobekCM_Item] ADD  DEFAULT ((0)) FOR [TextSearchable]
GO

ALTER TABLE [dbo].[SobekCM_Item] ADD  CONSTRAINT [DF__UFDC_Item__Locke__7CC477D0]  DEFAULT ((0)) FOR [Locked]
GO

ALTER TABLE [dbo].[SobekCM_Item] ADD  CONSTRAINT [DF__UFDC_Item__FileC__09B45E9A]  DEFAULT ((-1)) FOR [FileCount]
GO

ALTER TABLE [dbo].[SobekCM_Item] ADD  CONSTRAINT [DF__UFDC_Item__Forma__0AA882D3]  DEFAULT ('') FOR [Format]
GO

ALTER TABLE [dbo].[SobekCM_Item] ADD  DEFAULT ('false') FOR [CheckoutRequired]
GO

ALTER TABLE [dbo].[SobekCM_Item] ADD  DEFAULT ((0)) FOR [Spatial_KML_Distance]
GO

ALTER TABLE [dbo].[SobekCM_Item] ADD  DEFAULT ((0)) FOR [DiskSize_KB]
GO

ALTER TABLE [dbo].[SobekCM_Item] ADD  DEFAULT ((0)) FOR [IP_Restriction_Mask]
GO

ALTER TABLE [dbo].[SobekCM_Item] ADD  DEFAULT ((1)) FOR [IncludeInAll]
GO

ALTER TABLE [dbo].[SobekCM_Item] ADD  DEFAULT ((0)) FOR [SuppressOAI]
GO

ALTER TABLE [dbo].[SobekCM_Item] ADD  DEFAULT ((-1)) FOR [CreateYear]
GO

ALTER TABLE [dbo].[SobekCM_Item] ADD  DEFAULT ((-1)) FOR [CreateMonth]
GO

ALTER TABLE [dbo].[SobekCM_Item] ADD  DEFAULT ((0)) FOR [Dark]
GO

ALTER TABLE [dbo].[SobekCM_Item] ADD  DEFAULT ((-1)) FOR [VolumeID]
GO

ALTER TABLE [dbo].[SobekCM_Item] ADD  DEFAULT ((0)) FOR [Last_MileStone]
GO

ALTER TABLE [dbo].[SobekCM_Item] ADD  DEFAULT ('false') FOR [Born_Digital]
GO

ALTER TABLE [dbo].[SobekCM_Item] ADD  DEFAULT ('false') FOR [Locally_Archived]
GO

ALTER TABLE [dbo].[SobekCM_Item] ADD  DEFAULT ('false') FOR [Remotely_Archived]
GO

ALTER TABLE [dbo].[SobekCM_Item] ADD  DEFAULT ('false') FOR [Material_Recd_Date_Estimated]
GO

ALTER TABLE [dbo].[SobekCM_Item] ADD  DEFAULT ('false') FOR [Left_To_Right]
GO

ALTER TABLE [dbo].[SobekCM_Item] ADD  DEFAULT ('') FOR [Disposition_Advice_Notes]
GO

ALTER TABLE [dbo].[SobekCM_Item] ADD  DEFAULT ('') FOR [Disposition_Notes]
GO

ALTER TABLE [dbo].[SobekCM_Item] ADD  DEFAULT ('false') FOR [AdditionalWorkNeeded]
GO

ALTER TABLE [dbo].[SobekCM_Item] ADD  DEFAULT ('true') FOR [ExposeFullTextForHarvesting]
GO

ALTER TABLE [dbo].[SobekCM_Item] ADD  DEFAULT ((0)) FOR [Total_Hits]
GO

ALTER TABLE [dbo].[SobekCM_Item] ADD  DEFAULT ((0)) FOR [Total_Sessions]
GO

ALTER TABLE [dbo].[SobekCM_Item] ADD  DEFAULT ('') FOR [SortTitle]
GO

ALTER TABLE [dbo].[SobekCM_Item] ADD  DEFAULT ((0)) FOR [TivoliSize_MB]
GO

ALTER TABLE [dbo].[SobekCM_Item] ADD  DEFAULT ('1/1/2000') FOR [TivoliSize_Calculated]
GO

ALTER TABLE [dbo].[SobekCM_Item] ADD  DEFAULT ('') FOR [metadataProfile]
GO

ALTER TABLE [dbo].[SobekCM_Item] ADD  DEFAULT ('') FOR [SpatialFootprint]
GO

ALTER TABLE [dbo].[SobekCM_Item] ADD  DEFAULT ((999)) FOR [SpatialFootprintDistance]
GO

ALTER TABLE [dbo].[SobekCM_Item]  WITH CHECK ADD  CONSTRAINT [FK_SobekCM_Item_Tracking_Disposition_Type] FOREIGN KEY([Disposition_Advice])
REFERENCES [dbo].[Tracking_Disposition_Type] ([DispositionID])
GO

ALTER TABLE [dbo].[SobekCM_Item] CHECK CONSTRAINT [FK_SobekCM_Item_Tracking_Disposition_Type]
GO

ALTER TABLE [dbo].[SobekCM_Item]  WITH CHECK ADD  CONSTRAINT [FK_SobekCM_Item_Tracking_Disposition_Type1] FOREIGN KEY([Disposition_Type])
REFERENCES [dbo].[Tracking_Disposition_Type] ([DispositionID])
GO

ALTER TABLE [dbo].[SobekCM_Item] CHECK CONSTRAINT [FK_SobekCM_Item_Tracking_Disposition_Type1]
GO

ALTER TABLE [dbo].[SobekCM_Item]  WITH CHECK ADD  CONSTRAINT [FK_UFDC_Item_UFDC_Item_Group] FOREIGN KEY([GroupID])
REFERENCES [dbo].[SobekCM_Item_Group] ([GroupID])
GO

ALTER TABLE [dbo].[SobekCM_Item] CHECK CONSTRAINT [FK_UFDC_Item_UFDC_Item_Group]
GO


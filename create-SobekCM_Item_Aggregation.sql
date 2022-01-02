USE [sobekexample]
GO

/****** Object:  Table [dbo].[SobekCM_Item_Aggregation]    Script Date: 1/2/2022 12:37:52 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[SobekCM_Item_Aggregation](
	[AggregationID] [int] IDENTITY(1,1) NOT NULL,
	[Code] [varchar](20) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[ShortName] [nvarchar](100) NULL,
	[Description] [nvarchar](1000) NULL,
	[ThematicHeadingID] [int] NOT NULL,
	[Type] [varchar](50) NULL,
	[isActive] [bit] NOT NULL,
	[Hidden] [bit] NOT NULL,
	[DisplayOptions] [varchar](10) NOT NULL,
	[Map_Search] [tinyint] NOT NULL,
	[Map_Display] [tinyint] NOT NULL,
	[OAI_Flag] [bit] NOT NULL,
	[OAI_Metadata] [nvarchar](2000) NULL,
	[ContactEmail] [varchar](255) NOT NULL,
	[HasNewItems] [bit] NOT NULL,
	[DefaultInterface] [varchar](50) NOT NULL,
	[TEMP_OldID] [int] NULL,
	[TEMP_OldType] [varchar](2) NULL,
	[Items_Can_Be_Described] [tinyint] NOT NULL,
	[LastItemAdded] [date] NULL,
	[External_Link] [nvarchar](255) NULL,
	[DateAdded] [datetime] NOT NULL,
	[Can_Browse_Items] [bit] NOT NULL,
	[Include_In_Collection_Facet] [bit] NOT NULL,
	[Current_Item_Count] [int] NOT NULL,
	[Current_Title_Count] [int] NOT NULL,
	[Deleted] [bit] NOT NULL,
	[Browse_Results_Display_SQL] [nvarchar](max) NOT NULL,
	[DeleteDate] [date] NULL,
	[LanguageVariants] [varchar](500) NOT NULL,
	[GroupResults] [bit] NOT NULL,
 CONSTRAINT [PK_SobekCM_Item_Aggregation] PRIMARY KEY CLUSTERED 
(
	[AggregationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[SobekCM_Item_Aggregation] ADD  CONSTRAINT [DF__SobekCM_I__Thema__4E298478]  DEFAULT ((-1)) FOR [ThematicHeadingID]
GO

ALTER TABLE [dbo].[SobekCM_Item_Aggregation] ADD  CONSTRAINT [DF__SobekCM_I__Hidde__4F1DA8B1]  DEFAULT ((0)) FOR [Hidden]
GO

ALTER TABLE [dbo].[SobekCM_Item_Aggregation] ADD  CONSTRAINT [DF__SobekCM_I__Displ__5011CCEA]  DEFAULT ('') FOR [DisplayOptions]
GO

ALTER TABLE [dbo].[SobekCM_Item_Aggregation] ADD  CONSTRAINT [DF__SobekCM_I__Map_S__5105F123]  DEFAULT ((0)) FOR [Map_Search]
GO

ALTER TABLE [dbo].[SobekCM_Item_Aggregation] ADD  CONSTRAINT [DF__SobekCM_I__Map_D__51FA155C]  DEFAULT ((0)) FOR [Map_Display]
GO

ALTER TABLE [dbo].[SobekCM_Item_Aggregation] ADD  CONSTRAINT [DF_SobekCM_Item_Aggregation_HasNewItems]  DEFAULT ((0)) FOR [HasNewItems]
GO

ALTER TABLE [dbo].[SobekCM_Item_Aggregation] ADD  CONSTRAINT [DF_SobekCM_Item_Aggregation_DefaultInterface]  DEFAULT ('') FOR [DefaultInterface]
GO

ALTER TABLE [dbo].[SobekCM_Item_Aggregation] ADD  DEFAULT ((1)) FOR [Items_Can_Be_Described]
GO

ALTER TABLE [dbo].[SobekCM_Item_Aggregation] ADD  DEFAULT ('1/1/1900') FOR [DateAdded]
GO

ALTER TABLE [dbo].[SobekCM_Item_Aggregation] ADD  DEFAULT ('true') FOR [Can_Browse_Items]
GO

ALTER TABLE [dbo].[SobekCM_Item_Aggregation] ADD  DEFAULT ('true') FOR [Include_In_Collection_Facet]
GO

ALTER TABLE [dbo].[SobekCM_Item_Aggregation] ADD  DEFAULT ((0)) FOR [Current_Item_Count]
GO

ALTER TABLE [dbo].[SobekCM_Item_Aggregation] ADD  DEFAULT ((0)) FOR [Current_Title_Count]
GO

ALTER TABLE [dbo].[SobekCM_Item_Aggregation] ADD  DEFAULT ('false') FOR [Deleted]
GO

ALTER TABLE [dbo].[SobekCM_Item_Aggregation] ADD  DEFAULT ('select S.ItemID, S.Publication_Date, S.Creator, S.[Publisher.Display] as Publisher, S.Format, S.Edition, S.Material, S.Measurements, S.Style_Period, S.Technique, S.[Subjects.Display] as Subjects, S.Source_Institution, S.Donor from SobekCM_Metadata_Basic_Search_Table S, @itemtable T where S.ItemID = T.ItemID order by T.RowNumber;') FOR [Browse_Results_Display_SQL]
GO

ALTER TABLE [dbo].[SobekCM_Item_Aggregation] ADD  DEFAULT ('') FOR [LanguageVariants]
GO

ALTER TABLE [dbo].[SobekCM_Item_Aggregation] ADD  DEFAULT ('false') FOR [GroupResults]
GO


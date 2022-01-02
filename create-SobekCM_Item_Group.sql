USE [sobekexample]
GO

/****** Object:  Table [dbo].[SobekCM_Item_Group]    Script Date: 1/2/2022 11:11:04 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[SobekCM_Item_Group](
	[GroupID] [int] IDENTITY(1,1) NOT NULL,
	[GroupTitle] [nvarchar](1000) NULL,
	[BibID] [varchar](10) NOT NULL,
	[Deleted] [bit] NOT NULL,
	[Type] [varchar](50) NOT NULL,
	[SortTitle] [nvarchar](1000) NOT NULL,
	[ItemCount] [int] NOT NULL,
	[SuppressEndeca] [bit] NOT NULL,
	[File_Root] [varchar](100) NOT NULL,
	[GroupCreateDate] [datetime] NOT NULL,
	[File_Location] [varchar](100) NULL,
	[OCLC] [varchar](13) NOT NULL,
	[ALEPH] [varchar](9) NOT NULL,
	[OCLC_Number] [bigint] NOT NULL,
	[ALEPH_Number] [int] NOT NULL,
	[GroupThumbnail] [varchar](500) NULL,
	[Internal_Comments] [nvarchar](1000) NULL,
	[Bib_Source] [varchar](255) NULL,
	[TEMP_ReceivingID] [int] NOT NULL,
	[Track_By_Month] [bit] NOT NULL,
	[Large_Format] [bit] NOT NULL,
	[Never_Overlay_Record] [bit] NOT NULL,
	[Include_In_MarcXML_Prod_Feed] [bit] NOT NULL,
	[Include_In_MarcXML_Test_Feed] [bit] NOT NULL,
	[Suppress_OAI] [bit] NOT NULL,
	[Primary_Identifier_Type] [nvarchar](50) NULL,
	[Primary_Identifier] [nvarchar](100) NULL,
	[HasGroupMetadata] [bit] NOT NULL,
	[CustomThumbnail] [nvarchar](255) NULL,
	[ThumbnailType] [tinyint] NOT NULL,
	[FlagByte] [tinyint] NOT NULL,
	[LastFourInt] [smallint] NULL,
 CONSTRAINT [PK_SobekCM_Item_Group] PRIMARY KEY CLUSTERED 
(
	[GroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[SobekCM_Item_Group] ADD  CONSTRAINT [DF_UFDC_Item_Group_Deleted]  DEFAULT ((0)) FOR [Deleted]
GO

ALTER TABLE [dbo].[SobekCM_Item_Group] ADD  DEFAULT ('') FOR [SortTitle]
GO

ALTER TABLE [dbo].[SobekCM_Item_Group] ADD  DEFAULT ((0)) FOR [ItemCount]
GO

ALTER TABLE [dbo].[SobekCM_Item_Group] ADD  DEFAULT ((1)) FOR [SuppressEndeca]
GO

ALTER TABLE [dbo].[SobekCM_Item_Group] ADD  DEFAULT ('collect/image_files/') FOR [File_Root]
GO

ALTER TABLE [dbo].[SobekCM_Item_Group] ADD  DEFAULT ('') FOR [OCLC]
GO

ALTER TABLE [dbo].[SobekCM_Item_Group] ADD  DEFAULT ('') FOR [ALEPH]
GO

ALTER TABLE [dbo].[SobekCM_Item_Group] ADD  DEFAULT ((-1)) FOR [OCLC_Number]
GO

ALTER TABLE [dbo].[SobekCM_Item_Group] ADD  DEFAULT ((-1)) FOR [ALEPH_Number]
GO

ALTER TABLE [dbo].[SobekCM_Item_Group] ADD  DEFAULT ((-1)) FOR [TEMP_ReceivingID]
GO

ALTER TABLE [dbo].[SobekCM_Item_Group] ADD  DEFAULT ('false') FOR [Track_By_Month]
GO

ALTER TABLE [dbo].[SobekCM_Item_Group] ADD  DEFAULT ('false') FOR [Large_Format]
GO

ALTER TABLE [dbo].[SobekCM_Item_Group] ADD  DEFAULT ('false') FOR [Never_Overlay_Record]
GO

ALTER TABLE [dbo].[SobekCM_Item_Group] ADD  DEFAULT ('true') FOR [Include_In_MarcXML_Prod_Feed]
GO

ALTER TABLE [dbo].[SobekCM_Item_Group] ADD  DEFAULT ('false') FOR [Include_In_MarcXML_Test_Feed]
GO

ALTER TABLE [dbo].[SobekCM_Item_Group] ADD  DEFAULT ('false') FOR [Suppress_OAI]
GO

ALTER TABLE [dbo].[SobekCM_Item_Group] ADD  DEFAULT ('false') FOR [HasGroupMetadata]
GO

ALTER TABLE [dbo].[SobekCM_Item_Group] ADD  DEFAULT ((0)) FOR [ThumbnailType]
GO

ALTER TABLE [dbo].[SobekCM_Item_Group] ADD  DEFAULT ((0)) FOR [FlagByte]
GO


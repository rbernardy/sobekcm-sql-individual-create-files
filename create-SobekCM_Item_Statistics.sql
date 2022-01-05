USE [sobekexample]
GO

/****** Object:  Table [dbo].[SobekCM_Item_Statistics]    Script Date: 1/4/2022 9:07:11 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[SobekCM_Item_Statistics](
	[ItemStatsID] [int] IDENTITY(1,1) NOT NULL,
	[ItemID] [int] NOT NULL,
	[Year] [smallint] NOT NULL,
	[Month] [smallint] NOT NULL,
	[Hits] [int] NOT NULL,
	[Sessions] [int] NOT NULL,
	[JPEG_Views] [int] NOT NULL,
	[Zoomable_Views] [int] NOT NULL,
	[Citation_Views] [int] NOT NULL,
	[Thumbnail_Views] [int] NOT NULL,
	[Text_Search_Views] [int] NOT NULL,
	[Flash_Views] [int] NOT NULL,
	[Google_Map_Views] [int] NOT NULL,
	[Download_Views] [int] NOT NULL,
	[Static_Views] [int] NOT NULL,
 CONSTRAINT [PK_SobekCM_Item_Statistics] PRIMARY KEY CLUSTERED 
(
	[ItemStatsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[SobekCM_Item_Statistics]  WITH CHECK ADD  CONSTRAINT [FK_UFDC_Item_Statistics_UFDC_Item] FOREIGN KEY([ItemID])
REFERENCES [dbo].[SobekCM_Item] ([ItemID])
GO

ALTER TABLE [dbo].[SobekCM_Item_Statistics] CHECK CONSTRAINT [FK_UFDC_Item_Statistics_UFDC_Item]
GO


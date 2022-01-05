USE [sobekexample]
GO

/****** Object:  Table [dbo].[SobekCM_Item_Aggregation_Statistics]    Script Date: 1/4/2022 9:00:02 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[SobekCM_Item_Aggregation_Statistics](
	[AggregationStatsID] [int] IDENTITY(1,1) NOT NULL,
	[AggregationID] [int] NOT NULL,
	[Year] [smallint] NOT NULL,
	[Month] [smallint] NOT NULL,
	[Hits] [int] NOT NULL,
	[Sessions] [int] NOT NULL,
	[Home_Page_Views] [int] NOT NULL,
	[Browse_Views] [int] NOT NULL,
	[Advanced_Search_Views] [int] NOT NULL,
	[Search_Results_Views] [int] NOT NULL,
	[Title_Hits] [int] NULL,
	[Item_Hits] [int] NULL,
	[Item_JPEG_Views] [int] NULL,
	[Item_Zoomable_Views] [int] NULL,
	[Item_Citation_Views] [int] NULL,
	[Item_Thumbnail_Views] [int] NULL,
	[Item_Text_Search_Views] [int] NULL,
	[Item_Flash_Views] [int] NULL,
	[Item_Google_Map_Views] [int] NULL,
	[Item_Download_Views] [int] NULL,
	[Item_Static_Views] [int] NULL,
	[Title_Count] [int] NULL,
	[Item_Count] [int] NULL,
 CONSTRAINT [PK_SobekCM_Item_Aggregation_Statistics] PRIMARY KEY CLUSTERED 
(
	[AggregationStatsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[SobekCM_Item_Aggregation_Statistics]  WITH CHECK ADD  CONSTRAINT [FK_SobekCM_Item_Aggregation_Statistics_SobekCM_Item_Aggregation] FOREIGN KEY([AggregationID])
REFERENCES [dbo].[SobekCM_Item_Aggregation] ([AggregationID])
GO

ALTER TABLE [dbo].[SobekCM_Item_Aggregation_Statistics] CHECK CONSTRAINT [FK_SobekCM_Item_Aggregation_Statistics_SobekCM_Item_Aggregation]
GO


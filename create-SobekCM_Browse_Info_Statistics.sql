USE [sobektest]
GO

/****** Object:  Table [dbo].[SobekCM_Browse_Info_Statistics]    Script Date: 1/4/2022 10:07:14 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[SobekCM_Browse_Info_Statistics](
	[BrowseInfoStatsID] [int] IDENTITY(1,1) NOT NULL,
	[AggregationID] [int] NULL,
	[BrowseInfoCode] [varchar](150) NOT NULL,
	[Year] [smallint] NOT NULL,
	[Month] [smallint] NOT NULL,
	[Hits] [int] NOT NULL,
 CONSTRAINT [PK_SobekCM_Browse_Info_Statistics] PRIMARY KEY CLUSTERED 
(
	[BrowseInfoStatsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[SobekCM_Browse_Info_Statistics]  WITH CHECK ADD  CONSTRAINT [FK_SobekCM_Browse_Info_Statistics_SobekCM_Item_Aggregation] FOREIGN KEY([AggregationID])
REFERENCES [dbo].[SobekCM_Item_Aggregation] ([AggregationID])
GO

ALTER TABLE [dbo].[SobekCM_Browse_Info_Statistics] CHECK CONSTRAINT [FK_SobekCM_Browse_Info_Statistics_SobekCM_Item_Aggregation]
GO


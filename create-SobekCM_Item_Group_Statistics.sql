USE [sobekexample]
GO

/****** Object:  Table [dbo].[SobekCM_Item_Group_Statistics]    Script Date: 1/4/2022 9:03:13 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[SobekCM_Item_Group_Statistics](
	[ItemGroupStatsID] [int] IDENTITY(1,1) NOT NULL,
	[GroupID] [int] NOT NULL,
	[Year] [smallint] NOT NULL,
	[Month] [smallint] NOT NULL,
	[Hits] [int] NULL,
	[Sessions] [int] NOT NULL,
 CONSTRAINT [PK_SobekCM_Item_Group_Statistics] PRIMARY KEY CLUSTERED 
(
	[ItemGroupStatsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[SobekCM_Item_Group_Statistics]  WITH CHECK ADD  CONSTRAINT [FK_UFDC_Item_Group_Statistics_UFDC_Item_Group] FOREIGN KEY([GroupID])
REFERENCES [dbo].[SobekCM_Item_Group] ([GroupID])
GO

ALTER TABLE [dbo].[SobekCM_Item_Group_Statistics] CHECK CONSTRAINT [FK_UFDC_Item_Group_Statistics_UFDC_Item_Group]
GO


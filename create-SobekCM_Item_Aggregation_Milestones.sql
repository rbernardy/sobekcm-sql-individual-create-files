USE [sobektest]
GO

/****** Object:  Table [dbo].[SobekCM_Item_Aggregation_Milestones]    Script Date: 1/12/2022 10:29:13 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[SobekCM_Item_Aggregation_Milestones](
	[AggregationMilestoneID] [int] IDENTITY(1,1) NOT NULL,
	[AggregationID] [int] NOT NULL,
	[Milestone] [nvarchar](max) NOT NULL,
	[MilestoneDate] [date] NOT NULL,
	[MilestoneUser] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_SobekCM_Item_Aggregation_Milestones] PRIMARY KEY CLUSTERED 
(
	[AggregationMilestoneID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[SobekCM_Item_Aggregation_Milestones]  WITH CHECK ADD  CONSTRAINT [fk_ItemAggregationMilestones] FOREIGN KEY([AggregationID])
REFERENCES [dbo].[SobekCM_Item_Aggregation] ([AggregationID])
GO

ALTER TABLE [dbo].[SobekCM_Item_Aggregation_Milestones] CHECK CONSTRAINT [fk_ItemAggregationMilestones]
GO


USE [sobekexample]
GO

/****** Object:  Table [dbo].[SobekCM_Item_Aggregation_Item_Link]    Script Date: 1/2/2022 12:55:14 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[SobekCM_Item_Aggregation_Item_Link](
	[ItemID] [int] NOT NULL,
	[AggregationID] [int] NOT NULL,
	[impliedLink] [bit] NOT NULL,
 CONSTRAINT [PK_SobekCM_Item_Aggregation_Item_Link] PRIMARY KEY CLUSTERED 
(
	[ItemID] ASC,
	[AggregationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[SobekCM_Item_Aggregation_Item_Link] ADD  DEFAULT ((0)) FOR [impliedLink]
GO

ALTER TABLE [dbo].[SobekCM_Item_Aggregation_Item_Link]  WITH CHECK ADD  CONSTRAINT [FK_SobekCM_Item_Aggregation_Item_Link_SobekCM_Item_Aggregation] FOREIGN KEY([AggregationID])
REFERENCES [dbo].[SobekCM_Item_Aggregation] ([AggregationID])
GO

ALTER TABLE [dbo].[SobekCM_Item_Aggregation_Item_Link] CHECK CONSTRAINT [FK_SobekCM_Item_Aggregation_Item_Link_SobekCM_Item_Aggregation]
GO

ALTER TABLE [dbo].[SobekCM_Item_Aggregation_Item_Link]  WITH CHECK ADD  CONSTRAINT [FK_SobekCM_Item_Aggregation_Item_Link_UFDC_Item] FOREIGN KEY([ItemID])
REFERENCES [dbo].[SobekCM_Item] ([ItemID])
GO

ALTER TABLE [dbo].[SobekCM_Item_Aggregation_Item_Link] CHECK CONSTRAINT [FK_SobekCM_Item_Aggregation_Item_Link_UFDC_Item]
GO


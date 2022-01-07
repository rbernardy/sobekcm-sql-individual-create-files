USE [sobektest]
GO

/****** Object:  Table [dbo].[SobekCM_Portal_Item_Aggregation_Link]    Script Date: 1/6/2022 9:42:12 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[SobekCM_Portal_Item_Aggregation_Link](
	[PortalID] [int] NOT NULL,
	[AggregationID] [int] NOT NULL,
	[isDefault] [bit] NOT NULL,
 CONSTRAINT [PK_SobekCM_Portal_Item_Aggregation_Link] PRIMARY KEY CLUSTERED 
(
	[PortalID] ASC,
	[AggregationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[SobekCM_Portal_Item_Aggregation_Link]  WITH CHECK ADD  CONSTRAINT [FK_SobekCM_Portal_Item_Aggregation_Link_SobekCM_Item_Aggregation] FOREIGN KEY([AggregationID])
REFERENCES [dbo].[SobekCM_Item_Aggregation] ([AggregationID])
GO

ALTER TABLE [dbo].[SobekCM_Portal_Item_Aggregation_Link] CHECK CONSTRAINT [FK_SobekCM_Portal_Item_Aggregation_Link_SobekCM_Item_Aggregation]
GO

ALTER TABLE [dbo].[SobekCM_Portal_Item_Aggregation_Link]  WITH CHECK ADD  CONSTRAINT [FK_SobekCM_Portal_Item_Aggregation_Link_SobekCM_Portal_URL] FOREIGN KEY([PortalID])
REFERENCES [dbo].[SobekCM_Portal_URL] ([PortalID])
GO

ALTER TABLE [dbo].[SobekCM_Portal_Item_Aggregation_Link] CHECK CONSTRAINT [FK_SobekCM_Portal_Item_Aggregation_Link_SobekCM_Portal_URL]
GO


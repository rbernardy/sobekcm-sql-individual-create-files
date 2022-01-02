USE [sobekexample]
GO

/****** Object:  Table [dbo].[SobekCM_Item_Aggregation_Hierarchy]    Script Date: 1/2/2022 12:44:04 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[SobekCM_Item_Aggregation_Hierarchy](
	[ParentID] [int] NOT NULL,
	[ChildID] [int] NOT NULL,
	[Search_Parent_Only] [bit] NOT NULL,
 CONSTRAINT [PK_SobekCM_Item_Aggregation_Hierarchy] PRIMARY KEY CLUSTERED 
(
	[ParentID] ASC,
	[ChildID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[SobekCM_Item_Aggregation_Hierarchy] ADD  DEFAULT ((0)) FOR [Search_Parent_Only]
GO

ALTER TABLE [dbo].[SobekCM_Item_Aggregation_Hierarchy]  WITH CHECK ADD  CONSTRAINT [FK_SobekCM_Item_Aggregation_Hierarchy_SobekCM_Item_Aggregation] FOREIGN KEY([ChildID])
REFERENCES [dbo].[SobekCM_Item_Aggregation] ([AggregationID])
GO

ALTER TABLE [dbo].[SobekCM_Item_Aggregation_Hierarchy] CHECK CONSTRAINT [FK_SobekCM_Item_Aggregation_Hierarchy_SobekCM_Item_Aggregation]
GO

ALTER TABLE [dbo].[SobekCM_Item_Aggregation_Hierarchy]  WITH CHECK ADD  CONSTRAINT [FK_SobekCM_Item_Aggregation_Hierarchy_SobekCM_Item_Aggregation1] FOREIGN KEY([ParentID])
REFERENCES [dbo].[SobekCM_Item_Aggregation] ([AggregationID])
GO

ALTER TABLE [dbo].[SobekCM_Item_Aggregation_Hierarchy] CHECK CONSTRAINT [FK_SobekCM_Item_Aggregation_Hierarchy_SobekCM_Item_Aggregation1]
GO


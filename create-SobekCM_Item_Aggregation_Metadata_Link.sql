USE [sobektest]
GO

/****** Object:  Table [dbo].[SobekCM_Item_Aggregation_Metadata_Link]    Script Date: 1/12/2022 10:16:18 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[SobekCM_Item_Aggregation_Metadata_Link](
	[AggregationID] [int] NOT NULL,
	[MetadataID] [bigint] NOT NULL,
	[Metadata_Count] [int] NOT NULL,
	[MetadataTypeID] [smallint] NULL,
	[OrderNum] [int] NOT NULL,
 CONSTRAINT [PK_SobekCM_Item_Aggregation_Metadata_Link] PRIMARY KEY CLUSTERED 
(
	[AggregationID] ASC,
	[MetadataID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[SobekCM_Item_Aggregation_Metadata_Link] ADD  DEFAULT ((1)) FOR [OrderNum]
GO

ALTER TABLE [dbo].[SobekCM_Item_Aggregation_Metadata_Link]  WITH CHECK ADD  CONSTRAINT [FK_SobekCM_Item_Aggregation_Metadata_Link_SobekCM_Item_Aggregation] FOREIGN KEY([AggregationID])
REFERENCES [dbo].[SobekCM_Item_Aggregation] ([AggregationID])
GO

ALTER TABLE [dbo].[SobekCM_Item_Aggregation_Metadata_Link] CHECK CONSTRAINT [FK_SobekCM_Item_Aggregation_Metadata_Link_SobekCM_Item_Aggregation]
GO

ALTER TABLE [dbo].[SobekCM_Item_Aggregation_Metadata_Link]  WITH CHECK ADD  CONSTRAINT [FK_SobekCM_Item_Aggregation_Metadata_Link_SobekCM_Metadata_Unique_Search_Table] FOREIGN KEY([MetadataID])
REFERENCES [dbo].[SobekCM_Metadata_Unique_Search_Table] ([MetadataID])
GO

ALTER TABLE [dbo].[SobekCM_Item_Aggregation_Metadata_Link] CHECK CONSTRAINT [FK_SobekCM_Item_Aggregation_Metadata_Link_SobekCM_Metadata_Unique_Search_Table]
GO


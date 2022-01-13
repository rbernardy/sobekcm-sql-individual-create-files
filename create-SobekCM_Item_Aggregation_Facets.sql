USE [sobektest]
GO

/****** Object:  Table [dbo].[SobekCM_Item_Aggregation_Facets]    Script Date: 1/12/2022 10:00:33 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[SobekCM_Item_Aggregation_Facets](
	[AggregationID] [int] NOT NULL,
	[MetadataTypeID] [smallint] NOT NULL,
	[OverrideFacetTerm] [nvarchar](100) NULL,
	[FacetOrder] [int] NOT NULL,
	[FacetOptions] [nvarchar](2000) NULL,
 CONSTRAINT [PK_SobekCM_Item_Aggregation_Facets] PRIMARY KEY CLUSTERED 
(
	[AggregationID] ASC,
	[MetadataTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[SobekCM_Item_Aggregation_Facets]  WITH CHECK ADD  CONSTRAINT [FK_SobekCM_Item_Aggregation_Facets_SobekCM_Item_Aggregation] FOREIGN KEY([AggregationID])
REFERENCES [dbo].[SobekCM_Item_Aggregation] ([AggregationID])
GO

ALTER TABLE [dbo].[SobekCM_Item_Aggregation_Facets] CHECK CONSTRAINT [FK_SobekCM_Item_Aggregation_Facets_SobekCM_Item_Aggregation]
GO

ALTER TABLE [dbo].[SobekCM_Item_Aggregation_Facets]  WITH CHECK ADD  CONSTRAINT [FK_SobekCM_Item_Aggregation_Facets_SobekCM_Metadata_Types] FOREIGN KEY([MetadataTypeID])
REFERENCES [dbo].[SobekCM_Metadata_Types] ([MetadataTypeID])
GO

ALTER TABLE [dbo].[SobekCM_Item_Aggregation_Facets] CHECK CONSTRAINT [FK_SobekCM_Item_Aggregation_Facets_SobekCM_Metadata_Types]
GO


USE [sobektest]
GO

/****** Object:  Table [dbo].[SobekCM_Item_Aggregation_Result_Fields]    Script Date: 1/12/2022 10:39:56 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[SobekCM_Item_Aggregation_Result_Fields](
	[ItemAggregationResultID] [int] NOT NULL,
	[MetadataTypeID] [smallint] NOT NULL,
	[OverrideDisplayTerm] [nvarchar](255) NULL,
	[DisplayOrder] [int] NOT NULL,
	[DisplayOptions] [nvarchar](2000) NULL,
 CONSTRAINT [PK_SobekCM_Item_Aggregation_Result_Fields] PRIMARY KEY CLUSTERED 
(
	[ItemAggregationResultID] ASC,
	[MetadataTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[SobekCM_Item_Aggregation_Result_Fields]  WITH CHECK ADD  CONSTRAINT [FK_SobekCM_Item_Aggregation_Result_Fields_SobekCM_Item_Aggregation_Result_Views] FOREIGN KEY([ItemAggregationResultID])
REFERENCES [dbo].[SobekCM_Item_Aggregation_Result_Views] ([ItemAggregationResultID])
GO

ALTER TABLE [dbo].[SobekCM_Item_Aggregation_Result_Fields] CHECK CONSTRAINT [FK_SobekCM_Item_Aggregation_Result_Fields_SobekCM_Item_Aggregation_Result_Views]
GO


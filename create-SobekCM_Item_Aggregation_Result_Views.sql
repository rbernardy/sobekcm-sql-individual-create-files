USE [sobektest]
GO

/****** Object:  Table [dbo].[SobekCM_Item_Aggregation_Result_Views]    Script Date: 1/12/2022 11:07:01 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[SobekCM_Item_Aggregation_Result_Views](
	[ItemAggregationResultID] [int] IDENTITY(1,1) NOT NULL,
	[AggregationID] [int] NOT NULL,
	[ItemAggregationResultTypeID] [int] NOT NULL,
	[DefaultView] [bit] NOT NULL,
 CONSTRAINT [PK_SobekCM_Item_Aggregation_Result_Views] PRIMARY KEY CLUSTERED 
(
	[ItemAggregationResultID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[SobekCM_Item_Aggregation_Result_Views] ADD  DEFAULT ('false') FOR [DefaultView]
GO

ALTER TABLE [dbo].[SobekCM_Item_Aggregation_Result_Views]  WITH CHECK ADD  CONSTRAINT [FK_SobekCM_Item_Aggregation_Result_Views_AggregationID] FOREIGN KEY([AggregationID])
REFERENCES [dbo].[SobekCM_Item_Aggregation] ([AggregationID])
GO

ALTER TABLE [dbo].[SobekCM_Item_Aggregation_Result_Views] CHECK CONSTRAINT [FK_SobekCM_Item_Aggregation_Result_Views_AggregationID]
GO

ALTER TABLE [dbo].[SobekCM_Item_Aggregation_Result_Views]  WITH CHECK ADD  CONSTRAINT [FK_SobekCM_Item_Aggregation_Result_Views_SobekCM_Item_Aggregation_Result_Types] FOREIGN KEY([ItemAggregationResultTypeID])
REFERENCES [dbo].[SobekCM_Item_Aggregation_Result_Types] ([ItemAggregationResultTypeID])
GO

ALTER TABLE [dbo].[SobekCM_Item_Aggregation_Result_Views] CHECK CONSTRAINT [FK_SobekCM_Item_Aggregation_Result_Views_SobekCM_Item_Aggregation_Result_Types]
GO

ALTER TABLE [dbo].[SobekCM_Item_Aggregation_Result_Views]  WITH CHECK ADD  CONSTRAINT [FK_SobekCM_Item_Aggregation_Result_Views_TypeID] FOREIGN KEY([ItemAggregationResultTypeID])
REFERENCES [dbo].[SobekCM_Item_Aggregation_Result_Types] ([ItemAggregationResultTypeID])
GO

ALTER TABLE [dbo].[SobekCM_Item_Aggregation_Result_Views] CHECK CONSTRAINT [FK_SobekCM_Item_Aggregation_Result_Views_TypeID]
GO


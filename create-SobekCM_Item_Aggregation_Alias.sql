USE [sobekexample]
GO

/****** Object:  Table [dbo].[SobekCM_Item_Aggregation_Alias]    Script Date: 1/2/2022 12:59:15 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[SobekCM_Item_Aggregation_Alias](
	[AggregationAliasID] [int] IDENTITY(1,1) NOT NULL,
	[AggregationAlias] [varchar](50) NOT NULL,
	[AggregationID] [int] NOT NULL,
 CONSTRAINT [PK_SobekCM_Item_Aggregation_Alias] PRIMARY KEY CLUSTERED 
(
	[AggregationAliasID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[SobekCM_Item_Aggregation_Alias]  WITH CHECK ADD  CONSTRAINT [FK_SobekCM_Item_Aggregation_Alias_SobekCM_Item_Aggregation] FOREIGN KEY([AggregationID])
REFERENCES [dbo].[SobekCM_Item_Aggregation] ([AggregationID])
GO

ALTER TABLE [dbo].[SobekCM_Item_Aggregation_Alias] CHECK CONSTRAINT [FK_SobekCM_Item_Aggregation_Alias_SobekCM_Item_Aggregation]
GO


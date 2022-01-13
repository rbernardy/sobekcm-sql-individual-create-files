USE [sobektest]
GO

/****** Object:  Table [dbo].[SobekCM_Item_Aggregation_Result_Types]    Script Date: 1/12/2022 10:53:28 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[SobekCM_Item_Aggregation_Result_Types](
	[ItemAggregationResultTypeID] [int] IDENTITY(1,1) NOT NULL,
	[ResultType] [varchar](50) NOT NULL,
	[DefaultOrder] [int] NOT NULL,
	[DefaultView] [bit] NOT NULL,
 CONSTRAINT [PK_SobekCM_Item_Aggregation_Result_Types] PRIMARY KEY CLUSTERED 
(
	[ItemAggregationResultTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [SobekCM_Item_Aggregation_Result_Types_Unique] UNIQUE NONCLUSTERED 
(
	[ResultType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[SobekCM_Item_Aggregation_Result_Types] ADD  DEFAULT ((100)) FOR [DefaultOrder]
GO

ALTER TABLE [dbo].[SobekCM_Item_Aggregation_Result_Types] ADD  DEFAULT ('false') FOR [DefaultView]
GO


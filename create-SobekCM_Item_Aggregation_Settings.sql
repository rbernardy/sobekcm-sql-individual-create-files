USE [sobektest]
GO

/****** Object:  Table [dbo].[SobekCM_Item_Aggregation_Settings]    Script Date: 1/12/2022 11:16:02 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[SobekCM_Item_Aggregation_Settings](
	[AggregationSettingID] [bigint] IDENTITY(1,1) NOT NULL,
	[AggregationID] [int] NOT NULL,
	[Setting_Key] [nvarchar](255) NOT NULL,
	[Setting_Value] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_SobekCM_Item_Aggregation_Settings] PRIMARY KEY CLUSTERED 
(
	[AggregationSettingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[SobekCM_Item_Aggregation_Settings]  WITH CHECK ADD  CONSTRAINT [FK_Aggregation_Settings_Aggregation] FOREIGN KEY([AggregationID])
REFERENCES [dbo].[SobekCM_Item_Aggregation] ([AggregationID])
GO

ALTER TABLE [dbo].[SobekCM_Item_Aggregation_Settings] CHECK CONSTRAINT [FK_Aggregation_Settings_Aggregation]
GO


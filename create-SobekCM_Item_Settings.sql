USE [sobektest]
GO

/****** Object:  Table [dbo].[SobekCM_Item_Settings]    Script Date: 1/9/2022 9:32:30 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[SobekCM_Item_Settings](
	[ItemSettingID] [bigint] IDENTITY(1,1) NOT NULL,
	[ItemID] [int] NOT NULL,
	[Setting_Key] [nvarchar](255) NOT NULL,
	[Setting_Value] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_SobekCM_Item_Settings] PRIMARY KEY CLUSTERED 
(
	[ItemSettingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[SobekCM_Item_Settings]  WITH CHECK ADD  CONSTRAINT [FK_Item_Settings_Item] FOREIGN KEY([ItemID])
REFERENCES [dbo].[SobekCM_Item] ([ItemID])
GO

ALTER TABLE [dbo].[SobekCM_Item_Settings] CHECK CONSTRAINT [FK_Item_Settings_Item]
GO


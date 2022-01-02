USE [sobekexample]
GO

/****** Object:  Table [dbo].[SobekCM_Item_Viewers]    Script Date: 1/2/2022 1:03:21 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[SobekCM_Item_Viewers](
	[ItemViewID] [int] IDENTITY(1,1) NOT NULL,
	[ItemID] [int] NOT NULL,
	[ItemViewTypeID] [int] NOT NULL,
	[Attribute] [nvarchar](250) NOT NULL,
	[Label] [nvarchar](50) NOT NULL,
	[OrderOverride] [int] NULL,
	[Exclude] [bit] NOT NULL,
	[MenuOrder] [float] NULL,
 CONSTRAINT [PK_SobekCM_Item_Viewers] PRIMARY KEY CLUSTERED 
(
	[ItemViewID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[SobekCM_Item_Viewers] ADD  DEFAULT ('false') FOR [Exclude]
GO

ALTER TABLE [dbo].[SobekCM_Item_Viewers]  WITH CHECK ADD  CONSTRAINT [FK_SobekCM_Item_Viewers_SobekCM_Item] FOREIGN KEY([ItemID])
REFERENCES [dbo].[SobekCM_Item] ([ItemID])
GO

ALTER TABLE [dbo].[SobekCM_Item_Viewers] CHECK CONSTRAINT [FK_SobekCM_Item_Viewers_SobekCM_Item]
GO

ALTER TABLE [dbo].[SobekCM_Item_Viewers]  WITH CHECK ADD  CONSTRAINT [FK_SobekCM_Item_Viewers_SobekCM_Item_Viewer_Types] FOREIGN KEY([ItemViewTypeID])
REFERENCES [dbo].[SobekCM_Item_Viewer_Types] ([ItemViewTypeID])
GO

ALTER TABLE [dbo].[SobekCM_Item_Viewers] CHECK CONSTRAINT [FK_SobekCM_Item_Viewers_SobekCM_Item_Viewer_Types]
GO


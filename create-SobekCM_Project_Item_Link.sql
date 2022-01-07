USE [sobektest]
GO

/****** Object:  Table [dbo].[SobekCM_Project_Item_Link]    Script Date: 1/6/2022 10:28:56 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[SobekCM_Project_Item_Link](
	[ProjectID] [int] NOT NULL,
	[ItemID] [int] NOT NULL,
 CONSTRAINT [PK_SobekCM_Project_Item_Link] PRIMARY KEY CLUSTERED 
(
	[ProjectID] ASC,
	[ItemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[SobekCM_Project_Item_Link]  WITH CHECK ADD  CONSTRAINT [FK_Project_Item_ItemID] FOREIGN KEY([ItemID])
REFERENCES [dbo].[SobekCM_Item] ([ItemID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[SobekCM_Project_Item_Link] CHECK CONSTRAINT [FK_Project_Item_ItemID]
GO

ALTER TABLE [dbo].[SobekCM_Project_Item_Link]  WITH CHECK ADD  CONSTRAINT [FK_Project_Item_ProjectID] FOREIGN KEY([ProjectID])
REFERENCES [dbo].[SobekCM_Project] ([ProjectID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[SobekCM_Project_Item_Link] CHECK CONSTRAINT [FK_Project_Item_ProjectID]
GO


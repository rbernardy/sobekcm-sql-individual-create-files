USE [sobekexample]
GO

/****** Object:  Table [dbo].[mySobek_User_Item_Link]    Script Date: 1/4/2022 7:56:36 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[mySobek_User_Item_Link](
	[UserID] [int] NOT NULL,
	[ItemID] [int] NOT NULL,
	[RelationshipID] [int] NOT NULL,
 CONSTRAINT [PK_mySobek_User_Item_Link] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC,
	[ItemID] ASC,
	[RelationshipID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[mySobek_User_Item_Link]  WITH CHECK ADD  CONSTRAINT [FK_mySobek_User_Item_Link_mySobek_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[mySobek_User] ([UserID])
GO

ALTER TABLE [dbo].[mySobek_User_Item_Link] CHECK CONSTRAINT [FK_mySobek_User_Item_Link_mySobek_User]
GO

ALTER TABLE [dbo].[mySobek_User_Item_Link]  WITH CHECK ADD  CONSTRAINT [FK_mySobek_User_Item_Link_mySobek_User_Item_Link_Relationship] FOREIGN KEY([RelationshipID])
REFERENCES [dbo].[mySobek_User_Item_Link_Relationship] ([RelationshipID])
GO

ALTER TABLE [dbo].[mySobek_User_Item_Link] CHECK CONSTRAINT [FK_mySobek_User_Item_Link_mySobek_User_Item_Link_Relationship]
GO

ALTER TABLE [dbo].[mySobek_User_Item_Link]  WITH CHECK ADD  CONSTRAINT [FK_mySobek_User_Item_Link_SobekCM_Item] FOREIGN KEY([ItemID])
REFERENCES [dbo].[SobekCM_Item] ([ItemID])
GO

ALTER TABLE [dbo].[mySobek_User_Item_Link] CHECK CONSTRAINT [FK_mySobek_User_Item_Link_SobekCM_Item]
GO


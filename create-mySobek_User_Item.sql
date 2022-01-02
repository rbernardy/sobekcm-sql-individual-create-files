USE [sobekexample]
GO

/****** Object:  Table [dbo].[mySobek_User_Item]    Script Date: 1/2/2022 2:01:38 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[mySobek_User_Item](
	[UserItemID] [int] IDENTITY(1,1) NOT NULL,
	[UserFolderID] [int] NOT NULL,
	[ItemOrder] [int] NOT NULL,
	[UserNotes] [nvarchar](2000) NULL,
	[DateAdded] [datetime] NOT NULL,
	[ItemID] [int] NOT NULL,
 CONSTRAINT [PK_sobek_user_Item] PRIMARY KEY CLUSTERED 
(
	[UserItemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[mySobek_User_Item] ADD  DEFAULT ((1)) FOR [ItemID]
GO

ALTER TABLE [dbo].[mySobek_User_Item]  WITH CHECK ADD  CONSTRAINT [FK_sobek_user_Item_sobek_user_Folder] FOREIGN KEY([UserFolderID])
REFERENCES [dbo].[mySobek_User_Folder] ([UserFolderID])
GO

ALTER TABLE [dbo].[mySobek_User_Item] CHECK CONSTRAINT [FK_sobek_user_Item_sobek_user_Folder]
GO

ALTER TABLE [dbo].[mySobek_User_Item]  WITH CHECK ADD  CONSTRAINT [FK_User_Item_Item] FOREIGN KEY([ItemID])
REFERENCES [dbo].[SobekCM_Item] ([ItemID])
GO

ALTER TABLE [dbo].[mySobek_User_Item] CHECK CONSTRAINT [FK_User_Item_Item]
GO


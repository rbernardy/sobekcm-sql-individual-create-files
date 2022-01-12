USE [sobektest]
GO

/****** Object:  Table [dbo].[mySobek_User_Item_Permissions]    Script Date: 1/11/2022 10:25:35 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[mySobek_User_Item_Permissions](
	[UserPermissionID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[ItemID] [int] NOT NULL,
	[isOwner] [bit] NOT NULL,
	[canView] [bit] NULL,
	[canEditMetadata] [bit] NULL,
	[canEditBehaviors] [bit] NULL,
	[canPerformQc] [bit] NULL,
	[canUploadFiles] [bit] NULL,
	[canChangeVisibility] [bit] NULL,
	[canDelete] [bit] NULL,
	[customPermissions] [varchar](max) NULL,
 CONSTRAINT [PK_mySobek_User_Item_Permissions] PRIMARY KEY CLUSTERED 
(
	[UserPermissionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[mySobek_User_Item_Permissions]  WITH CHECK ADD  CONSTRAINT [fk_mySobek_User_Item_Permissions_ItemID] FOREIGN KEY([ItemID])
REFERENCES [dbo].[SobekCM_Item] ([ItemID])
GO

ALTER TABLE [dbo].[mySobek_User_Item_Permissions] CHECK CONSTRAINT [fk_mySobek_User_Item_Permissions_ItemID]
GO

ALTER TABLE [dbo].[mySobek_User_Item_Permissions]  WITH CHECK ADD  CONSTRAINT [fk_mySobek_User_Item_Permissions_UserID] FOREIGN KEY([UserID])
REFERENCES [dbo].[mySobek_User] ([UserID])
GO

ALTER TABLE [dbo].[mySobek_User_Item_Permissions] CHECK CONSTRAINT [fk_mySobek_User_Item_Permissions_UserID]
GO


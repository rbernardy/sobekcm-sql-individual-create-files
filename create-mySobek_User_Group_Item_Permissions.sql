USE [sobektest]
GO

/****** Object:  Table [dbo].[mySobek_User_Group_Item_Permissions]    Script Date: 1/11/2022 9:56:51 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[mySobek_User_Group_Item_Permissions](
	[UserGroupPermissionID] [int] IDENTITY(1,1) NOT NULL,
	[UserGroupID] [int] NOT NULL,
	[ItemID] [int] NULL,
	[isOwner] [bit] NOT NULL,
	[canView] [bit] NULL,
	[canEditMetadata] [bit] NULL,
	[canEditBehaviors] [bit] NULL,
	[canPerformQc] [bit] NULL,
	[canUploadFiles] [bit] NULL,
	[canChangeVisibility] [bit] NULL,
	[canDelete] [bit] NULL,
	[customPermissions] [varchar](max) NULL,
	[isDefaultPermissions] [bit] NOT NULL,
 CONSTRAINT [PK_mySobek_User_Group_Item_Permissions] PRIMARY KEY CLUSTERED 
(
	[UserGroupPermissionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[mySobek_User_Group_Item_Permissions] ADD  DEFAULT ('false') FOR [isDefaultPermissions]
GO

ALTER TABLE [dbo].[mySobek_User_Group_Item_Permissions]  WITH CHECK ADD  CONSTRAINT [fk_mySobek_User_Group_Item_Permissions_ItemID] FOREIGN KEY([ItemID])
REFERENCES [dbo].[SobekCM_Item] ([ItemID])
GO

ALTER TABLE [dbo].[mySobek_User_Group_Item_Permissions] CHECK CONSTRAINT [fk_mySobek_User_Group_Item_Permissions_ItemID]
GO

ALTER TABLE [dbo].[mySobek_User_Group_Item_Permissions]  WITH CHECK ADD  CONSTRAINT [fk_mySobek_User_Group_Item_Permissions_UserGroupID] FOREIGN KEY([UserGroupID])
REFERENCES [dbo].[mySobek_User_Group] ([UserGroupID])
GO

ALTER TABLE [dbo].[mySobek_User_Group_Item_Permissions] CHECK CONSTRAINT [fk_mySobek_User_Group_Item_Permissions_UserGroupID]
GO


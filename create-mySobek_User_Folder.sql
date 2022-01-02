USE [sobekexample]
GO

/****** Object:  Table [dbo].[mySobek_User_Folder]    Script Date: 1/2/2022 1:55:12 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[mySobek_User_Folder](
	[UserFolderID] [int] IDENTITY(1,1) NOT NULL,
	[ParentFolderID] [int] NULL,
	[UserID] [int] NOT NULL,
	[FolderName] [nvarchar](255) NOT NULL,
	[isPublic] [bit] NOT NULL,
	[FolderDescription] [nvarchar](4000) NOT NULL,
 CONSTRAINT [PK_sobek_user_Folder] PRIMARY KEY CLUSTERED 
(
	[UserFolderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[mySobek_User_Folder] ADD  DEFAULT ('') FOR [FolderDescription]
GO

ALTER TABLE [dbo].[mySobek_User_Folder]  WITH CHECK ADD  CONSTRAINT [FK_sobek_user_Folder_sobek_user] FOREIGN KEY([UserID])
REFERENCES [dbo].[mySobek_User] ([UserID])
GO

ALTER TABLE [dbo].[mySobek_User_Folder] CHECK CONSTRAINT [FK_sobek_user_Folder_sobek_user]
GO

ALTER TABLE [dbo].[mySobek_User_Folder]  WITH CHECK ADD  CONSTRAINT [FK_sobek_user_Folder_sobek_user_Folder] FOREIGN KEY([ParentFolderID])
REFERENCES [dbo].[mySobek_User_Folder] ([UserFolderID])
GO

ALTER TABLE [dbo].[mySobek_User_Folder] CHECK CONSTRAINT [FK_sobek_user_Folder_sobek_user_Folder]
GO


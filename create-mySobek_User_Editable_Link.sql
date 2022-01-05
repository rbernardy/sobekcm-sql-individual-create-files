USE [sobektest]
GO

/****** Object:  Table [dbo].[mySobek_User_Group_Editable_Link]    Script Date: 1/4/2022 10:41:33 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[mySobek_User_Group_Editable_Link](
	[UserGroupID] [int] NOT NULL,
	[EditableID] [int] NOT NULL,
	[CanEditMetadata] [bit] NOT NULL,
	[CanEditBehaviors] [bit] NOT NULL,
	[CanPerformQc] [bit] NOT NULL,
	[CanUploadFiles] [bit] NOT NULL,
	[CanChangeVisibility] [bit] NOT NULL,
	[CanDelete] [bit] NOT NULL,
 CONSTRAINT [PK_sobek_user_Group_Editable_Link] PRIMARY KEY CLUSTERED 
(
	[UserGroupID] ASC,
	[EditableID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[mySobek_User_Group_Editable_Link] ADD  DEFAULT ('false') FOR [CanEditMetadata]
GO

ALTER TABLE [dbo].[mySobek_User_Group_Editable_Link] ADD  DEFAULT ('false') FOR [CanEditBehaviors]
GO

ALTER TABLE [dbo].[mySobek_User_Group_Editable_Link] ADD  DEFAULT ('false') FOR [CanPerformQc]
GO

ALTER TABLE [dbo].[mySobek_User_Group_Editable_Link] ADD  DEFAULT ('false') FOR [CanUploadFiles]
GO

ALTER TABLE [dbo].[mySobek_User_Group_Editable_Link] ADD  DEFAULT ('false') FOR [CanChangeVisibility]
GO

ALTER TABLE [dbo].[mySobek_User_Group_Editable_Link] ADD  DEFAULT ('false') FOR [CanDelete]
GO

ALTER TABLE [dbo].[mySobek_User_Group_Editable_Link]  WITH CHECK ADD  CONSTRAINT [FK_sobek_user_Group_Editable_Link_sobek_user] FOREIGN KEY([UserGroupID])
REFERENCES [dbo].[mySobek_User_Group] ([UserGroupID])
GO

ALTER TABLE [dbo].[mySobek_User_Group_Editable_Link] CHECK CONSTRAINT [FK_sobek_user_Group_Editable_Link_sobek_user]
GO

ALTER TABLE [dbo].[mySobek_User_Group_Editable_Link]  WITH CHECK ADD  CONSTRAINT [FK_sobek_user_Group_Editable_Link_UFDC_Editable_Regex] FOREIGN KEY([EditableID])
REFERENCES [dbo].[mySobek_Editable_Regex] ([EditableID])
GO

ALTER TABLE [dbo].[mySobek_User_Group_Editable_Link] CHECK CONSTRAINT [FK_sobek_user_Group_Editable_Link_UFDC_Editable_Regex]
GO


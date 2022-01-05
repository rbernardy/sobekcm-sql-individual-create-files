USE [sobekexample]
GO

/****** Object:  Table [dbo].[mySobek_User_Group]    Script Date: 1/4/2022 8:05:04 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[mySobek_User_Group](
	[UserGroupID] [int] IDENTITY(1,1) NOT NULL,
	[GroupName] [nvarchar](150) NOT NULL,
	[GroupDescription] [nvarchar](1000) NOT NULL,
	[Can_Submit_Items] [bit] NOT NULL,
	[Internal_User] [bit] NOT NULL,
	[IsSystemAdmin] [bit] NOT NULL,
	[IsPortalAdmin] [bit] NOT NULL,
	[Include_Tracking_Standard_Forms] [bit] NOT NULL,
	[autoAssignUsers] [bit] NOT NULL,
	[Can_Delete_All_Items] [bit] NOT NULL,
	[IsSobekDefault] [bit] NOT NULL,
	[IsShibbolethDefault] [bit] NOT NULL,
	[IsLdapDefault] [bit] NOT NULL,
	[IsSpecialGroup] [bit] NOT NULL,
 CONSTRAINT [PK_mySobek_User_Group] PRIMARY KEY CLUSTERED 
(
	[UserGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[mySobek_User_Group] ADD  DEFAULT ('false') FOR [Internal_User]
GO

ALTER TABLE [dbo].[mySobek_User_Group] ADD  DEFAULT ('false') FOR [IsSystemAdmin]
GO

ALTER TABLE [dbo].[mySobek_User_Group] ADD  DEFAULT ('false') FOR [IsPortalAdmin]
GO

ALTER TABLE [dbo].[mySobek_User_Group] ADD  DEFAULT ('true') FOR [Include_Tracking_Standard_Forms]
GO

ALTER TABLE [dbo].[mySobek_User_Group] ADD  DEFAULT ('false') FOR [autoAssignUsers]
GO

ALTER TABLE [dbo].[mySobek_User_Group] ADD  DEFAULT ('false') FOR [Can_Delete_All_Items]
GO

ALTER TABLE [dbo].[mySobek_User_Group] ADD  DEFAULT ('false') FOR [IsSobekDefault]
GO

ALTER TABLE [dbo].[mySobek_User_Group] ADD  DEFAULT ('false') FOR [IsShibbolethDefault]
GO

ALTER TABLE [dbo].[mySobek_User_Group] ADD  DEFAULT ('false') FOR [IsLdapDefault]
GO

ALTER TABLE [dbo].[mySobek_User_Group] ADD  DEFAULT ('false') FOR [IsSpecialGroup]
GO


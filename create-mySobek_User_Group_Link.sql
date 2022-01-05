USE [sobekexample]
GO

/****** Object:  Table [dbo].[mySobek_User_Group_Link]    Script Date: 1/4/2022 8:09:03 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[mySobek_User_Group_Link](
	[UserID] [int] NOT NULL,
	[UserGroupID] [int] NOT NULL,
	[IsGroupAdmin] [bit] NOT NULL,
 CONSTRAINT [PK_mySobek_User_Group_Link] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC,
	[UserGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[mySobek_User_Group_Link] ADD  DEFAULT ('false') FOR [IsGroupAdmin]
GO

ALTER TABLE [dbo].[mySobek_User_Group_Link]  WITH CHECK ADD  CONSTRAINT [FK_mySobek_User_Group_Link_mySobek_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[mySobek_User] ([UserID])
GO

ALTER TABLE [dbo].[mySobek_User_Group_Link] CHECK CONSTRAINT [FK_mySobek_User_Group_Link_mySobek_User]
GO

ALTER TABLE [dbo].[mySobek_User_Group_Link]  WITH CHECK ADD  CONSTRAINT [FK_mySobek_User_Group_Link_mySobek_User_Group] FOREIGN KEY([UserGroupID])
REFERENCES [dbo].[mySobek_User_Group] ([UserGroupID])
GO

ALTER TABLE [dbo].[mySobek_User_Group_Link] CHECK CONSTRAINT [FK_mySobek_User_Group_Link_mySobek_User_Group]
GO


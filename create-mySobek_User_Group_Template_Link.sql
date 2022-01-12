USE [sobektest]
GO

/****** Object:  Table [dbo].[mySobek_User_Group_Template_Link]    Script Date: 1/11/2022 10:10:18 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[mySobek_User_Group_Template_Link](
	[UserGroupID] [int] NOT NULL,
	[TemplateID] [int] NOT NULL,
 CONSTRAINT [PK_sobek_user_Group_Template_Link] PRIMARY KEY CLUSTERED 
(
	[UserGroupID] ASC,
	[TemplateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[mySobek_User_Group_Template_Link]  WITH CHECK ADD  CONSTRAINT [FK_sobek_user_Group_Template_Link_sobek_user] FOREIGN KEY([UserGroupID])
REFERENCES [dbo].[mySobek_User_Group] ([UserGroupID])
GO

ALTER TABLE [dbo].[mySobek_User_Group_Template_Link] CHECK CONSTRAINT [FK_sobek_user_Group_Template_Link_sobek_user]
GO

ALTER TABLE [dbo].[mySobek_User_Group_Template_Link]  WITH CHECK ADD  CONSTRAINT [FK_sobek_user_Group_Template_Link_UFDC_Template] FOREIGN KEY([TemplateID])
REFERENCES [dbo].[mySobek_Template] ([TemplateID])
GO

ALTER TABLE [dbo].[mySobek_User_Group_Template_Link] CHECK CONSTRAINT [FK_sobek_user_Group_Template_Link_UFDC_Template]
GO


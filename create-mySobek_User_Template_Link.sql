USE [sobekexample]
GO

/****** Object:  Table [dbo].[mySobek_User_Template_Link]    Script Date: 1/4/2022 8:38:08 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[mySobek_User_Template_Link](
	[UserID] [int] NOT NULL,
	[TemplateID] [int] NOT NULL,
	[DefaultTemplate] [bit] NOT NULL,
 CONSTRAINT [PK_sobek_user_Template_Link] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC,
	[TemplateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[mySobek_User_Template_Link]  WITH CHECK ADD  CONSTRAINT [FK_sobek_user_Template_Link_sobek_user] FOREIGN KEY([UserID])
REFERENCES [dbo].[mySobek_User] ([UserID])
GO

ALTER TABLE [dbo].[mySobek_User_Template_Link] CHECK CONSTRAINT [FK_sobek_user_Template_Link_sobek_user]
GO

ALTER TABLE [dbo].[mySobek_User_Template_Link]  WITH CHECK ADD  CONSTRAINT [FK_sobek_user_Template_Link_UFDC_Template] FOREIGN KEY([TemplateID])
REFERENCES [dbo].[mySobek_Template] ([TemplateID])
GO

ALTER TABLE [dbo].[mySobek_User_Template_Link] CHECK CONSTRAINT [FK_sobek_user_Template_Link_UFDC_Template]
GO


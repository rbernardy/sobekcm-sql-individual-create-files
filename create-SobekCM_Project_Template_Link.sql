USE [sobektest]
GO

/****** Object:  Table [dbo].[SobekCM_Project_Template_Link]    Script Date: 1/9/2022 9:49:42 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[SobekCM_Project_Template_Link](
	[ProjectID] [int] NOT NULL,
	[TemplateID] [int] NOT NULL,
 CONSTRAINT [PK_SobekCM_Project_Template_Link] PRIMARY KEY CLUSTERED 
(
	[ProjectID] ASC,
	[TemplateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[SobekCM_Project_Template_Link]  WITH CHECK ADD  CONSTRAINT [FK_Project_1] FOREIGN KEY([ProjectID])
REFERENCES [dbo].[SobekCM_Project] ([ProjectID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[SobekCM_Project_Template_Link] CHECK CONSTRAINT [FK_Project_1]
GO

ALTER TABLE [dbo].[SobekCM_Project_Template_Link]  WITH CHECK ADD  CONSTRAINT [FK_Template] FOREIGN KEY([TemplateID])
REFERENCES [dbo].[mySobek_Template] ([TemplateID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[SobekCM_Project_Template_Link] CHECK CONSTRAINT [FK_Template]
GO


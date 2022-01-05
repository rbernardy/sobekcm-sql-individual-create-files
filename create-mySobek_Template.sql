USE [sobekexample]
GO

/****** Object:  Table [dbo].[mySobek_Template]    Script Date: 1/4/2022 8:33:52 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[mySobek_Template](
	[TemplateID] [int] IDENTITY(1,1) NOT NULL,
	[TemplateName] [varchar](100) NOT NULL,
	[TemplateCode] [varchar](20) NOT NULL,
	[Description] [varchar](255) NOT NULL,
 CONSTRAINT [PK_UFDC_Template] PRIMARY KEY CLUSTERED 
(
	[TemplateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[mySobek_Template] ADD  DEFAULT ('') FOR [Description]
GO


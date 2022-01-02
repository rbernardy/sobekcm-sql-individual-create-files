USE [sobekexample]
GO

/****** Object:  Table [dbo].[SobekCM_Builder_Module]    Script Date: 1/2/2022 11:59:44 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[SobekCM_Builder_Module](
	[ModuleID] [int] IDENTITY(1,1) NOT NULL,
	[ModuleSetID] [int] NOT NULL,
	[ModuleDesc] [varchar](200) NOT NULL,
	[Assembly] [varchar](250) NULL,
	[Class] [varchar](500) NOT NULL,
	[Enabled] [bit] NOT NULL,
	[Order] [int] NOT NULL,
	[Argument1] [varchar](max) NULL,
	[Argument2] [varchar](max) NULL,
	[Argument3] [varchar](max) NULL,
 CONSTRAINT [PK_SobekCM_Builder_Module] PRIMARY KEY CLUSTERED 
(
	[ModuleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[SobekCM_Builder_Module]  WITH CHECK ADD  CONSTRAINT [FK_SobekCM_Builder_Module_SobekCM_Builder_Module_Set] FOREIGN KEY([ModuleSetID])
REFERENCES [dbo].[SobekCM_Builder_Module_Set] ([ModuleSetID])
GO

ALTER TABLE [dbo].[SobekCM_Builder_Module] CHECK CONSTRAINT [FK_SobekCM_Builder_Module_SobekCM_Builder_Module_Set]
GO


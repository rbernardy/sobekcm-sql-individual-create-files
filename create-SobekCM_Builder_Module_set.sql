USE [sobekexample]
GO

/****** Object:  Table [dbo].[SobekCM_Builder_Module_Set]    Script Date: 1/2/2022 12:28:30 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[SobekCM_Builder_Module_Set](
	[ModuleSetID] [int] IDENTITY(1,1) NOT NULL,
	[ModuleTypeID] [int] NOT NULL,
	[SetName] [varchar](50) NOT NULL,
	[SetOrder] [int] NOT NULL,
	[Enabled] [bit] NOT NULL,
 CONSTRAINT [PK_SobekCM_Builder_Module_Set] PRIMARY KEY CLUSTERED 
(
	[ModuleSetID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[SobekCM_Builder_Module_Set] ADD  DEFAULT ('true') FOR [Enabled]
GO

ALTER TABLE [dbo].[SobekCM_Builder_Module_Set]  WITH CHECK ADD  CONSTRAINT [FK_SobekCM_Builder_Module_Set_SobekCM_Builder_Module_Type] FOREIGN KEY([ModuleTypeID])
REFERENCES [dbo].[SobekCM_Builder_Module_Type] ([ModuleTypeID])
GO

ALTER TABLE [dbo].[SobekCM_Builder_Module_Set] CHECK CONSTRAINT [FK_SobekCM_Builder_Module_Set_SobekCM_Builder_Module_Type]
GO


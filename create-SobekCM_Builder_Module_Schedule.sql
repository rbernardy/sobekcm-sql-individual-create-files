USE [sobekexample]
GO

/****** Object:  Table [dbo].[SobekCM_Builder_Module_Schedule]    Script Date: 1/2/2022 12:08:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[SobekCM_Builder_Module_Schedule](
	[ModuleScheduleID] [int] IDENTITY(1,1) NOT NULL,
	[ModuleSetID] [int] NOT NULL,
	[DaysOfWeek] [varchar](7) NOT NULL,
	[Enabled] [bit] NOT NULL,
	[TimesOfDay] [varchar](100) NOT NULL,
	[Description] [varchar](250) NOT NULL,
 CONSTRAINT [PK_SobekCM_Builder_Module_Schedule] PRIMARY KEY CLUSTERED 
(
	[ModuleScheduleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[SobekCM_Builder_Module_Schedule] ADD  DEFAULT ('') FOR [Description]
GO

ALTER TABLE [dbo].[SobekCM_Builder_Module_Schedule]  WITH CHECK ADD  CONSTRAINT [FK_SobekCM_Builder_Module_Schedule_SobekCM_Builder_Module_Set] FOREIGN KEY([ModuleSetID])
REFERENCES [dbo].[SobekCM_Builder_Module_Set] ([ModuleSetID])
GO

ALTER TABLE [dbo].[SobekCM_Builder_Module_Schedule] CHECK CONSTRAINT [FK_SobekCM_Builder_Module_Schedule_SobekCM_Builder_Module_Set]
GO


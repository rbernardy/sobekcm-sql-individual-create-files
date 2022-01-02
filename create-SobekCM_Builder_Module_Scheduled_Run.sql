USE [sobekexample]
GO

/****** Object:  Table [dbo].[SobekCM_Builder_Module_Scheduled_Run]    Script Date: 1/2/2022 12:13:56 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[SobekCM_Builder_Module_Scheduled_Run](
	[ModuleSchedRunID] [int] IDENTITY(1,1) NOT NULL,
	[ModuleScheduleID] [int] NOT NULL,
	[Timestamp] [datetime] NOT NULL,
	[Outcome] [varchar](100) NOT NULL,
	[Message] [varchar](max) NULL,
 CONSTRAINT [PK_SobekCM_Builder_Module_Scheduled_Run] PRIMARY KEY CLUSTERED 
(
	[ModuleSchedRunID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[SobekCM_Builder_Module_Scheduled_Run]  WITH CHECK ADD  CONSTRAINT [FK_SobekCM_Builder_Module_Scheduled_Run_SobekCM_Builder_Module_Schedule] FOREIGN KEY([ModuleScheduleID])
REFERENCES [dbo].[SobekCM_Builder_Module_Schedule] ([ModuleScheduleID])
GO

ALTER TABLE [dbo].[SobekCM_Builder_Module_Scheduled_Run] CHECK CONSTRAINT [FK_SobekCM_Builder_Module_Scheduled_Run_SobekCM_Builder_Module_Schedule]
GO


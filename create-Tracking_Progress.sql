USE [sobektest]
GO

/****** Object:  Table [dbo].[Tracking_Progress]    Script Date: 1/5/2022 9:52:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Tracking_Progress](
	[ProgressID] [int] IDENTITY(1,1) NOT NULL,
	[ItemID] [int] NOT NULL,
	[WorkFlowID] [int] NOT NULL,
	[DateCompleted] [datetime] NULL,
	[WorkPerformedBy] [varchar](255) NULL,
	[WorkingFilePath] [varchar](255) NULL,
	[ProgressNote] [varchar](1000) NULL,
	[DateStarted] [datetime] NULL,
	[Duration] [int] NOT NULL,
	[RelatedEquipment] [varchar](255) NULL,
	[Start_Event_Number] [int] NULL,
	[End_Event_Number] [int] NULL,
	[Start_And_End_Event_Number] [int] NULL,
 CONSTRAINT [PK_Progress] PRIMARY KEY CLUSTERED 
(
	[ProgressID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Tracking_Progress] ADD  DEFAULT ((0)) FOR [Duration]
GO

ALTER TABLE [dbo].[Tracking_Progress]  WITH CHECK ADD  CONSTRAINT [FK_Progress_Item] FOREIGN KEY([ItemID])
REFERENCES [dbo].[SobekCM_Item] ([ItemID])
GO

ALTER TABLE [dbo].[Tracking_Progress] CHECK CONSTRAINT [FK_Progress_Item]
GO

ALTER TABLE [dbo].[Tracking_Progress]  WITH CHECK ADD  CONSTRAINT [FK_Progress_WorkFlow] FOREIGN KEY([WorkFlowID])
REFERENCES [dbo].[Tracking_WorkFlow] ([WorkFlowID])
GO

ALTER TABLE [dbo].[Tracking_Progress] CHECK CONSTRAINT [FK_Progress_WorkFlow]
GO


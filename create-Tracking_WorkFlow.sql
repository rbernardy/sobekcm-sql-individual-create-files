USE [sobektest]
GO

/****** Object:  Table [dbo].[Tracking_WorkFlow]    Script Date: 1/5/2022 10:15:45 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Tracking_WorkFlow](
	[WorkFlowID] [int] IDENTITY(1,1) NOT NULL,
	[WorkFlowName] [varchar](100) NOT NULL,
	[WorkFlowNotes] [varchar](1000) NULL,
	[Start_Event_Number] [int] NULL,
	[End_Event_Number] [int] NULL,
	[Start_And_End_Event_Number] [int] NULL,
	[Start_Event_Desc] [nvarchar](100) NULL,
	[End_Event_Desc] [nvarchar](100) NULL,
 CONSTRAINT [PK_WorkFlow] PRIMARY KEY CLUSTERED 
(
	[WorkFlowID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


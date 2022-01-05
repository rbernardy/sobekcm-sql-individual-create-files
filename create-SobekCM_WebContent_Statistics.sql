USE [sobekexample]
GO

/****** Object:  Table [dbo].[SobekCM_WebContent_Statistics]    Script Date: 1/4/2022 9:26:18 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[SobekCM_WebContent_Statistics](
	[Level1] [varchar](100) NOT NULL,
	[Level2] [varchar](100) NULL,
	[Level3] [varchar](100) NULL,
	[Level4] [varchar](100) NULL,
	[Level5] [varchar](100) NULL,
	[Level6] [varchar](100) NULL,
	[Level7] [varchar](100) NULL,
	[Level8] [varchar](100) NULL,
	[Year] [smallint] NOT NULL,
	[Month] [smallint] NOT NULL,
	[Hits] [int] NOT NULL,
	[Hits_Complete] [int] NOT NULL,
	[WebContentID] [int] NULL
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[SobekCM_WebContent_Statistics] ADD  DEFAULT ((0)) FOR [Hits_Complete]
GO


USE [sobekexample]
GO

/****** Object:  Table [dbo].[SobekCM_Statistics]    Script Date: 1/4/2022 9:17:31 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[SobekCM_Statistics](
	[StatisticsID] [int] IDENTITY(1,1) NOT NULL,
	[Year] [smallint] NOT NULL,
	[Month] [smallint] NOT NULL,
	[Hits] [int] NOT NULL,
	[Sessions] [int] NOT NULL,
	[Robot_Hits] [int] NOT NULL,
	[XML_Hits] [int] NOT NULL,
	[OAI_Hits] [int] NOT NULL,
	[JSON_Hits] [int] NOT NULL,
	[Aggregate_Statistics_Complete] [bit] NOT NULL,
 CONSTRAINT [PK_SobekCM_Statistics] PRIMARY KEY CLUSTERED 
(
	[StatisticsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[SobekCM_Statistics] ADD  DEFAULT ((-1)) FOR [Robot_Hits]
GO

ALTER TABLE [dbo].[SobekCM_Statistics] ADD  DEFAULT ((-1)) FOR [XML_Hits]
GO

ALTER TABLE [dbo].[SobekCM_Statistics] ADD  DEFAULT ((-1)) FOR [OAI_Hits]
GO

ALTER TABLE [dbo].[SobekCM_Statistics] ADD  DEFAULT ((-1)) FOR [JSON_Hits]
GO

ALTER TABLE [dbo].[SobekCM_Statistics] ADD  DEFAULT ('false') FOR [Aggregate_Statistics_Complete]
GO


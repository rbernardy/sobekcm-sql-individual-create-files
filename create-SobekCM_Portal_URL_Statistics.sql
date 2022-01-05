USE [sobekexample]
GO

/****** Object:  Table [dbo].[SobekCM_Portal_URL_Statistics]    Script Date: 1/4/2022 9:13:12 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[SobekCM_Portal_URL_Statistics](
	[PortalStatsID] [int] IDENTITY(1,1) NOT NULL,
	[PortalID] [int] NOT NULL,
	[Year] [smallint] NOT NULL,
	[Month] [smallint] NOT NULL,
	[Hits] [int] NOT NULL,
 CONSTRAINT [PK_SobekCM_Portal_URL_Statistics] PRIMARY KEY CLUSTERED 
(
	[PortalStatsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[SobekCM_Portal_URL_Statistics]  WITH CHECK ADD  CONSTRAINT [FK_SobekCM_Portal_URL_Statistics_SobekCM_Portal_URL] FOREIGN KEY([PortalID])
REFERENCES [dbo].[SobekCM_Portal_URL] ([PortalID])
GO

ALTER TABLE [dbo].[SobekCM_Portal_URL_Statistics] CHECK CONSTRAINT [FK_SobekCM_Portal_URL_Statistics_SobekCM_Portal_URL]
GO


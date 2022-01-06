USE [sobektest]
GO

/****** Object:  Table [dbo].[SobekCM_Database_Version]    Script Date: 1/5/2022 10:40:59 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[SobekCM_Database_Version](
	[Major_Version] [int] NULL,
	[Minor_Version] [int] NULL,
	[Release_Phase] [varchar](10) NULL
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[SobekCM_Database_Version] ADD  DEFAULT ('') FOR [Release_Phase]
GO


USE [sobekexample]
GO

/****** Object:  Table [dbo].[SobekCM_WebContent]    Script Date: 1/4/2022 9:20:34 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[SobekCM_WebContent](
	[WebContentID] [int] IDENTITY(1,1) NOT NULL,
	[Level1] [varchar](100) NOT NULL,
	[Level2] [varchar](100) NULL,
	[Level3] [varchar](100) NULL,
	[Level4] [varchar](100) NULL,
	[Level5] [varchar](100) NULL,
	[Level6] [varchar](100) NULL,
	[Level7] [varchar](100) NULL,
	[Level8] [varchar](100) NULL,
	[Deleted] [bit] NOT NULL,
	[Title] [nvarchar](255) NULL,
	[Summary] [nvarchar](1000) NULL,
	[Redirect] [nvarchar](500) NULL,
	[Locked] [bit] NOT NULL,
 CONSTRAINT [PK_SobekCM_WebContent] PRIMARY KEY CLUSTERED 
(
	[WebContentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[SobekCM_WebContent] ADD  DEFAULT ('false') FOR [Deleted]
GO

ALTER TABLE [dbo].[SobekCM_WebContent] ADD  DEFAULT ('false') FOR [Locked]
GO


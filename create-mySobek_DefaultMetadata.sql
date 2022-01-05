USE [sobekexample]
GO

/****** Object:  Table [dbo].[mySobek_DefaultMetadata]    Script Date: 1/4/2022 8:25:32 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[mySobek_DefaultMetadata](
	[DefaultMetadataID] [int] IDENTITY(1,1) NOT NULL,
	[MetadataName] [varchar](100) NOT NULL,
	[MetadataCode] [varchar](20) NOT NULL,
	[UserID] [int] NULL,
	[Description] [varchar](255) NOT NULL,
 CONSTRAINT [PK_mySobek_DefaultMetadata] PRIMARY KEY CLUSTERED 
(
	[DefaultMetadataID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[mySobek_DefaultMetadata] ADD  DEFAULT ('') FOR [Description]
GO


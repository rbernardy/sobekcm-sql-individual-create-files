USE [sobektest]
GO

/****** Object:  Table [dbo].[SobekCM_Portal_URL]    Script Date: 1/9/2022 9:29:26 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[SobekCM_Portal_URL](
	[PortalID] [int] IDENTITY(1,1) NOT NULL,
	[Base_URL] [varchar](150) NOT NULL,
	[isActive] [bit] NOT NULL,
	[isDefault] [bit] NOT NULL,
	[Abbreviation] [nvarchar](10) NOT NULL,
	[Name] [nvarchar](250) NOT NULL,
	[Base_PURL] [nvarchar](150) NULL,
 CONSTRAINT [PK_SobekCM_Portal_URL] PRIMARY KEY CLUSTERED 
(
	[PortalID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[SobekCM_Portal_URL] ADD  DEFAULT ('') FOR [Name]
GO


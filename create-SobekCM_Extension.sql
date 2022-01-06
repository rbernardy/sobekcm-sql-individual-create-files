USE [sobektest]
GO

/****** Object:  Table [dbo].[SobekCM_Extension]    Script Date: 1/5/2022 10:56:21 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[SobekCM_Extension](
	[ExtensionID] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](50) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[CurrentVersion] [varchar](50) NOT NULL,
	[IsEnabled] [bit] NOT NULL,
	[EnabledDate] [datetime] NULL,
	[LicenseKey] [nvarchar](max) NULL,
	[UpgradeUrl] [nvarchar](255) NULL,
	[LatestVersion] [varchar](50) NULL,
 CONSTRAINT [PK_SobekCM_Extension] PRIMARY KEY CLUSTERED 
(
	[ExtensionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO


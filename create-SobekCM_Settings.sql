USE [sobektest]
GO

/****** Object:  Table [dbo].[SobekCM_Settings]    Script Date: 1/6/2022 8:55:36 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[SobekCM_Settings](
	[Setting_Key] [varchar](255) NOT NULL,
	[Setting_Value] [varchar](max) NOT NULL,
	[TabPage] [nvarchar](75) NULL,
	[Heading] [nvarchar](75) NULL,
	[Hidden] [bit] NOT NULL,
	[Reserved] [smallint] NOT NULL,
	[Help] [varchar](max) NULL,
	[Options] [varchar](max) NULL,
	[SettingID] [int] IDENTITY(1,1) NOT NULL,
	[Dimensions] [varchar](100) NULL,
 CONSTRAINT [PK_SobekCM_Settings] PRIMARY KEY CLUSTERED 
(
	[Setting_Key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[SobekCM_Settings] ADD  DEFAULT ('false') FOR [Hidden]
GO

ALTER TABLE [dbo].[SobekCM_Settings] ADD  DEFAULT ((0)) FOR [Reserved]
GO


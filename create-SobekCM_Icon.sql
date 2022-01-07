USE [sobektest]
GO

/****** Object:  Table [dbo].[SobekCM_Icon]    Script Date: 1/6/2022 8:38:49 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[SobekCM_Icon](
	[IconID] [int] IDENTITY(1,1) NOT NULL,
	[Icon_Name] [varchar](255) NOT NULL,
	[Icon_URL] [varchar](255) NOT NULL,
	[Link] [varchar](255) NULL,
	[Height] [int] NOT NULL,
	[Title] [varchar](255) NULL,
 CONSTRAINT [PK_SobekCM_Icon] PRIMARY KEY CLUSTERED 
(
	[IconID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[SobekCM_Icon] ADD  CONSTRAINT [DF_UFDC_Icon_Height]  DEFAULT ((80)) FOR [Height]
GO


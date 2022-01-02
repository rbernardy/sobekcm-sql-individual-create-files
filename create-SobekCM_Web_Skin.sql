USE [sobekexample]
GO

/****** Object:  Table [dbo].[SobekCM_Web_Skin]    Script Date: 1/2/2022 1:38:14 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[SobekCM_Web_Skin](
	[WebSkinID] [int] IDENTITY(1,1) NOT NULL,
	[WebSkinCode] [varchar](20) NOT NULL,
	[OverrideHeaderFooter] [bit] NULL,
	[OverrideBanner] [bit] NULL,
	[BannerLink] [varchar](255) NULL,
	[BaseWebSkin] [varchar](20) NULL,
	[Notes] [varchar](250) NULL,
	[OldInterfaceID] [int] NULL,
	[Build_On_Launch] [bit] NOT NULL,
	[SuppressTopNavigation] [bit] NOT NULL,
 CONSTRAINT [PK_SobekCM_WebSkin] PRIMARY KEY CLUSTERED 
(
	[WebSkinID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[SobekCM_Web_Skin] ADD  DEFAULT ('false') FOR [Build_On_Launch]
GO

ALTER TABLE [dbo].[SobekCM_Web_Skin] ADD  DEFAULT ('0') FOR [SuppressTopNavigation]
GO


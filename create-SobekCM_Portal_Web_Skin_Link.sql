USE [sobekexample]
GO

/****** Object:  Table [dbo].[SobekCM_Portal_Web_Skin_Link]    Script Date: 1/2/2022 1:43:01 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[SobekCM_Portal_Web_Skin_Link](
	[PortalID] [int] NOT NULL,
	[WebSkinID] [int] NOT NULL,
	[isDefault] [bit] NOT NULL,
 CONSTRAINT [PK_SobekCM_Portal_Web_Skin_Link] PRIMARY KEY CLUSTERED 
(
	[PortalID] ASC,
	[WebSkinID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[SobekCM_Portal_Web_Skin_Link]  WITH CHECK ADD  CONSTRAINT [FK_SobekCM_Portal_Web_Skin_Link_SobekCM_Portal_URL] FOREIGN KEY([PortalID])
REFERENCES [dbo].[SobekCM_Portal_URL] ([PortalID])
GO

ALTER TABLE [dbo].[SobekCM_Portal_Web_Skin_Link] CHECK CONSTRAINT [FK_SobekCM_Portal_Web_Skin_Link_SobekCM_Portal_URL]
GO

ALTER TABLE [dbo].[SobekCM_Portal_Web_Skin_Link]  WITH CHECK ADD  CONSTRAINT [FK_SobekCM_Portal_Web_Skin_Link_SobekCM_Web_Skin] FOREIGN KEY([WebSkinID])
REFERENCES [dbo].[SobekCM_Web_Skin] ([WebSkinID])
GO

ALTER TABLE [dbo].[SobekCM_Portal_Web_Skin_Link] CHECK CONSTRAINT [FK_SobekCM_Portal_Web_Skin_Link_SobekCM_Web_Skin]
GO


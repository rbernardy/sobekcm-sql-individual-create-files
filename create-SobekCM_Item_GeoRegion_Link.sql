USE [sobekexample]
GO

/****** Object:  Table [dbo].[SobekCM_Item_GeoRegion_Link]    Script Date: 1/2/2022 1:23:31 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[SobekCM_Item_GeoRegion_Link](
	[ItemID] [int] NOT NULL,
	[RegionID] [int] NOT NULL,
 CONSTRAINT [PK_GEMS_BibGeoLink] PRIMARY KEY CLUSTERED 
(
	[ItemID] ASC,
	[RegionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[SobekCM_Item_GeoRegion_Link]  WITH CHECK ADD  CONSTRAINT [FK_UFDC_Item_GeoRegion_Link_UFDC_GeoRegion] FOREIGN KEY([RegionID])
REFERENCES [dbo].[Auth_GeoRegion] ([RegionID])
GO

ALTER TABLE [dbo].[SobekCM_Item_GeoRegion_Link] CHECK CONSTRAINT [FK_UFDC_Item_GeoRegion_Link_UFDC_GeoRegion]
GO

ALTER TABLE [dbo].[SobekCM_Item_GeoRegion_Link]  WITH CHECK ADD  CONSTRAINT [FK_UFDC_Item_GeoRegion_Link_UFDC_Item] FOREIGN KEY([ItemID])
REFERENCES [dbo].[SobekCM_Item] ([ItemID])
GO

ALTER TABLE [dbo].[SobekCM_Item_GeoRegion_Link] CHECK CONSTRAINT [FK_UFDC_Item_GeoRegion_Link_UFDC_Item]
GO


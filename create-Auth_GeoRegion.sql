USE [sobekexample]
GO

/****** Object:  Table [dbo].[Auth_GeoRegion]    Script Date: 1/2/2022 1:15:34 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Auth_GeoRegion](
	[RegionID] [int] IDENTITY(1,1) NOT NULL,
	[GeoAuthCode] [varchar](12) NOT NULL,
	[RegionName] [varchar](255) NOT NULL,
	[RegionTypeID] [int] NOT NULL,
	[RegionFIPSCode] [varchar](10) NULL,
	[ParentRegionID] [int] NULL,
 CONSTRAINT [PK_GEMS_GeoRegion] PRIMARY KEY CLUSTERED 
(
	[RegionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Auth_GeoRegion]  WITH CHECK ADD  CONSTRAINT [FK_GEMS_GeoRegion_GEMS_GeoRegionType] FOREIGN KEY([RegionTypeID])
REFERENCES [dbo].[Auth_GeoRegion_Type] ([RegionTypeID])
GO

ALTER TABLE [dbo].[Auth_GeoRegion] CHECK CONSTRAINT [FK_GEMS_GeoRegion_GEMS_GeoRegionType]
GO

ALTER TABLE [dbo].[Auth_GeoRegion]  WITH CHECK ADD  CONSTRAINT [FK_UFDC_GeoRegion_UFDC_GeoRegion] FOREIGN KEY([ParentRegionID])
REFERENCES [dbo].[Auth_GeoRegion] ([RegionID])
GO

ALTER TABLE [dbo].[Auth_GeoRegion] CHECK CONSTRAINT [FK_UFDC_GeoRegion_UFDC_GeoRegion]
GO


USE [sobekexample]
GO

/****** Object:  Table [dbo].[Auth_GeoRegion_Type]    Script Date: 1/2/2022 1:19:55 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Auth_GeoRegion_Type](
	[RegionTypeID] [int] IDENTITY(1,1) NOT NULL,
	[RegionTypeName] [varchar](50) NOT NULL,
 CONSTRAINT [PK_GEMS_GeoRegionType] PRIMARY KEY CLUSTERED 
(
	[RegionTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO


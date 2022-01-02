USE [sobekexample]
GO

/****** Object:  Table [dbo].[SobekCM_Item_Footprint]    Script Date: 1/2/2022 1:10:05 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[SobekCM_Item_Footprint](
	[ItemGeoID] [int] IDENTITY(1,1) NOT NULL,
	[ItemID] [int] NOT NULL,
	[Point_Latitude] [float] NULL,
	[Point_Longitude] [float] NULL,
	[Rect_Latitude_A] [float] NULL,
	[Rect_Longitude_A] [float] NULL,
	[Rect_Latitude_B] [float] NULL,
	[Rect_Longitude_B] [float] NULL,
	[Segment_KML] [varchar](max) NULL,
 CONSTRAINT [PK_SobekCM_Item_Footprint] PRIMARY KEY CLUSTERED 
(
	[ItemGeoID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[SobekCM_Item_Footprint]  WITH CHECK ADD  CONSTRAINT [FK_UFDC_Item_Footprint_UFDC_Item] FOREIGN KEY([ItemID])
REFERENCES [dbo].[SobekCM_Item] ([ItemID])
GO

ALTER TABLE [dbo].[SobekCM_Item_Footprint] CHECK CONSTRAINT [FK_UFDC_Item_Footprint_UFDC_Item]
GO


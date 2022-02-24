USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Save_Item_Footprint]    Script Date: 2/23/2022 9:40:01 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Procedure links an item to a region
-- Written by Mark Sullivan ( August 2007 )
CREATE PROCEDURE [dbo].[SobekCM_Save_Item_Footprint]
	@ItemID int,
	@point_latitude float,
	@point_longitude float,
	@rect_latitude_A float,
	@rect_longitude_A float,
	@rect_latitude_B float,
	@rect_longitude_B float,
	@segment_kml varchar(max)
AS
begin transaction

	insert into SobekCM_Item_Footprint( ItemID, Point_Latitude, Point_Longitude, Rect_Latitude_A, Rect_Longitude_A, Rect_Latitude_B, Rect_Longitude_B, Segment_KML )
	values ( @itemid, @point_latitude, @point_longitude, @rect_latitude_a, @rect_longitude_a, @rect_latitude_b, @rect_longitude_b, @segment_kml )

commit transaction
GO


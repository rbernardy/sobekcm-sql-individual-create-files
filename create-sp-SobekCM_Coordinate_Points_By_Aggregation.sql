USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Coordinate_Points_By_Aggregation]    Script Date: 2/6/2022 8:20:07 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Gets the list of all point coordinates for a single aggregation
CREATE PROCEDURE [dbo].[SobekCM_Coordinate_Points_By_Aggregation]
	@aggregation_code varchar(20)
AS
begin

	-- No need to perform any locks here
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	-- Return the groups/items/points
	with min_itemid_per_groupid as
	(
		-- Get the mininmum ItemID per group per coordinate point
		select GroupID, F.Point_Latitude, F.Point_Longitude, Min(I.ItemID) as MinItemID
		from SobekCM_Item I, SobekCM_Item_Aggregation_Item_Link L, SobekCM_Item_Aggregation A, SobekCM_Item_Footprint F
		where ( I.ItemID = L.ItemID  )
		  and ( L.AggregationID = A.AggregationID )
		  and ( A.Code = @aggregation_code ) 
		  and ( F.ItemID = I.ItemID )
		  and ( F.Point_Latitude is not null )
		  and ( F.Point_Longitude is not null )
		group by GroupID, F.Point_Latitude, F.Point_Longitude
	), min_item_thumbnail_per_group as
	(
	    -- Get the matching item thumbnail for the item per group per coordiante point
		select G.GroupID, G.Point_Latitude, G.Point_Longitude, I.VID + '/' + I.MainThumbnail as MinThumbnail
		from SobekCM_Item I, min_itemid_per_groupid G
		where G.MinItemID = I.ItemID
	)
	-- Return all matchint group/coordinate point, with the group thumbnail, or item thumbnail from above WITH statements
	select F.Point_Latitude, F.Point_Longitude, G.BibID, G.GroupTitle, coalesce(NULLIF(G.GroupThumbnail,''), T.MinThumbnail) as Thumbnail, G.ItemCount, G.[Type]
	from SobekCM_Item_Group G, SobekCM_Item I, SobekCM_Item_Aggregation_Item_Link L, SobekCM_Item_Footprint F, SobekCM_Item_Aggregation A, min_item_thumbnail_per_group T
	where ( G.GroupID = I.GroupID )
	  and ( I.ItemID = L.ItemID  )
	  and ( L.AggregationID = A.AggregationID )
	  and ( A.Code = @aggregation_code ) 
	  and ( F.ItemID = I.ItemID )
	  and ( F.Point_Latitude is not null )
	  and ( F.Point_Longitude is not null )
	  and ( T.GroupID = G.GroupID )
	  and ( T.Point_Latitude = F.Point_Latitude )
	  and ( T.Point_Longitude = F.Point_Longitude )
	group by I.Spatial_KML, F.Point_Latitude, F.Point_Longitude, G.BibID, G.GroupTitle, coalesce(NULLIF(G.GroupThumbnail,''), T.MinThumbnail), G.ItemCount, G.[Type]
	order by I.Spatial_KML;
end;
GO


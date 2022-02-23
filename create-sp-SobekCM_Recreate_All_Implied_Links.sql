USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Recreate_All_Implied_Links]    Script Date: 2/22/2022 8:10:21 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- This recalculates all the implied links between items and item aggregations.
-- Implied links occur when an item is explicitly linked to a child aggregation.
-- Then, implied links can be put in the database that link the item with the
-- all of the aggregation hierarchies above the item aggregation it is explicitly
-- linked to....
-- Whenever an existing hierarchy is drastically changed, this should be executed.
CREATE PROCEDURE [dbo].[SobekCM_Recreate_All_Implied_Links]
AS
begin

	-- Delete all existing implied links first
	delete from SobekCM_Item_Aggregation_Item_Link
	where impliedLink = 'true';

	-- Add back the first implied links
	insert into SobekCM_Item_Aggregation_Item_Link (ItemID, AggregationID, impliedLink )
	select distinct L.ItemID, H.ParentID, 'true'
	from SobekCM_Item_Aggregation_Item_Link L, SobekCM_Item_Aggregation_Hierarchy H, SobekCM_Item_Aggregation A
	where ( L.AggregationID = H.ChildID )
	  and ( L.AggregationID = A.AggregationID )
	  and not exists ( select * from SobekCM_Item_Aggregation_Item_Link T where T.ItemID = L.ItemID and T.AggregationID = H.ParentID );

	-- Add back the second level of implied links
	insert into SobekCM_Item_Aggregation_Item_Link (ItemID, AggregationID, impliedLink )
	select distinct L.ItemID, H.ParentID, 'true'
	from SobekCM_Item_Aggregation_Item_Link L, SobekCM_Item_Aggregation_Hierarchy H, SobekCM_Item_Aggregation A
	where ( L.AggregationID = H.ChildID )
	  and ( L.ImpliedLink = 'true' )
	  and ( L.AggregationID = A.AggregationID )
	  and not exists ( select * from SobekCM_Item_Aggregation_Item_Link T where T.ItemID = L.ItemID and T.AggregationID = H.ParentID );

	-- Add back the third level of implied links
	insert into SobekCM_Item_Aggregation_Item_Link (ItemID, AggregationID, impliedLink )
	select distinct L.ItemID, H.ParentID, 'true'
	from SobekCM_Item_Aggregation_Item_Link L, SobekCM_Item_Aggregation_Hierarchy H, SobekCM_Item_Aggregation A
	where ( L.AggregationID = H.ChildID )
	  and ( L.ImpliedLink = 'true' )
	  and ( L.AggregationID = A.AggregationID )
	  and not exists ( select * from SobekCM_Item_Aggregation_Item_Link T where T.ItemID = L.ItemID and T.AggregationID = H.ParentID );

	-- Add back the fourth level of implied links
	insert into SobekCM_Item_Aggregation_Item_Link (ItemID, AggregationID, impliedLink )
	select distinct L.ItemID, H.ParentID, 'true'
	from SobekCM_Item_Aggregation_Item_Link L, SobekCM_Item_Aggregation_Hierarchy H, SobekCM_Item_Aggregation A
	where ( L.AggregationID = H.ChildID )
	  and ( L.ImpliedLink = 'true' )
	  and ( L.AggregationID = A.AggregationID )
	  and not exists ( select * from SobekCM_Item_Aggregation_Item_Link T where T.ItemID = L.ItemID and T.AggregationID = H.ParentID );

	-- Add back the fifth level of implied links
	insert into SobekCM_Item_Aggregation_Item_Link (ItemID, AggregationID, impliedLink )
	select distinct L.ItemID, H.ParentID, 'true'
	from SobekCM_Item_Aggregation_Item_Link L, SobekCM_Item_Aggregation_Hierarchy H, SobekCM_Item_Aggregation A
	where ( L.AggregationID = H.ChildID )
	  and ( L.ImpliedLink = 'true' )
	  and ( L.AggregationID = A.AggregationID )
	  and not exists ( select * from SobekCM_Item_Aggregation_Item_Link T where T.ItemID = L.ItemID and T.AggregationID = H.ParentID );
end;
GO


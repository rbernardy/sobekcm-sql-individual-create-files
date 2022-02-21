USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Mass_Update_Item_Aggregation_Link]    Script Date: 2/20/2022 7:57:24 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Add a link to the item aggregation (and all parents) to all the items
-- within a particular item group
CREATE PROCEDURE [dbo].[SobekCM_Mass_Update_Item_Aggregation_Link]
	@groupid int,
	@code varchar(20)
AS
begin

	-- Only continue if the code exists
	if ( len( isnull( @code,'')) > 0 )
	begin
		-- Ensure this aggregation code exists
		if ( @code in ( select Code from SobekCM_Item_Aggregation ))
		begin
			-- Get the ID for this aggregation code
			declare @AggregationID int;
			select @AggregationID = AggregationID from SobekCM_Item_Aggregation where Code = @code;
			
			-- For any existing links, make sure this does not say implied, since this was explicitly connected
			update SobekCM_Item_Aggregation_Item_Link
			set impliedLink = 'false'
			where ( AggregationID = @AggregationID ) 
			  and exists ( select * from SobekCM_Item I where I.GroupID=@GroupID and I.ItemID=SobekCM_Item_Aggregation_Item_Link.ItemID );

			-- Tie this item to this primary collection, if not present
			insert into SobekCM_Item_Aggregation_Item_Link ( AggregationID, ItemID, impliedLink )
			select @AggregationID, I.ItemID, 'false' 
			from SobekCM_Item I 
			where I.GroupID = @groupid
			  and not exists ( select * from SobekCM_Item_Aggregation_Item_Link L where L.ItemID = I.ItemID and L.AggregationID = @AggregationID );
			
			-- Update the last item added date time
			update SobekCM_Item_Aggregation
			set LastItemAdded = ( select top 1 Milestone_OnlineComplete from SobekCM_Item where GroupID=@groupid and Milestone_OnlineComplete is not null order by Milestone_OnlineComplete DESC )
			where AggregationID = @AggregationID
			  and LastItemAdded < ( select top 1 Milestone_OnlineComplete from SobekCM_Item where GroupID=@groupid and Milestone_OnlineComplete is not null order by Milestone_OnlineComplete DESC )
			  and exists ( select Milestone_OnlineComplete from SobekCM_Item where GroupID=@groupid and Milestone_OnlineComplete is not null );

			-- Select parent codes
			select P.Code, P.AggregationID, Hierarchy=1
			into #TEMP_PARENTS
			from SobekCM_Item_Aggregation C, SobekCM_Item_Aggregation P, SobekCM_Item_Aggregation_Hierarchy H
			where ( C.AggregationID = H.ChildID )
			  and ( P.AggregationID = H.ParentID )
			  and ( C.Code = @code )
			  and ( H.Search_Parent_Only = 'false' );

			-- Select the grandparent codes
			insert into #TEMP_PARENTS ( Code, AggregationID, Hierarchy)
			select P.Code, P.AggregationID, 2 
			from #TEMP_PARENTS C, SobekCM_Item_Aggregation P, SobekCM_Item_Aggregation_Hierarchy H
			where ( C.AggregationID = H.ChildID )
			  and ( P.AggregationID = H.ParentID )
			  and ( H.Search_Parent_Only = 'false' );

			-- Select the grand-grandparent codes
			insert into #TEMP_PARENTS ( Code, AggregationID, Hierarchy)
			select P.Code, P.AggregationID, 3
			from #TEMP_PARENTS C, SobekCM_Item_Aggregation P, SobekCM_Item_Aggregation_Hierarchy H
			where ( C.AggregationID = H.ChildID )
			  and ( P.AggregationID = H.ParentID )
			  and ( C.Hierarchy = 2 )
			  and ( H.Search_Parent_Only = 'false' );

			-- Select the grand-grand-grandparent codes
			insert into #TEMP_PARENTS ( Code, AggregationID, Hierarchy)
			select P.Code, P.AggregationID, 4
			from #TEMP_PARENTS C, SobekCM_Item_Aggregation P, SobekCM_Item_Aggregation_Hierarchy H
			where ( C.AggregationID = H.ChildID )
			  and ( P.AggregationID = H.ParentID )
			  and ( C.Hierarchy = 3 )
			  and ( H.Search_Parent_Only = 'false' );

			-- Insert the link anywhere it does not exist
			insert into SobekCM_Item_Aggregation_Item_Link ( AggregationID, ItemID, impliedLink )
			select AggregationID, I.ItemID, 'true'
			from #TEMP_PARENTS P, SobekCM_Item I
			where I.GroupID=@groupid 
			  and not exists ( select * 
								from SobekCM_Item_Aggregation_Item_Link L
								where ( P.AggregationID = L.AggregationID )
								  and ( L.ItemID = I.ItemID ));
								  
			-- Also update the last item added date
			update SobekCM_Item_Aggregation
			set LastItemAdded = ( select top 1 Milestone_OnlineComplete from SobekCM_Item where GroupID=@groupid and Milestone_OnlineComplete is not null order by Milestone_OnlineComplete DESC )
			where exists ( select * from #TEMP_PARENTS T where T.AggregationID=SobekCM_Item_Aggregation.AggregationID )
			  and LastItemAdded < ( select top 1 Milestone_OnlineComplete from SobekCM_Item where GroupID=@groupid and Milestone_OnlineComplete is not null order by Milestone_OnlineComplete DESC )
			  and exists ( select Milestone_OnlineComplete from SobekCM_Item where GroupID=@groupid and Milestone_OnlineComplete is not null );

			-- drop the temporary table
			drop table #TEMP_PARENTS;
		end;
	end;
end;
GO


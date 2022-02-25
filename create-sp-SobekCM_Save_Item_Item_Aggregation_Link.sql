USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Save_Item_Item_Aggregation_Link]    Script Date: 2/24/2022 10:34:13 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Add a link to the item aggregation (and all parents)
CREATE PROCEDURE [dbo].[SobekCM_Save_Item_Item_Aggregation_Link]
	@itemid int,
	@code varchar(20)
AS
begin

	-- Only continue if the code exists
	if ( len( isnull( @code,'')) > 0 )
	begin
		if (( select count(*) from SobekCM_Item_Aggregation where Code=@code and Deleted='false' ) = 1 )
		begin
			-- Get the ID for this aggregation code
			declare @AggregationID int;
			select @AggregationID = AggregationID from SobekCM_Item_Aggregation where Code = @code;

			-- Make sure the link does not already exist (two collection codes match)
			if (( select count(*) from SobekCM_Item_Aggregation_Item_Link where AggregationID = @AggregationID and ItemID = @ItemID ) = 0 )
			begin
				-- Tie this item to this primary collection
				insert into SobekCM_Item_Aggregation_Item_Link ( AggregationID, ItemID, impliedLink )
				values (  @AggregationID, @ItemID, 'false' );
			end
			else
			begin
				-- Make sure this does not say implied, since this was explicitly connected
				update SobekCM_Item_Aggregation_Item_Link
				set impliedLink = 'false'
				where ( AggregationID = @AggregationID ) and ( ItemID = @ItemID );
			end;
			
			-- Update the last create date time
			update SobekCM_Item_Aggregation
			set LastItemAdded = ( select CreateDate from SobekCM_Item where ItemID=@itemid )
			where AggregationID = @AggregationID
			  and LastItemAdded < ( select CreateDate from SobekCM_Item where ItemID=@itemid );

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
			select AggregationID, @itemid, 'true'
			from #TEMP_PARENTS P
			where not exists ( select * 
								from SobekCM_Item_Aggregation_Item_Link L
								where ( P.AggregationID = L.AggregationID )
								  and ( L.ItemID = @itemID ));
								  
			-- Also update the last create date
			update SobekCM_Item_Aggregation
			set LastItemAdded = ( select CreateDate from SobekCM_Item where ItemID=@itemid )
			where exists ( select * from #TEMP_PARENTS T where T.AggregationID=SobekCM_Item_Aggregation.AggregationID )
			  and LastItemAdded < ( select CreateDate from SobekCM_Item where ItemID=@itemid );

			-- drop the temporary table
			drop table #TEMP_PARENTS;
		end;
	end;
end;
GO


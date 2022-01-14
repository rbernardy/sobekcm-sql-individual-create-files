USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[Admin_Update_All_AggregationCodes_Values]    Script Date: 1/13/2022 8:55:37 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


/****** Object:  StoredProcedure [dbo].[Admin_Update_All_AggregationCodes_Values]    Script Date: 12/20/2013 05:43:35 ******/
CREATE PROCEDURE [dbo].[Admin_Update_All_AggregationCodes_Values]
AS
begin
	declare @itemid int

	declare itemcursor cursor read_only
	for select ItemID from SobekCM_Item

	open itemcursor

	fetch next from itemcursor into @itemid

	while @@fetch_status = 0
	begin
		-- Prepare to step through each metadata value and build the full citation
		declare @singlecode nvarchar(max)

		declare @allCodes nvarchar(max)
		set @allCodes=''
			
		declare codecursor cursor read_only
		for select Code 
			from SobekCM_Item_Aggregation A, SobekCM_Item_Aggregation_Item_Link L
			where L.ItemID=@itemid and L.AggregationID=A.AggregationID and L.ImpliedLink='false' and A.Type not like 'INSTITU%'

		open codecursor

		fetch next from codecursor into @singlecode

		while @@fetch_status = 0
		begin

			set @allCodes = @allCodes + ' ' + @singlecode
			fetch next from codecursor into @singlecode

		end

		close codecursor
		deallocate codecursor

		-- Insert the newly created full citation for this item
		update SobekCM_Item 
		set AggregationCodes = @allCodes
		where ItemID=@itemid
		
	fetch next from itemcursor into @itemid
	end

	close itemcursor
	deallocate itemcursor
end
GO


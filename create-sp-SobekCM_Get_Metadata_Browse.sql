USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Get_Metadata_Browse]    Script Date: 2/16/2022 10:18:23 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Procedure allows the distinct metadata values in an aggregation to be viewed
CREATE PROCEDURE [dbo].[SobekCM_Get_Metadata_Browse]
	@aggregation_code varchar(20),
	@metadata_name varchar(100),
	@item_count_to_use_cached int
AS
begin
	-- No need to perform any locks here.  A slightly dirty read won't hurt much
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
	
	-- Get the metadata type id
	declare @metadatatypeid int;
	set @metadatatypeid = ( select ISNULL(MetadataTypeID, -1) from SobekCM_Metadata_Types where MetadataName = @metadata_name );

	-- Get the aggregation id
	declare @aggregationid int;
	set @aggregationid = ( select ISNULL(AggregationID, -1) from SobekCM_Item_Aggregation where Code=@aggregation_code );	

	print 'metadataid=' + cast(@metadatatypeid as varchar(3));
	print 'aggregationid=' + cast(@aggregationid as varchar(3));

	-- Seperate code for metadata browsing ALL ITEMS, versus by aggregation
	if (( LEN(@aggregation_code) = 0 ) or ( @aggregation_code='all' ))
	begin
		-- How many items exist?
		if ((( select COUNT(*) from SobekCM_Item where IP_Restriction_Mask >= 0 ) >= @item_count_to_use_cached ) and 
		    (( select count(*) from SobekCM_Item_Aggregation_Metadata_Link where AggregationID=@aggregationid and MetadataTypeID=@metadatatypeid ) > 0 ))
		begin
			-- Now get the distinct values from the cached table
			select L.MetadataID, MetadataValue
			from SobekCM_Item_Aggregation_Metadata_Link L, SobekCM_Metadata_Unique_Search_Table M
			where ( L.AggregationID = @aggregationid )
			  and ( L.MetadataID = M.MetadataID )
			  and ( L.MetadataTypeID = @metadatatypeid )	
			order by MetadataValue;
		end
		else
		begin
			-- Now get the distinct values by actually going through the item links, but this
			-- time do it irrespective of which aggregations items are linked to 
			select distinct(S.MetadataID), MetadataValue
			from SobekCM_Metadata_Unique_Search_Table S, SobekCM_Metadata_Unique_Link X, SobekCM_Item L
			where ( S.MetadataTypeID = @metadatatypeid )
			  and ( X.ItemID = L.ItemID )
			  and ( X.MetadataID = S.MetadataID )
			  and ( L.IP_Restriction_Mask >= 0 )
			order by MetadataValue;
		end;	
	end
	else
	begin

		-- How many items are linked to this aggregation?
		if ((( select COUNT(*) from SobekCM_Item_Aggregation_Item_Link where AggregationID = @aggregationid  ) >= @item_count_to_use_cached ) and 
		    (( select count(*) from SobekCM_Item_Aggregation_Metadata_Link where AggregationID=@aggregationid and MetadataTypeID=@metadatatypeid ) > 0 ))
		begin
			-- Now get the distinct values from the cached table
			select L.MetadataID, MetadataValue
			from SobekCM_Item_Aggregation_Metadata_Link L, SobekCM_Metadata_Unique_Search_Table M
			where ( L.AggregationID = @aggregationid )
			  and ( L.MetadataID = M.MetadataID )
			  and ( L.MetadataTypeID = @metadatatypeid )	
			order by MetadataValue;
		end
		else
		begin
			-- Now get the distinct values by actually going through the item links
			select distinct(S.MetadataID), MetadataValue
			from SobekCM_Metadata_Unique_Search_Table S, SobekCM_Metadata_Unique_Link X, SobekCM_Item_Aggregation_Item_Link L
			where ( S.MetadataTypeID = @metadatatypeid )
			  and ( X.ItemID = L.ItemID )
			  and ( X.MetadataID = S.MetadataID )
			  and ( L.AggregationID = @aggregationid )
			order by MetadataValue;
		end;
	end;
end;
GO


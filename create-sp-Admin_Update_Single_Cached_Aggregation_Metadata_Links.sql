USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[Admin_Update_Single_Cached_Aggregation_Metadata_Links]    Script Date: 1/13/2022 9:39:12 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


/****** Object:  StoredProcedure [dbo].[Admin_Update_Single_Cached_Aggregation_Metadata_Links]    Script Date: 12/20/2013 05:43:35 ******/
-- Updates the links between an aggregation and metadata, as well as the number
-- of titles and items which are present within an aggregation
CREATE PROCEDURE [dbo].[Admin_Update_Single_Cached_Aggregation_Metadata_Links]
	@code varchar(20)
AS
BEGIN 

	-- No need to perform any locks here.  This should generally be run when no
	-- other changes are occurring, and even if some small changes are occurring, 
	-- they are likely to be lost in the sea of item metadata within the library
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	-- Determine the aggregation ID for this collection
	declare @collid int;
	select @collid=( select ISNULL(AggregationID, -1) from SobekCM_Item_Aggregation where Code=@code );

	-- Delete old links
	delete from SobekCM_Item_Aggregation_Metadata_Link
	where AggregationID=@collid;
	
	-- Get the new list of metadata links to aggregations (through items-aggregations)
	select AggregationID, L.MetadataID, COUNT(*) AS Metadata_Count, MetadataTypeID 
	into #TEMP_LIST
	from SobekCM_Item_Aggregation_Item_Link A, SobekCM_Item I, SobekCM_Metadata_Unique_Link L, SobekCM_Metadata_Unique_Search_Table M
	where ( A.ItemID = I.ItemID )
	  and ( I.ItemID = L.ItemID )
	  and ( L.MetadataID = M.MetadataID )
	  and ( I.IP_Restriction_Mask >= 0 )
	  and ( A.AggregationID = @collid )
	group by AggregationID, L.MetadataID, MetadataTypeID;

	-- Insert these values into the cached links table
	insert into SobekCM_Item_Aggregation_Metadata_Link ( AggregationID, MetadataID, Metadata_Count, MetadataTypeID, OrderNum )
	select AggregationID, MetadataID, Metadata_Count, MetadataTypeID,
	ROW_NUMBER() OVER (PARTITION BY AggregationID ORDER BY Metadata_Count DESC )
	from #TEMP_LIST;
	
	-- Drop the temporary table
	drop table #TEMP_LIST;
		
	-- Now, update the number of items linked to each aggregation
	update SobekCM_Item_Aggregation
	set Current_Item_Count = ( select count(*) 
					   from SobekCM_Item_Aggregation_Item_Link L, SobekCM_Item I
					   where L.ItemID = I.ItemID 
					     and L.AggregationID=@collid
					     and I.IP_Restriction_Mask >= 0 )
	where AggregationID=@collid;
	
	-- Now, update the number of titles linked to each aggregation
	update SobekCM_Item_Aggregation
	set Current_Title_Count = ( select count(distinct(GroupID)) 
					   from SobekCM_Item_Aggregation_Item_Link L, SobekCM_Item I
					   where L.ItemID = I.ItemID 
					     and L.AggregationID=@collid
					     and I.IP_Restriction_Mask >= 0 )
	where AggregationID=@collid;

END;
GO


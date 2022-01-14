USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[Admin_Update_Cached_Aggregation_Metadata_Links]    Script Date: 1/13/2022 9:05:13 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


/****** Object:  StoredProcedure [dbo].[Admin_Update_Cached_Aggregation_Metadata_Links]    Script Date: 12/20/2013 05:43:35 ******/
CREATE PROCEDURE [dbo].[Admin_Update_Cached_Aggregation_Metadata_Links]
AS
BEGIN 

	-- No need to perform any locks here.  This should generally be run when no
	-- other changes are occurring, and even if some small changes are occurring, 
	-- they are likely to be lost in the sea of item metadata within the library
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	-- Determine the aggregation ID for ALL
	declare @allid int;
	select @allid=( select ISNULL(AggregationID, -1) from SobekCM_Item_Aggregation where Code='all' );

	-- Delete old links
	delete from SobekCM_Item_Aggregation_Metadata_Link;
	
	-- Get the new list of metadata links to aggregations (through items-aggregations)
	select AggregationID, L.MetadataID, COUNT(*) AS Metadata_Count, MetadataTypeID 
	into #TEMP_LIST
	from SobekCM_Item_Aggregation_Item_Link A, SobekCM_Item I, SobekCM_Metadata_Unique_Link L, SobekCM_Metadata_Unique_Search_Table M
	where ( A.ItemID = I.ItemID )
	  and ( I.ItemID = L.ItemID )
	  and ( L.MetadataID = M.MetadataID )
	  and ( I.IP_Restriction_Mask >= 0 )
	  and ( A.AggregationID != @allid )
	group by AggregationID, L.MetadataID, MetadataTypeID;

	-- Insert these values into the cached links table
	insert into SobekCM_Item_Aggregation_Metadata_Link ( AggregationID, MetadataID, Metadata_Count, MetadataTypeID, OrderNum )
	select AggregationID, MetadataID, Metadata_Count, MetadataTypeID,
	ROW_NUMBER() OVER (PARTITION BY AggregationID ORDER BY Metadata_Count DESC )
	from #TEMP_LIST;
	
	-- Drop the temporary table
	drop table #TEMP_LIST;
	
	-- Now get the list of ALL public items metadata for insertion
	select L.MetadataID, COUNT(*) AS Metadata_Count, MetadataTypeID 
	into #TEMP_LIST2
	from SobekCM_Item I, SobekCM_Metadata_Unique_Link L, SobekCM_Metadata_Unique_Search_Table M
	where ( I.ItemID = L.ItemID )
	  and ( L.MetadataID = M.MetadataID )
	  and ( I.IP_Restriction_Mask >= 0 )
	group by L.MetadataID, MetadataTypeID;
	
	-- Insert these values into the cached links table
	insert into SobekCM_Item_Aggregation_Metadata_Link ( AggregationID, MetadataID, Metadata_Count, MetadataTypeID, OrderNum )
	select @allid, MetadataID, Metadata_Count, MetadataTypeID,
	ROW_NUMBER() OVER (ORDER BY Metadata_Count DESC )
	from #TEMP_LIST2;
	
	-- Drop the temporary table
	drop table #TEMP_LIST2;
	
	-- Clear the item/title count
	UPDATE SobekCM_Item_Aggregation SET Current_Item_Count=0, Current_Title_Count=0;
	
	-- Now, update the number of items linked to each aggregation
	WITH Aggregation_Item_CTE AS 
		(	select AggregationID, COUNT(*) as Item_Count	
			from SobekCM_Item_Aggregation_Item_Link as L inner join
				 SobekCM_Item as I on L.ItemID = I.ItemID
			where ( I.IP_Restriction_Mask >= 0 )
			group by AggregationID )
	UPDATE SobekCM_Item_Aggregation
	SET Current_Item_Count=(select Item_Count from Aggregation_Item_CTE C where C.AggregationID=SobekCM_Item_Aggregation.AggregationID )
	where AggregationID in ( select AggregationID from Aggregation_Item_CTE );
	
	-- Now, update the number of titles linked to each aggregation
	WITH Aggregation_Title_CTE AS 
		(	select AggregationID, COUNT(distinct(GroupID)) as Title_Count	
			from SobekCM_Item_Aggregation_Item_Link as L inner join
				 SobekCM_Item as I on L.ItemID = I.ItemID
			where ( I.IP_Restriction_Mask >= 0 )
			group by AggregationID )
	UPDATE SobekCM_Item_Aggregation
	SET Current_Title_Count=(select Title_Count from Aggregation_Title_CTE C where C.AggregationID=SobekCM_Item_Aggregation.AggregationID )
	where AggregationID in ( select AggregationID from Aggregation_Title_CTE );

END;
GO


USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Get_Collection_Statistics_History]    Script Date: 2/12/2022 4:56:17 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



-- Return the usage statistical information about a single item aggregation (or collection).
-- If the code is 'ALL', then the usage stats are aggregated up for all aggregations and
-- all items within this system.
CREATE PROCEDURE [dbo].[SobekCM_Get_Collection_Statistics_History]
	@code varchar(20)
AS
BEGIN
	-- No need to perform any locks here
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
	
	-- Should this pull all the data for ALL collections?  This is a lot more work
	-- since data is not naturally aggregated up for ALL aggregations, but rather each
	-- individual aggregation.  The web application should be caching this by writing
	-- a small file, so that this is pulled only once a day or so...
	if (( len(@code) = 0 ) or ( @code = 'ALL' ))
	begin

		-- Pull all the statistical data by item
		select [Year], [Month], sum( Hits ) as Item_Hits,
			sum( JPEG_Views ) as Item_JPEG_Views, sum ( Zoomable_Views ) as Item_Zoomable_Views,
			sum ( Citation_Views ) as Item_Citation_Views, sum ( Thumbnail_Views ) as Item_Thumbnail_Views,
			sum ( Text_Search_Views ) as Item_Text_Search_Views, sum ( Flash_Views ) as Item_Flash_Views,
			sum ( Google_Map_Views) as Item_Google_Map_Views, sum( Download_Views ) as item_Download_Views,
			sum ( Static_Views) as Item_Static_Views
		into #TEMP_ITEM_STATS
		from SobekCM_Item_Statistics
		group by [Year], [Month];

		-- Pull all the statistical data by group
		select [Year], [Month], sum( Hits ) as Title_Hits
		into #TEMP_GROUP_STATS
		from SobekCM_Item_Group_Statistics
		group by [Year], [Month];

		-- Pull the collection statistical information
		select [Year], [Month], sum( Home_Page_Views ) as Home_Page_Views,
			sum( Browse_Views ) as Browse_Views, sum ( Advanced_Search_Views ) as Advanced_Search_Views,
			sum ( Search_Results_Views ) as Search_Results_Views
		into #TEMP_HIERARCHY_STATS
		from SobekCM_Item_Aggregation_Statistics
		group by [Year], [Month];

		-- Pull all the statistical overall data (could be multiple if we have two URLs)
		select [Year], [Month], sum( Hits ) as Hits, sum( [Sessions] ) as Sessions
		into #TEMP_URL_STATS
		from SobekCM_Statistics
		group by [Year], [Month];

		-- Return the data
		select T3.[Year], T3.[Month], Hits, [Sessions], [Home_Page_Views], [Browse_Views], [Advanced_Search_Views], [Search_Results_Views], [Title_Hits], [Item_Hits], Item_JPEG_Views, Item_Zoomable_Views, Item_Citation_Views, Item_Thumbnail_Views, Item_Text_Search_Views, Item_Flash_Views, Item_Google_Map_Views, Item_Download_Views, Item_Static_Views
		from #TEMP_HIERARCHY_STATS AS T3 LEFT OUTER JOIN
			 #TEMP_ITEM_STATS AS T1 ON (( T3.[Year] = T1.[Year] ) and ( T3.[Month] = T1.[Month] )) LEFT OUTER JOIN
			 #TEMP_URL_STATS AS T2 ON (( T3.[Year] = T2.[Year] ) and ( T3.[Month] = T2.[Month] )) LEFT OUTER JOIN
			 #TEMP_GROUP_STATS AS T4 ON (( T3.[Year] = T4.[Year] ) and ( T3.[Month] = T4.[Month] ))
		order by T3.[Year], T3.[Month];

		-- Drop the temporary tables
		drop table #TEMP_ITEM_STATS;
		drop table #TEMP_GROUP_STATS;
		drop table #TEMP_URL_STATS;
		drop table #TEMP_HIERARCHY_STATS;

	end
	else
	begin

		-- Since this is for a single aggregation, simply return the data from the 
		-- aggregation statistics table
		select [Year], [Month], Hits, [Sessions], [Home_Page_Views], [Browse_Views], [Advanced_Search_Views], [Search_Results_Views], [Title_Hits], [Item_Hits], Item_JPEG_Views, Item_Zoomable_Views, Item_Citation_Views, Item_Thumbnail_Views, Item_Text_Search_Views, Item_Flash_Views, Item_Google_Map_Views, Item_Download_Views, Item_Static_Views
		from SobekCM_Item_Aggregation_Statistics S, SobekCM_Item_Aggregation C
		where ( C.Code = @code )
		  and ( C.AggregationID = S.AggregationID )
		order by [Year], [Month];

	end;
END;
GO


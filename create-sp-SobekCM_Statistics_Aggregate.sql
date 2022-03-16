USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Statistics_Aggregate]    Script Date: 3/15/2022 9:00:58 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Aggregates the item and title statistics to the subcollection, collection
-- and institutional level for a given month and year
CREATE PROCEDURE [dbo].[SobekCM_Statistics_Aggregate]
	@statyear int,
	@statmonth int,
	@message varchar(1000) output
AS
begin

	-- No need to perform any locks here.  We will define a transaction later
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	-- Should only do this aggregation for each year month ONCE.
	if not exists ( select * from SobekCM_Statistics where [Year]=@statyear and [Month]=@statmonth )
	begin
		set @message='No row for this year/month is present in the SobekCM_Statistics table.  Add usage stats before trying to aggregate this month.';
		print @message;
		return;
	end;

	-- Has this been aggregated before?
	if exists ( select * from SobekCM_Statistics where Aggregate_Statistics_Complete='true' and [Year]=@statyear and [Month]=@statmonth )
	begin
		set @message='Statistics for this month have already been aggregated.  You cannot aggregate the same year/month twice without introducing errors.';
		print @message;
		return;
	end;	

	-- Get items statistics and aggregation id
	select AggregationID, Hits, JPEG_Views, Zoomable_Views, Citation_Views, Thumbnail_Views, Text_Search_Views, Flash_Views, Google_Map_Views, Download_Views, Static_Views
	into #TEMP_ITEM_AGGREGATION
	from SobekCM_Item I, SobekCM_Item_Aggregation_Item_Link L, SobekCM_Item_Statistics S
	where ( S.ItemID = I.ItemID )
	  and ( I.ItemID = L.ItemID )
	  and ( S.[Year] = @statyear )
	  and ( S.[Month] = @statmonth )
	order by AggregationID;

	-- Aggregate these statistics
	select distinct(AggregationID), sum( Hits) as Item_Hits, sum(JPEG_Views) as JPEG_Views, sum(Zoomable_Views) as Zoomable_Views, 
	  sum ( Citation_Views) as Citation_Views, sum( Thumbnail_Views ) as Thumbnail_Views, sum( Text_Search_Views) as Text_Search_Views, sum (Flash_Views) as Flash_Views,
	  sum(Google_Map_Views) as Google_Map_Views, sum(Download_Views) as Download_Views, sum(Static_Views) as Static_Views
	into #TEMP_AGGREGATION_STATS
	from #TEMP_ITEM_AGGREGATION
	Group by AggregationID;	

	-- Get group statistics and collection id
	select AggregationID, Distincter = cast(AggregationID as varchar(10)) + '_' + cast(S.GroupID as varchar(10)), S.Hits
	into #TEMP_TITLE_AGGREGATION
	from SobekCM_Item_Aggregation_Item_Link CL, SobekCM_Item I, SobekCM_Item_Group_Statistics S
	where ( I.ItemID = CL.ItemID )
	  and ( I.GroupID = S.GroupID )
	  and ( S.[Year] = @statyear )
	  and ( S.[Month] = @statmonth )
	order by Distincter;

	-- Get the distinct hits by group
	select distinct(Distincter), AggregationID, Hits
	into #TEMP_TITLE_AGGREGATION_DISTINCT
	from #TEMP_TITLE_AGGREGATION
	Group by Distincter, AggregationID, Hits;

	-- Aggregate these statistics
	select distinct(AggregationID), sum( Hits) as Title_Hits
	into #TEMP_AGGREGATION_STATS2
	from #TEMP_TITLE_AGGREGATION_DISTINCT
	Group by AggregationID;
	
	-- Now update the tables within a transaction
	begin transaction
		
		-- Add these stats to the collection list
		update SobekCM_Item_Aggregation_Statistics
		set Item_Hits = (select Item_Hits from #TEMP_AGGREGATION_STATS where #TEMP_AGGREGATION_STATS.AggregationID = SobekCM_Item_Aggregation_Statistics.AggregationID ),
			Item_JPEG_Views = (select JPEG_VIews from #TEMP_AGGREGATION_STATS where #TEMP_AGGREGATION_STATS.AggregationID = SobekCM_Item_Aggregation_Statistics.AggregationID ),
			Item_Zoomable_Views = (select Zoomable_Views from #TEMP_AGGREGATION_STATS where #TEMP_AGGREGATION_STATS.AggregationID = SobekCM_Item_Aggregation_Statistics.AggregationID ),
			Item_Citation_Views = (select Citation_Views from #TEMP_AGGREGATION_STATS where #TEMP_AGGREGATION_STATS.AggregationID = SobekCM_Item_Aggregation_Statistics.AggregationID ),
			Item_Thumbnail_Views = (select Thumbnail_Views from #TEMP_AGGREGATION_STATS where #TEMP_AGGREGATION_STATS.AggregationID = SobekCM_Item_Aggregation_Statistics.AggregationID ),
			Item_Text_Search_Views = (select Text_Search_Views from #TEMP_AGGREGATION_STATS where #TEMP_AGGREGATION_STATS.AggregationID = SobekCM_Item_Aggregation_Statistics.AggregationID ),
			Item_Flash_Views = (select Flash_Views from #TEMP_AGGREGATION_STATS where #TEMP_AGGREGATION_STATS.AggregationID = SobekCM_Item_Aggregation_Statistics.AggregationID ),
			Item_Google_Map_Views = (select Google_Map_Views from #TEMP_AGGREGATION_STATS where #TEMP_AGGREGATION_STATS.AggregationID = SobekCM_Item_Aggregation_Statistics.AggregationID ),
			Item_Download_Views = (select Download_Views from #TEMP_AGGREGATION_STATS where #TEMP_AGGREGATION_STATS.AggregationID = SobekCM_Item_Aggregation_Statistics.AggregationID ),
			Item_Static_Views = (select Static_Views from #TEMP_AGGREGATION_STATS where #TEMP_AGGREGATION_STATS.AggregationID = SobekCM_Item_Aggregation_Statistics.AggregationID )
		where [Year]=@statyear and [Month] = @statmonth;
		
		-- If there is no matching row though, insert this
		insert into SobekCM_Item_Aggregation_Statistics ( AggregationID, [Year],    [Month],     Hits, [Sessions], Home_Page_Views, Browse_Views, Advanced_Search_Views, Search_Results_Views, Title_Hits, Item_Hits, Item_JPEG_Views, Item_Zoomable_Views, Item_Citation_Views, Item_Thumbnail_Views, Item_Text_Search_Views, Item_Flash_Views, Item_Google_Map_Views, Item_Download_Views, Item_Static_Views )
		select                                            AggregationID, @statyear, @statmonth,  0,    0,          0,               0,            0,                     0,                    0,          Item_Hits, JPEG_Views,      Zoomable_Views,      Citation_Views,      Thumbnail_Views,      Text_Search_Views,      Flash_Views,      Google_Map_Views,      Download_Views,      Static_Views
		from #TEMP_AGGREGATION_STATS
		where not exists ( select * from SobekCM_Item_Aggregation_Statistics S where S.AggregationID = #TEMP_AGGREGATION_STATS.AggregationID and S.[Year] = @statyear and S.[Month] = @statmonth );

		-- Add these stats to the collection list
		update SobekCM_Item_Aggregation_Statistics
		set Title_Hits = (select Title_Hits from #TEMP_AGGREGATION_STATS2 where #TEMP_AGGREGATION_STATS2.AggregationID = SobekCM_Item_Aggregation_Statistics.AggregationID )
		where [Year]=@statyear and [Month] = @statmonth;

		-- Update the total hits at collection level
		update SobekCM_Item_Aggregation_Statistics
		set Hits = isnull( Hits + Title_Hits + Item_Hits, 0)
		where [Year] = @statyear and [Month] = @statmonth;

		-- Update the total number of hits on the items	
		UPDATE SobekCM_Item
		set Total_Hits = isnull(( select SUM(Hits) from SobekCM_Item_Statistics S where S.ItemID=SobekCM_Item.ItemID ), 0),
			Total_Sessions = isnull(( select SUM([Sessions]) from SobekCM_Item_Statistics S where S.ItemID=SobekCM_Item.ItemID ), 0);
			
		-- Update the top level that these have been aggregated
		UPDATE SobekCM_Statistics
		SET Aggregate_Statistics_Complete='true'
		where [Year]=@statyear and [Month]=@statmonth;
		
	commit transaction;

	-- Update which users are linked to items with statistics
	update mySobek_User
	set Has_Item_Stats='true'
	where exists ( select * 
				   from mySobek_User_Item_Link L, mySobek_User_Item_Link_Relationship R, SobekCM_Item_Statistics S
				   where L.UserID=mySObek_User.UserID
				     and L.RelationshipID=R.RelationshipID 
				     and R.Include_In_Results = 'true' 
				     and L.ItemID=S.ItemID
				     and S.Hits > 0 );
				   
	-- drop the temporary tables
	drop table #TEMP_ITEM_AGGREGATION;
	drop table #TEMP_AGGREGATION_STATS;
	drop table #TEMP_TITLE_AGGREGATION;
	drop table #TEMP_TITLE_AGGREGATION_DISTINCT;
	drop table #TEMP_AGGREGATION_STATS2;
end;
GO


USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Statistics_By_Date_Range]    Script Date: 3/15/2022 9:27:20 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SobekCM_Statistics_By_Date_Range]
	@year1 smallint,
	@month1 smallint,
	@year2 smallint,
	@month2 smallint
AS
BEGIN

	-- No need to perform any locks here, especially given the possible
	-- length of this search
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
	SET NOCOUNT ON;
	SET ARITHABORT ON;
	
	-- Get the id for the ALL aggregation
	declare @all_id int;
	set @all_id = coalesce(( select AggregationID from SObekCM_Item_Aggregation where Code='all'), -1);
	
	-- Build the table of the top three levels of the aggregation hierarchy for reporting
	declare @Aggregation_List TABLE
	(
	  AggregationID int,
	  Code varchar(20),
	  ChildCode varchar(20),
	  Child2Code varchar(20),
	  AllCodes varchar(20),
	  Name nvarchar(255),
	  ShortName nvarchar(100),
	  [Type] varchar(50),
	  isActive bit
	);
			
	-- Insert the list of items linked to ALL or linked to NONE (include ALL)
	insert into @Aggregation_List ( AggregationID, Code, ChildCode, Child2Code, AllCodes, Name, ShortName, [Type], isActive )
	select AggregationID, Code, '', '', Code, Name, ShortName, [Type], isActive
	from SobekCM_Item_Aggregation A
	where ( [Type] not like 'Institut%' )
	  and ( Deleted='false' )
	  and ( exists ( select * from SobekCM_Item_Aggregation_Hierarchy where ChildID=A.AggregationID and ParentID=@all_id)
	       or A.AggregationID=@all_id );
	  
	-- Insert the children under those top-level collections
	insert into @Aggregation_List ( AggregationID, Code, ChildCode, Child2Code, AllCodes, Name, ShortName, [Type], isActive )
	select A2.AggregationID, T.Code, A2.Code, '', A2.Code, A2.Name, A2.SHortName, A2.[Type], A2.isActive
	from @Aggregation_List T, SobekCM_Item_Aggregation A2, SobekCM_Item_Aggregation_Hierarchy H
	where ( A2.[Type] not like 'Institut%' )
	  and ( T.AggregationID = H.ParentID )
	  and ( A2.AggregationID = H.ChildID )
	  and ( Deleted='false' )
	  and ( T.AggregationID <> @all_id );
	  
	-- Insert the grand-children under those child collections
	insert into @Aggregation_List ( AggregationID, Code, ChildCode, Child2Code, AllCodes, Name, ShortName, [Type], isActive )
	select A2.AggregationID, T.Code, T.ChildCode, A2.Code, A2.Code, A2.Name, A2.SHortName, A2.[Type], A2.isActive
	from @Aggregation_List T, SobekCM_Item_Aggregation A2, SobekCM_Item_Aggregation_Hierarchy H
	where ( A2.[Type] not like 'Institut%' )
	  and ( T.AggregationID = H.ParentID )
	  and ( A2.AggregationID = H.ChildID )
	  and ( Deleted='false' )
	  and ( ChildCode <> '' );
	  	
	-- Build the table of all the statistcs
	declare @Aggregation_Stats TABLE
	(
	  AggregationID int,
	  Hits bigint,
	  [Sessions] bigint,
	  Home_Page_Views bigint,
	  Browse_Views bigint,
	  Search_Results_Views bigint,
	  Title_Hits bigint,
	  Item_Hits bigint,
	  Item_JPEG_Views bigint,
	  Item_Zoomable_Views bigint,
	  Item_Citation_Views bigint,
	  Item_Thumbnail_Views bigint,
	  Item_Text_Search_Views bigint,
	  Item_Flash_Views bigint,
	  Item_Google_Map_Views bigint,
	  Item_Download_Views bigint
	);

	insert into @Aggregation_Stats ( AggregationID, Hits, [Sessions], Home_Page_Views, Browse_Views, Search_Results_Views, Title_Hits, Item_Hits, Item_JPEG_Views, Item_Zoomable_Views, Item_Citation_Views, Item_Thumbnail_Views, Item_Text_Search_Views, Item_Flash_Views, Item_Google_Map_Views, Item_Download_Views )
	select S.AggregationID, sum( Hits ) as Hits, sum( [Sessions] ) as [Sessions], 
		sum( Home_Page_Views) as Home_Page_Views, sum ( Browse_Views ) as Browse_Views,
		sum ( Search_Results_Views ) as Search_Results_Views,
		sum( Title_Hits ) as Title_Hits, sum ( Item_Hits ) as Item_Hits,
		sum( Item_JPEG_Views ) as Item_JPEG_Views, sum ( Item_Zoomable_Views ) as Item_Zoomable_Views,
		sum ( Item_Citation_Views ) as Item_Citation_Views, sum ( Item_Thumbnail_Views ) as Item_Thumbnail_Views,
		sum ( Item_Text_Search_Views ) as Item_Text_Search_Views, sum ( Item_Flash_Views ) as Item_Flash_Views,
		sum ( Item_Google_Map_Views) as Item_Google_Map_Views, sum( Item_Download_Views ) as item_Download_Views
	from SobekCM_Item_Aggregation_Statistics S, @Aggregation_List L
	where ( S.AggregationID = L.AggregationID )
	  and ((( @year1 < @year2 ) and ((( [Month] >= @month1 ) and ( [Year] = @year1 ))
	  or (( [Year] > @year1 ) and ( [Year] < @year2 ))
	  or (( [Month] <= @month2 ) and ( [Year] = @year2 ))))
	  or (( @year1 = @year2 ) and ( [Year] = @year1 ) and ( [Month] >= @month1 ) and ( [Month] <= @month2 )))
	group by S.AggregationID;
	
	-- Pull all the statistical data by item, for the TOTAL ROW
	select sum( Hits ) as Item_Hits,
		sum( JPEG_Views ) as Item_JPEG_Views, sum ( Zoomable_Views ) as Item_Zoomable_Views,
		sum ( Citation_Views ) as Item_Citation_Views, sum ( Thumbnail_Views ) as Item_Thumbnail_Views,
		sum ( Text_Search_Views ) as Item_Text_Search_Views, sum ( Flash_Views ) as Item_Flash_Views,
		sum ( Google_Map_Views) as Item_Google_Map_Views, sum( Download_Views ) as item_Download_Views
	into #TEMP_ITEM_STATS
	from SobekCM_Item_Statistics
	where ((( @year1 < @year2 ) and ((( [Month] >= @month1 ) and ( [Year] = @year1 ))
	  or (( [Year] > @year1 ) and ( [Year] < @year2 ))
	  or (( [Month] <= @month2 ) and ( [Year] = @year2 ))))
	  or (( @year1 = @year2 ) and ( [Year] = @year1 ) and ( [Month] >= @month1 ) and ( [Month] <= @month2 )));

	-- Pull all the statistical data by item group, for the TOTAL ROW
	select sum( Hits ) as Title_Hits
	into #TEMP_GROUP_STATS
	from SobekCM_Item_Group_Statistics
	where ((( @year1 < @year2 ) and ((( [Month] >= @month1 ) and ( [Year] = @year1 ))
	  or (( [Year] > @year1 ) and ( [Year] < @year2 ))
	  or (( [Month] <= @month2 ) and ( [Year] = @year2 ))))
	  or (( @year1 = @year2 ) and ( [Year] = @year1 ) and ( [Month] >= @month1 ) and ( [Month] <= @month2 )));

	-- Pull all the statistical data by aggregation, for the TOTAL ROW
	select sum(Home_Page_Views) as Home_Page_Views, sum(Browse_Views) as Browse_Views,
		  sum(Search_Results_Views) as Search_Results_Views
	into #TEMP_AGGREGATION_STATS
	from SobekCM_Item_Aggregation_Statistics
	where ((( @year1 < @year2 ) and ((( [Month] >= @month1 ) and ( [Year] = @year1 ))
	  or (( [Year] > @year1 ) and ( [Year] < @year2 ))
	  or (( [Month] <= @month2 ) and ( [Year] = @year2 ))))
	  or (( @year1 = @year2 ) and ( [Year] = @year1 ) and ( [Month] >= @month1 ) and ( [Month] <= @month2 )));

	-- Pull all the statistical overall data, for the TOTAL ROW
	select sum( Hits ) as Hits, sum( [Sessions] ) as Sessions
	into #TEMP_URL_STATS
	from SobekCM_Statistics
	where ((( @year1 < @year2 ) and ((( [Month] >= @month1 ) and ( [Year] = @year1 ))
	  or (( [Year] > @year1 ) and ( [Year] < @year2 ))
	  or (( [Month] <= @month2 ) and ( [Year] = @year2 ))))
	  or (( @year1 = @year2 ) and ( [Year] = @year1 ) and ( [Month] >= @month1 ) and ( [Month] <= @month2 )));

	-- Return the list of all the aggregations stats, unioned with the TOTAL row
	select Code, ChildCode, Child2Code, AllCodes, Name, ShortName, [Type], isActive,	
		coalesce( Hits, 0 ) as Hits, coalesce( [Sessions], 0 ) as [Sessions],
		coalesce( Home_Page_Views, 0) as Home_Page_Views, coalesce ( Browse_Views, 0 ) as Browse_Views,
		coalesce ( Search_Results_Views, 0 ) as Search_Results_Views,
		coalesce( Title_Hits, 0 ) as Title_Hits, coalesce ( Item_Hits, 0 ) as Item_Hits,
		coalesce( Item_JPEG_Views, 0 ) as Item_JPEG_Views, coalesce ( Item_Zoomable_Views, 0 ) as Item_Zoomable_Views,
		coalesce ( Item_Citation_Views, 0 ) as Item_Citation_Views, coalesce ( Item_Thumbnail_Views, 0 ) as Item_Thumbnail_Views,
		coalesce ( Item_Text_Search_Views, 0 ) as Item_Text_Search_Views, coalesce ( Item_Flash_Views, 0 ) as Item_Flash_Views,
		coalesce ( Item_Google_Map_Views, 0 ) as Item_Google_Map_Views, coalesce( Item_Download_Views, 0 ) as item_Download_Views
	from @Aggregation_List AS C LEFT OUTER JOIN
	     @Aggregation_Stats AS S on ( C.AggregationID = S.AggregationID )
	union
	select 'ZZZ', '', '', 'ZZZ', 'TOTAL', 'TOTAL', 'TOTAL', 'false',
		A.Hits, A.[Sessions], C.Home_Page_Views, C.Browse_Views, C.Search_Results_Views, G.Title_Hits,
		Item_Hits, Item_JPEG_Views, Item_Zoomable_Views, Item_Citation_Views, Item_Thumbnail_Views,
		Item_Text_Search_Views, Item_Flash_Views, Item_Google_Map_Views, Item_Download_Views
	from #TEMP_ITEM_STATS I, #TEMP_GROUP_STATS G, #TEMP_URL_STATS A, #TEMP_AGGREGATION_STATS C
	order by Code, ChildCode, Child2Code;
	     
	drop table #TEMP_AGGREGATION_STATS;
	drop table #TEMP_ITEM_STATS;
	drop table #TEMP_GROUP_STATS;
	drop table #TEMP_URL_STATS;

END;
GO


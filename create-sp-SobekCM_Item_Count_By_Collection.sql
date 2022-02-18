USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Item_Count_By_Collection]    Script Date: 2/17/2022 10:32:27 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SobekCM_Item_Count_By_Collection]
	@option int
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
	  and exists ( select * from SobekCM_Item_Aggregation_Hierarchy where ChildID=A.AggregationID and ParentID=@all_id);
	  
	-- Insert the children under those top-level collections
	insert into @Aggregation_List ( AggregationID, Code, ChildCode, Child2Code, AllCodes, Name, ShortName, [Type], isActive )
	select A2.AggregationID, T.Code, A2.Code, '', A2.Code, A2.Name, A2.SHortName, A2.[Type], A2.isActive
	from @Aggregation_List T, SobekCM_Item_Aggregation A2, SobekCM_Item_Aggregation_Hierarchy H
	where ( A2.[Type] not like 'Institut%' )
	  and ( T.AggregationID = H.ParentID )
	  and ( A2.AggregationID = H.ChildID )
	  and ( Deleted='false' );
	  
	-- Insert the grand-children under those child collections
	insert into @Aggregation_List ( AggregationID, Code, ChildCode, Child2Code, AllCodes, Name, ShortName, [Type], isActive )
	select A2.AggregationID, T.Code, T.ChildCode, A2.Code, A2.Code, A2.Name, A2.SHortName, A2.[Type], A2.isActive
	from @Aggregation_List T, SobekCM_Item_Aggregation A2, SobekCM_Item_Aggregation_Hierarchy H
	where ( A2.[Type] not like 'Institut%' )
	  and ( T.AggregationID = H.ParentID )
	  and ( A2.AggregationID = H.ChildID )
	  and ( Deleted='false' )
	  and ( ChildCode <> '' );

	-- declare the values
	declare @total_item_count int;
	declare @total_title_count int;
	declare @total_page_count int;

	-- Based on the option, select differently
	if ( @option = 1 )
	begin
		  
		-- COUNT OF ALL ITEMS WITH SOME DIGITAL RESOURCES ATTACHED
		-- Get total counts
		select @total_item_count =  ( select count(*) from SobekCM_Item where Deleted = 'false' and (( FileCount > 0 ) or ( [PageCount] > 0 )));
		select @total_title_count =  ( select count(*) from SobekCM_Item_Group G where G.Deleted = 'false' and exists ( select * from SobekCM_Item I where I.GroupID = G.GroupID and I.Deleted = 'false' and (( FileCount > 0 ) or ( [PageCount] > 0 ))));
		select @total_page_count =  coalesce(( select sum( [PageCount] ) from SobekCM_Item where Deleted = 'false'  and (( FileCount > 0 ) or ( [PageCount] > 0 ))), 0 );

		-- Start to build the return set of values
		select code1 = Code, 
			   code2 = ChildCode,
			   code3 = Child2Code,
			   AllCodes,
			[Name], 
			C.isActive AS Active,
			title_count = ( select count(distinct(GroupID)) from Statistics_Item_Aggregation_Link_View2 T where T.AggregationID = C.AggregationID ),
			item_count = ( select count(distinct(ItemID)) from Statistics_Item_Aggregation_Link_View2 T where T.AggregationID = C.AggregationID ), 
			page_count = coalesce(( select sum( PageCount ) from Statistics_Item_Aggregation_Link_View2 T where T.AggregationID = C.AggregationID ), 0)
		from @Aggregation_List C
		where ( C.Code <> 'TESTCOL' ) AND ( C.Code <> 'TESTG' )
		union
		select 'ZZZ','','', 'ZZZ', 'Total Count', 'false', @total_title_count, @total_item_count, @total_page_count
		order by code, code2, code3;
	end
	else if ( @option = 2 )
	begin  

		-- COUNT OF ALL ENTERED ITEMS
		-- Get total counts
		select @total_item_count =  ( select count(*) from SobekCM_Item where Deleted = 'false');
		select @total_title_count =  ( select count(*) from SobekCM_Item_Group G where G.Deleted = 'false');
		select @total_page_count =  coalesce(( select sum( [PageCount] ) from SobekCM_Item ), 0 );

		-- Start to build the return set of values
		select code1 = Code, 
			   code2 = ChildCode,
			   code3 = Child2Code,
			   AllCodes,
			[Name], 
			C.isActive AS Active,
			title_count = ( select count(distinct(GroupID)) from Statistics_Item_Aggregation_Link_View3 T where T.AggregationID = C.AggregationID ),
			item_count = ( select count(distinct(ItemID)) from Statistics_Item_Aggregation_Link_View3 T where T.AggregationID = C.AggregationID ), 
			page_count = coalesce(( select sum( PageCount ) from Statistics_Item_Aggregation_Link_View3 T where T.AggregationID = C.AggregationID ), 0)
		from @Aggregation_List C
		where ( C.Code <> 'TESTCOL' ) AND ( C.Code <> 'TESTG' )
		union
		select 'ZZZ','','', 'ZZZ', 'Total Count', 'false', @total_title_count, @total_item_count, @total_page_count
		order by code, code2, code3;
	end
	else
	begin
			  
		-- THIS IS THE OLDER OPTION, WHERE MILESTONE_COMPLETE MUST HAVE A DATE
		-- Get total counts
		select @total_item_count =  ( select count(*) from SobekCM_Item where Deleted = 'false' and Milestone_OnlineComplete is not null );
		select @total_title_count =  ( select count(*) from SobekCM_Item_Group G where G.Deleted = 'false' and exists ( select * from SobekCM_Item I where I.GroupID = G.GroupID and I.Deleted = 'false' and Milestone_OnlineComplete is not null ));
		select @total_page_count =  coalesce(( select sum( [PageCount] ) from SobekCM_Item where Deleted = 'false'  and ( Milestone_OnlineComplete is not null )), 0 );

		-- Start to build the return set of values
		select code1 = Code, 
			   code2 = ChildCode,
			   code3 = Child2Code,
			   AllCodes,
			[Name], 
			C.isActive AS Active,
			title_count = ( select count(distinct(GroupID)) from Statistics_Item_Aggregation_Link_View T where T.AggregationID = C.AggregationID ),
			item_count = ( select count(distinct(ItemID)) from Statistics_Item_Aggregation_Link_View T where T.AggregationID = C.AggregationID ), 
			page_count = coalesce(( select sum( PageCount ) from Statistics_Item_Aggregation_Link_View T where T.AggregationID = C.AggregationID ), 0)
		from @Aggregation_List C
		where ( C.Code <> 'TESTCOL' ) AND ( C.Code <> 'TESTG' )
		union
		select 'ZZZ','','', 'ZZZ', 'Total Count', 'false', @total_title_count, @total_item_count, @total_page_count
		order by code, code2, code3;
	end;
END;
GO


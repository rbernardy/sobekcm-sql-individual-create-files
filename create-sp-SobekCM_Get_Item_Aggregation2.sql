USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Get_Item_Aggregation2]    Script Date: 2/12/2022 8:29:13 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Gets all of the information about a single item aggregation
CREATE PROCEDURE [dbo].[SobekCM_Get_Item_Aggregation2]
	@code varchar(20),
	@include_counts bit,
	@is_robot bit
AS
begin

	-- No need to perform any locks here
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	-- Create the temporary table
	create table #TEMP_CHILDREN_BUILDER (AggregationID int, Code varchar(20), ParentCode varchar(20), Name varchar(255), [Type] varchar(50), ShortName varchar(100), isActive bit, Hidden bit, HierarchyLevel int );
	
	-- Get the aggregation id
	declare @aggregationid int
	set @aggregationid = isnull((select AggregationID from SobekCM_Item_Aggregation AS C where C.Code = @code and Deleted=0), -1 );
	
	-- Return information about this aggregation
	select AggregationID, Code, [Name], isnull(ShortName,[Name]) AS ShortName, [Type], isActive, Hidden, HasNewItems,
	   ContactEmail, DefaultInterface, [Description], Map_Display, Map_Search, OAI_Flag, OAI_Metadata, DisplayOptions, LastItemAdded, 
	   Can_Browse_Items, Items_Can_Be_Described, External_Link, ThematicHeadingID
	from SobekCM_Item_Aggregation AS C 
	where C.AggregationID = @aggregationid;

	-- Drive down through the children in the item aggregation hierarchy (first level below)
	insert into #TEMP_CHILDREN_BUILDER ( AggregationID, Code, ParentCode, Name, [Type], ShortName, isActive, Hidden, HierarchyLevel )
	select C.AggregationID, C.Code, ParentCode=@code, C.[Name], C.[Type], isnull(C.ShortName,C.[Name]) AS ShortName, C.isActive, C.Hidden, -1
	from SobekCM_Item_Aggregation AS P INNER JOIN
		 SobekCM_Item_Aggregation_Hierarchy AS H ON H.ParentID = P.AggregationID INNER JOIN
		 SobekCM_Item_Aggregation AS C ON H.ChildID = C.AggregationID 
	where ( P.AggregationID = @aggregationid );
	
	-- If this is a robot, no need to go further
	if ( @is_robot = 'false' )
	begin

		-- Now, try to find any children to this ( second level below )
		insert into #TEMP_CHILDREN_BUILDER ( AggregationID, Code, ParentCode, Name, [Type], ShortName, isActive, Hidden, HierarchyLevel )
		select C.AggregationID, C.Code, P.Code, C.[Name], C.[Type], isnull(C.ShortName,C.[Name]) AS ShortName, C.isActive, C.Hidden, -2
		from #TEMP_CHILDREN_BUILDER AS P INNER JOIN
			 SobekCM_Item_Aggregation_Hierarchy AS H ON H.ParentID = P.AggregationID INNER JOIN
			 SobekCM_Item_Aggregation AS C ON H.ChildID = C.AggregationID 
		where ( HierarchyLevel = -1 );

		-- Now, try to find any children to this ( third level below )
		insert into #TEMP_CHILDREN_BUILDER ( AggregationID, Code, ParentCode, Name, [Type], ShortName, isActive, Hidden, HierarchyLevel )
		select C.AggregationID, C.Code, P.Code, C.[Name], C.[Type], isnull(C.ShortName,C.[Name]) AS ShortName, C.isActive, C.Hidden, -3
		from #TEMP_CHILDREN_BUILDER AS P INNER JOIN
			 SobekCM_Item_Aggregation_Hierarchy AS H ON H.ParentID = P.AggregationID INNER JOIN
			 SobekCM_Item_Aggregation AS C ON H.ChildID = C.AggregationID 
		where ( HierarchyLevel = -2 ); 

		-- Now, try to find any children to this ( fourth level below )
		insert into #TEMP_CHILDREN_BUILDER ( AggregationID, Code, ParentCode, Name, [Type], ShortName, isActive, Hidden, HierarchyLevel )
		select C.AggregationID, C.Code, P.Code, C.[Name], C.[Type], isnull(C.ShortName,C.[Name]) AS ShortName, C.isActive, C.Hidden, -4
		from #TEMP_CHILDREN_BUILDER AS P INNER JOIN
			 SobekCM_Item_Aggregation_Hierarchy AS H ON H.ParentID = P.AggregationID INNER JOIN
			 SobekCM_Item_Aggregation AS C ON H.ChildID = C.AggregationID 
		where ( HierarchyLevel = -3 );
	end;

	-- Return all the children
	select Code, ParentCode, [Name], [ShortName], [Type], HierarchyLevel, isActive, Hidden
	from #TEMP_CHILDREN_BUILDER
	order by HierarchyLevel, Code ASC;
	
	-- drop the temporary tables
	drop table #TEMP_CHILDREN_BUILDER;
	
	-- Return all the metadata ids for metadata types which have values (if not robot)
	if ( @is_robot = 'false' )
	begin
		select L.MetadataTypeID, T.canFacetBrowse
		from SobekCM_Item_Aggregation_Metadata_Link L, SobekCM_Metadata_Types T
		where (  L.AggregationID = @aggregationid)
		  and ( L.MetadataTypeID = T.MetadataTypeID )
		  and ( L.Metadata_Count > 0 )
		  and ( LEN(T.SobekCode) > 0 )
		group by L.MetadataTypeID, DisplayTerm, T.canFacetBrowse
		order by DisplayTerm ASC;
	end;
	
	-- Check to see if the counts should be included
	if ( @include_counts = 'true' )
	begin
		-- Return some counts as well
		select count(distinct(I.GroupID)) as Title_Count, count(*) as Item_Count, isnull(SUM([PageCount]),0) as Page_Count
		from SobekCM_Item_Aggregation_Item_Link L, SobekCM_Item I, SobekCM_Item_Aggregation A
		where ( A.Code = @code )
		  and ( A.AggregationID = L.AggregationID )
		  and ( L.ItemID = I.ItemID );
	end;
	
	-- Return all the parents (if not robot)
	if ( @is_robot = 'false' )
	begin
		select Code, [Name], [ShortName], [Type], isActive
		from SobekCM_Item_Aggregation A, SobekCM_Item_Aggregation_Hierarchy H
		where A.AggregationID = H.ParentID 
		  and H.ChildID = @aggregationid;	
	end;
end;
GO


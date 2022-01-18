USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[mySobek_Get_Public_Folder_Browse]    Script Date: 1/17/2022 9:12:38 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Get a browse of all items in a public folder
CREATE PROCEDURE [dbo].[mySobek_Get_Public_Folder_Browse]
	@folderid int,
	@pagesize int, 
	@pagenumber int,
	@include_facets bit,
	@facettype1 smallint,
	@facettype2 smallint,
	@facettype3 smallint,
	@facettype4 smallint,
	@facettype5 smallint,
	@facettype6 smallint,
	@facettype7 smallint,
	@facettype8 smallint,
	@total_items int output,
	@total_titles int output
AS
BEGIN

	-- Declare the temporary tables
	create table #TEMP_ITEMS ( ItemID int, fk_TitleID int, ItemOrder int, SortDate bigint, UserNotes nvarchar(2000))
	create table #TEMP_PAGED_ITEMS ( ItemID int, RowNumber int, UserNotes nvarchar(2000) );

	-- Make sure this is a public folder
	set @folderid = ( select ISNULL(UserFolderID, -1) from mySobek_User_Folder F where F.UserFolderID=@folderid and F.isPublic = 'true' )
	-- Determine the start and end rows
	declare @rowstart int 
	declare @rowend int 
	set @rowstart = (@pagesize * ( @pagenumber - 1 )) + 1;
	set @rowend = @rowstart + @pagesize - 1; 
	
	-- Get the list of items in the folder
	insert into #TEMP_ITEMS ( ItemID, fk_TitleID, ItemOrder, SortDate, UserNotes )
	select I.ItemID, I.GroupID, A.ItemOrder, isnull( I.SortDate,-1), ISNULL(A.UserNotes,'' )
	from mySobek_User_Item A, SobekCM_Item I
	where ( I.ItemID = A.ItemID )
	  and ( A.UserFolderID = @folderid );
	
	-- Items in a users folder always appear individually, rather than being aggregated into
	-- titles.  This is to allow individual actions to be done against them and for each 
	-- individual user notes to appear correctly
		
	-- Create saved select across items for row numbers
	with ITEMS_SELECT AS
	 (	select I.ItemID, UserNotes,
			ROW_NUMBER() OVER (order by ItemOrder ASC) as RowNumber
			from #TEMP_ITEMS I
			group by I.ItemID, ItemOrder, UserNotes )
				  
	-- Insert the correct rows into the temp item table	
	insert into #TEMP_PAGED_ITEMS ( ItemID, UserNotes, RowNumber )
	select ItemID, UserNotes, RowNumber
	from ITEMS_SELECT
	where RowNumber >= @rowstart
	  and RowNumber <= @rowend
	  
	-- Return the title information for this page
	select RowNumber as TitleID, G.BibID, G.GroupTitle, G.ALEPH_Number, G.OCLC_Number, isnull(G.GroupThumbnail,'') as GroupThumbnail, G.[Type], isnull(G.Primary_Identifier_Type,'') as Primary_Identifier_Type, isnull(G.Primary_Identifier, '') as Primary_Identifier
	from #TEMP_PAGED_ITEMS T, SobekCM_Item I, SobekCM_Item_Group G
	where ( T.ItemID = I.ItemID )
	  and ( I.GroupID = G.GroupID )
	order by RowNumber ASC
	
	-- Return the basic system required item information for this page of results
	select T.RowNumber as fk_TitleID, I.ItemID, VID, Title, IP_Restriction_Mask, coalesce(I.MainThumbnail,'') as MainThumbnail, coalesce(I.Level1_Index, -1) as Level1_Index, coalesce(I.Level1_Text,'') as Level1_Text, coalesce(I.Level2_Index, -1) as Level2_Index, coalesce(I.Level2_Text,'') as Level2_Text, coalesce(I.Level3_Index,-1) as Level3_Index, coalesce(I.Level3_Text,'') as Level3_Text, isnull(I.PubDate,'') as PubDate, I.[PageCount], coalesce(I.Link,'') as Link, coalesce( Spatial_KML, '') as Spatial_KML, coalesce(COinS_OpenURL, '') as COinS_OpenURL		
	from SobekCM_Item I, #TEMP_PAGED_ITEMS T
	where ( T.ItemID = I.ItemID )
	order by T.RowNumber, Level1_Index, Level2_Index, Level3_Index;			
	
	-- Return the aggregation-specific display values for all the items in this page of results
	select S.ItemID, S.Publication_Date, S.Creator, S.[Publisher.Display], S.Format, S.Edition, S.Material, S.Measurements, S.Style_Period, S.Technique, S.[Subjects.Display], S.Source_Institution, S.Donor, T.UserNotes as User_Notes
	from SobekCM_Metadata_Basic_Search_Table S, #TEMP_PAGED_ITEMS T 
	where S.ItemID = T.ItemID;
	  				
	-- drop the temporary paged table
	drop table #TEMP_PAGED_ITEMS	

	-- Return the total counts ( since items and titles always equal, return same number for both)
	select @total_items=COUNT(*), @total_titles=COUNT(*)
	from #TEMP_ITEMS 
	
	-- Return the facets if asked for
	if ( @include_facets = 'true' )
	begin	
		-- Build the aggregation list
		select distinct(A.Code), A.ShortName, Metadata_Count=Count(*)
		from SobekCM_Item_Aggregation A, SobekCM_Item_Aggregation_Item_Link L, SobekCM_Item I, #TEMP_ITEMS T
		where ( T.ItemID = I.ItemID )
		  and ( I.ItemID = L.ItemID )
		  and ( L.AggregationID = A.AggregationID )
		group by A.Code, A.ShortName
		order by Metadata_Count DESC, ShortName ASC	
		
		-- Return the FIRST facet
		if ( @facettype1 > 0 )
		begin
			-- Return the first 100 values
			select MetadataValue, Metadata_Count
			from  ( select top(100) T.*
					from (	select distinct(L.MetadataID), Metadata_Count = COUNT(*)
							from SobekCM_Metadata_Unique_Link L, SobekCM_Metadata_Unique_Search_Table U, #TEMP_ITEMS I
							where ( L.ItemID = I.ItemID )
							  and ( L.MetadataID = U.MetadataID )
							  and ( U.MetadataTypeID = @facettype1 )
							group by L.MetadataID ) T
					 order by Metadata_Count DESC ) F, SobekCM_Metadata_Unique_Search_Table M
			where M.MetadataID = F.MetadataID
			order by Metadata_Count DESC, MetadataValue ASC
		end
		
		-- Return the SECOND facet
		if ( @facettype2 > 0 )
		begin
			-- Return the first 100 values
			select MetadataValue, Metadata_Count
			from  ( select top(100) T.*
					from (	select distinct(L.MetadataID), Metadata_Count = COUNT(*)
							from SobekCM_Metadata_Unique_Link L, SobekCM_Metadata_Unique_Search_Table U, #TEMP_ITEMS I
							where ( L.ItemID = I.ItemID )
							  and ( L.MetadataID = U.MetadataID )
							  and ( U.MetadataTypeID = @facettype2 )
							group by L.MetadataID ) T
					 order by Metadata_Count DESC ) F, SobekCM_Metadata_Unique_Search_Table M
			where M.MetadataID = F.MetadataID
			order by Metadata_Count DESC, MetadataValue ASC
		end
		
		-- Return the THIRD facet
		if ( @facettype3 > 0 )
		begin
			-- Return the first 100 values
			select MetadataValue, Metadata_Count
			from  ( select top(100) T.*
					from (	select distinct(L.MetadataID), Metadata_Count = COUNT(*)
							from SobekCM_Metadata_Unique_Link L, SobekCM_Metadata_Unique_Search_Table U, #TEMP_ITEMS I
							where ( L.ItemID = I.ItemID )
							  and ( L.MetadataID = U.MetadataID )
							  and ( U.MetadataTypeID = @facettype3 )
							group by L.MetadataID ) T
					 order by Metadata_Count DESC ) F, SobekCM_Metadata_Unique_Search_Table M
			where M.MetadataID = F.MetadataID
			order by Metadata_Count DESC, MetadataValue ASC
		end		
		
		-- Return the FOURTH facet
		if ( @facettype4 > 0 )
		begin
			-- Return the first 100 values
			select MetadataValue, Metadata_Count
			from  ( select top(100) T.*
					from (	select distinct(L.MetadataID), Metadata_Count = COUNT(*)
							from SobekCM_Metadata_Unique_Link L, SobekCM_Metadata_Unique_Search_Table U, #TEMP_ITEMS I
							where ( L.ItemID = I.ItemID )
							  and ( L.MetadataID = U.MetadataID )
							  and ( U.MetadataTypeID = @facettype4 )
							group by L.MetadataID ) T
					 order by Metadata_Count DESC ) F, SobekCM_Metadata_Unique_Search_Table M
			where M.MetadataID = F.MetadataID
			order by Metadata_Count DESC, MetadataValue ASC
		end
		
		-- Return the FIFTH facet
		if ( @facettype5 > 0 )
		begin
			-- Return the first 100 values
			select MetadataValue, Metadata_Count
			from  ( select top(100) T.*
					from (	select distinct(L.MetadataID), Metadata_Count = COUNT(*)
							from SobekCM_Metadata_Unique_Link L, SobekCM_Metadata_Unique_Search_Table U, #TEMP_ITEMS I
							where ( L.ItemID = I.ItemID )
							  and ( L.MetadataID = U.MetadataID )
							  and ( U.MetadataTypeID = @facettype5 )
							group by L.MetadataID ) T
					 order by Metadata_Count DESC ) F, SobekCM_Metadata_Unique_Search_Table M
			where M.MetadataID = F.MetadataID
			order by Metadata_Count DESC, MetadataValue ASC
		end
		
		-- Return the SIXTH facet
		if ( @facettype6 > 0 )
		begin
			-- Return the first 100 values
			select MetadataValue, Metadata_Count
			from  ( select top(100) T.*
					from (	select distinct(L.MetadataID), Metadata_Count = COUNT(*)
							from SobekCM_Metadata_Unique_Link L, SobekCM_Metadata_Unique_Search_Table U, #TEMP_ITEMS I
							where ( L.ItemID = I.ItemID )
							  and ( L.MetadataID = U.MetadataID )
							  and ( U.MetadataTypeID = @facettype6 )
							group by L.MetadataID ) T
					 order by Metadata_Count DESC ) F, SobekCM_Metadata_Unique_Search_Table M
			where M.MetadataID = F.MetadataID
			order by Metadata_Count DESC, MetadataValue ASC
		end
		
		-- Return the SEVENTH facet
		if ( @facettype7 > 0 )
		begin
			-- Return the first 100 values
			select MetadataValue, Metadata_Count
			from  ( select top(100) T.*
					from (	select distinct(L.MetadataID), Metadata_Count = COUNT(*)
							from SobekCM_Metadata_Unique_Link L, SobekCM_Metadata_Unique_Search_Table U, #TEMP_ITEMS I
							where ( L.ItemID = I.ItemID )
							  and ( L.MetadataID = U.MetadataID )
							  and ( U.MetadataTypeID = @facettype7 )
							group by L.MetadataID ) T
					 order by Metadata_Count DESC ) F, SobekCM_Metadata_Unique_Search_Table M
			where M.MetadataID = F.MetadataID
			order by Metadata_Count DESC, MetadataValue ASC
		end
		
		-- Return the EIGHTH facet
		if ( @facettype8 > 0 )
		begin
			-- Return the first 100 values
			select MetadataValue, Metadata_Count
			from  ( select top(100) T.*
					from (	select distinct(L.MetadataID), Metadata_Count = COUNT(*)
							from SobekCM_Metadata_Unique_Link L, SobekCM_Metadata_Unique_Search_Table U, #TEMP_ITEMS I
							where ( L.ItemID = I.ItemID )
							  and ( L.MetadataID = U.MetadataID )
							  and ( U.MetadataTypeID = @facettype8 )
							group by L.MetadataID ) T
					 order by Metadata_Count DESC ) F, SobekCM_Metadata_Unique_Search_Table M
			where M.MetadataID = F.MetadataID
			order by Metadata_Count DESC, MetadataValue ASC
		end
	end
	
	-- drop the temporary tables
	drop table #TEMP_ITEMS
	
END
GO


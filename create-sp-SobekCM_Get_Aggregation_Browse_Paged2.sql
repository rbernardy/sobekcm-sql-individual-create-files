USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Get_Aggregation_Browse_Paged2]    Script Date: 2/9/2022 9:32:08 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Return a single browse for a collection or group
-- Written by Mark Sullivan ( December 2006 )
CREATE PROCEDURE [dbo].[SobekCM_Get_Aggregation_Browse_Paged2]
	@code varchar(20),
	@date varchar(10),
	@include_private bit,
	@pagesize int, 
	@pagenumber int,
	@sort int,	
	@minpagelookahead int,
	@maxpagelookahead int,
	@lookahead_factor float,
	@include_facets bit,
	@facettype1 smallint,
	@facettype2 smallint,
	@facettype3 smallint,
	@facettype4 smallint,
	@facettype5 smallint,
	@facettype6 smallint,
	@facettype7 smallint,
	@facettype8 smallint,
	@item_count_to_use_cached int,
	@total_items int output,
	@total_titles int output
AS
begin

	-- No need to perform any locks here, especially given the possible
	-- length of this search
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
	SET NOCOUNT ON;
		
	-- Determine the start and end rows
	declare @rowstart int;
	declare @rowend int; 
	set @rowstart = (@pagesize * ( @pagenumber - 1 )) + 1;
	set @rowend = @rowstart + @pagesize - 1; 
	
	-- Ensure there is a date value
	select @date=ISNULL(@date,'1/1/1900');

	-- Set value for filtering privates
	declare @lower_mask int;
	set @lower_mask = 0;
	if ( @include_private = 'true' )
	begin
		set @lower_mask = -256;
	end;

	-- Determine the aggregationid
	declare @aggregationid int;
	set @aggregationid = ( select ISNULL(AggregationID,-1) from SobekCM_Item_Aggregation where Code=@code );
	
	-- Get the sql which will be used to return the aggregation-specific display values for all the items in this page of results
	declare @item_display_sql nvarchar(max);
	if ( @aggregationid < 0 )
	begin
		set @item_display_sql = 'select S.ItemID, S.Publication_Date, S.Creator, S.[Publisher.Display], S.Format, S.Edition, S.Material, S.Measurements, S.Style_Period, S.Technique, S.[Subjects.Display], S.Source_Institution, S.Donor from SobekCM_Metadata_Basic_Search_Table S, @itemtable T where S.ItemID = T.ItemID order by T.RowNumber;';
	end
	else
	begin
		select @item_display_sql=coalesce(Browse_Results_Display_SQL, 'select S.ItemID, S.Publication_Date, S.Creator, S.[Publisher.Display], S.Format, S.Edition, S.Material, S.Measurements, S.Style_Period, S.Technique, S.[Subjects.Display], S.Source_Institution, S.Donor from SobekCM_Metadata_Basic_Search_Table S, @itemtable T where S.ItemID = T.ItemID order by T.RowNumber;')
		from SobekCM_Item_Aggregation
		where AggregationID=@aggregationid;
	end;
	
	-- Create the temporary item table variable for paging purposes
	declare @TEMP_PAGED_ITEMS TempPagedItemsTableType;

	-- There are essentially two major paths of execution, depending on whether this should
	-- be grouped as items within the page requested titles ( sorting by title or the standard 
	-- create date sort which still lumps them this way ) or whether each item should be
	-- returned by itself, such as sorting by individual publication dates, etc..	
	if ( @sort < 10 )
	begin	
		-- Create temporary title table variale
		declare @TEMP_TITLES table ( TitleID int, BibID varchar(10), RowNumber int );		
		
		-- Return the total counts, if requested
		select @total_items=COUNT(distinct I.ItemID), @total_titles=COUNT(distinct I.GroupID)
		from SobekCM_Item I, SobekCM_Item_Aggregation_Item_Link CL
		where ( CL.ItemID = I.ItemID )
		  and ( CL.AggregationID = @aggregationid )
		  and ( I.IP_Restriction_Mask >= @lower_mask )
		  and ( I.CreateDate >= @date )
		  and ( I.Dark = 'false' );
		  
		-- Now, calculate the actual ending row, based on the ration, page information,
		-- and the lookahead factor		
		-- Compute equation to determine possible page value ( max - log(factor, (items/title)/2))
		if (( @total_items > 0 ) and ( @total_titles > 0 ))
		begin
			declare @computed_value int;
			select @computed_value = (@maxpagelookahead - CEILING( LOG10( ((cast(@total_items as float)) / (cast(@total_titles as float)))/@lookahead_factor)));
			
			-- Compute the minimum value.  This cannot be less than @minpagelookahead.
			declare @floored_value int;
			select @floored_value = 0.5 * ((@computed_value + @minpagelookahead) + ABS(@computed_value - @minpagelookahead));
			
			-- Compute the maximum value.  This cannot be more than @maxpagelookahead.
			declare @actual_pages int;
			select @actual_pages = 0.5 * ((@floored_value + @maxpagelookahead) - ABS(@floored_value - @maxpagelookahead));

			-- Set the final row again then
			set @rowend = @rowstart + ( @pagesize * @actual_pages ) - 1;  
		end;	

		-- Create saved select across titles for row numbers
		with TITLES_SELECT AS
		 (	select G.GroupID, G.BibID, 
				ROW_NUMBER() OVER (order by case when @sort=1 THEN G.SortTitle end,
											case when @sort=0 THEN Max(I.CreateDate) end DESC,
											case when @sort=2 THEN BibID end ASC,
											case when @sort=3 THEN BibID end DESC) as RowNumber
				from SobekCM_Item I, SobekCM_Item_Aggregation_Item_Link CL, SobekCM_Item_Group G
				where ( CL.ItemID = I.ItemID )
				  and ( CL.AggregationID = @aggregationid )
				  and ( I.GroupID = G.GroupID )
				  and ( I.IP_Restriction_Mask >= @lower_mask )
				  and ( I.CreateDate >= @date )
				  and ( I.Dark = 'false' )
				group by G.GroupID, G.BibID, G.SortTitle )
				  
		-- Insert the correct rows into the temp title table	
		insert into @TEMP_TITLES ( TitleID, BibID, RowNumber )
		select GroupID, BibID, RowNumber
		from TITLES_SELECT
		where RowNumber >= @rowstart
		  and RowNumber <= @rowend;
		
		-- Return the title information for this page
		select RowNumber as TitleID, T.BibID, G.GroupTitle, G.ALEPH_Number as OPAC_Number, G.OCLC_Number, isnull(G.GroupThumbnail,'') as GroupThumbnail, G.[Type], isnull(G.Primary_Identifier_Type,'') as Primary_Identifier_Type, isnull(G.Primary_Identifier, '') as Primary_Identifier
		from @TEMP_TITLES T, SobekCM_Item_Group G
		where ( T.TitleID = G.GroupID )
		order by RowNumber ASC;
		
		-- Get the item id's for the items related to these titles
		insert into @TEMP_PAGED_ITEMS
		select I.ItemID, RowNumber
		from @TEMP_TITLES T, SobekCM_Item I, SobekCM_Item_Aggregation_Item_Link CL
		where ( T.TitleID = I.GroupID )
		  and ( CL.ItemID = I.ItemID )
		  and ( CL.AggregationID = @aggregationid )
		  and ( I.IP_Restriction_Mask >= @lower_mask )
		  and ( I.CreateDate >= @date )		
		  and ( I.Dark = 'false' );	  
		
		-- Return the basic system required item information for this page of results
		select T.RowNumber as fk_TitleID, I.ItemID, VID, Title, IP_Restriction_Mask, coalesce(I.MainThumbnail,'') as MainThumbnail, coalesce(I.Level1_Index, -1) as Level1_Index, coalesce(I.Level1_Text,'') as Level1_Text, coalesce(I.Level2_Index, -1) as Level2_Index, coalesce(I.Level2_Text,'') as Level2_Text, coalesce(I.Level3_Index,-1) as Level3_Index, coalesce(I.Level3_Text,'') as Level3_Text, isnull(I.PubDate,'') as PubDate, I.[PageCount], coalesce(I.Link,'') as Link, coalesce( Spatial_KML, '') as Spatial_KML, coalesce(COinS_OpenURL, '') as COinS_OpenURL		
		from SobekCM_Item I, @TEMP_PAGED_ITEMS T
		where ( T.ItemID = I.ItemID )
		order by T.RowNumber, Level1_Index, Level2_Index, Level3_Index;			
							
		-- Return the aggregation-specific display values for all the items in this page of results
		execute sp_Executesql @item_display_sql, N' @itemtable TempPagedItemsTableType READONLY', @TEMP_PAGED_ITEMS; 
	end
	else
	begin
				
		-- Return the total counts, if requested
		select @total_items=COUNT(distinct I.ItemID)
		from SobekCM_Item I, SobekCM_Item_Aggregation_Item_Link CL
		where ( CL.ItemID = I.ItemID )
		  and ( CL.AggregationID = @aggregationid )
		  and ( I.IP_Restriction_Mask >= @lower_mask )
		  and ( I.CreateDate >= @date )
		  and ( I.Dark = 'false' );
		  
		-- Since these sorts make each item paired with a single title row,
		-- number of items and titles are equal
		set @total_titles = @total_items;
		
		-- In addition, always return the max lookahead pages
		set @rowend = @rowstart + ( @pagesize * @maxpagelookahead ) - 1; 
		
		if ( @sort < 12 )
		begin		
			-- Create saved select across items for row numbers
			with ITEMS_SELECT AS
			 (	select I.ItemID, 
					ROW_NUMBER() OVER (order by case when @sort=10 THEN isnull(SortDate,9223372036854775807)  end ASC,
												case when @sort=11 THEN isnull(SortDate,-1) end DESC ) as RowNumber
					from SobekCM_Item I, SobekCM_Item_Aggregation_Item_Link CL
					where ( CL.ItemID = I.ItemID )
					  and ( CL.AggregationID = @aggregationid )
					  and ( I.IP_Restriction_Mask >= @lower_mask )
					  and ( I.CreateDate >= @date )
					  and ( I.Dark = 'false' )
					group by I.ItemID, SortDate )
						  
			-- Insert the correct rows into the temp item table	
			insert into @TEMP_PAGED_ITEMS ( ItemID, RowNumber )
			select ItemID, RowNumber
			from ITEMS_SELECT
			where RowNumber >= @rowstart
			  and RowNumber <= @rowend;
		end
		else
		begin
			-- Create saved select across items for row numbers
			with ITEMS_SELECT AS
			 (	select I.ItemID, 
					ROW_NUMBER() OVER (order by case when @sort=12 THEN I.CreateDate end DESC ) as RowNumber
					from SobekCM_Item I, SobekCM_Item_Aggregation_Item_Link CL
					where ( CL.ItemID = I.ItemID )
					  and ( CL.AggregationID = @aggregationid )
					  and ( I.IP_Restriction_Mask >= @lower_mask )
					  and ( I.CreateDate >= @date )
					  and ( I.Dark = 'false' )
					group by I.ItemID, I.CreateDate )
						  
			-- Insert the correct rows into the temp item table	
			insert into @TEMP_PAGED_ITEMS ( ItemID, RowNumber )
			select ItemID, RowNumber
			from ITEMS_SELECT
			where RowNumber >= @rowstart
			  and RowNumber <= @rowend;
		end		
		  
		-- Return the title information for this page
		select RowNumber as TitleID, G.BibID, G.GroupTitle, G.ALEPH_Number as OPAC_Number, G.OCLC_Number, isnull(G.GroupThumbnail,'') as GroupThumbnail, G.[Type], isnull(G.Primary_Identifier_Type,'') as Primary_Identifier_Type, isnull(G.Primary_Identifier, '') as Primary_Identifier
		from @TEMP_PAGED_ITEMS T, SobekCM_Item I, SobekCM_Item_Group G
		where ( T.ItemID = I.ItemID )
		  and ( I.GroupID = G.GroupID )
		order by RowNumber ASC;
		
		-- Return the basic system required item information for this page of results
		select T.RowNumber as fk_TitleID, I.ItemID, VID, Title, IP_Restriction_Mask, coalesce(I.MainThumbnail,'') as MainThumbnail, coalesce(I.Level1_Index, -1) as Level1_Index, coalesce(I.Level1_Text,'') as Level1_Text, coalesce(I.Level2_Index, -1) as Level2_Index, coalesce(I.Level2_Text,'') as Level2_Text, coalesce(I.Level3_Index,-1) as Level3_Index, coalesce(I.Level3_Text,'') as Level3_Text, isnull(I.PubDate,'') as PubDate, I.[PageCount], coalesce(I.Link,'') as Link, coalesce( Spatial_KML, '') as Spatial_KML, coalesce(COinS_OpenURL, '') as COinS_OpenURL		
		from SobekCM_Item I, @TEMP_PAGED_ITEMS T
		where ( T.ItemID = I.ItemID )
		order by T.RowNumber, Level1_Index, Level2_Index, Level3_Index;			
			
		-- Return the aggregation-specific display values for all the items in this page of results
		execute sp_Executesql @item_display_sql, N' @itemtable TempPagedItemsTableType READONLY', @TEMP_PAGED_ITEMS; 
	end
	
	-- Return the facets if asked for
	if ( @include_facets = 'true' )
	begin			
	
		-- Since this is an aggregation browse, can possibly use the cached
		-- metadata links to the aggregation for the facets.  Only do if this is
		-- over the value provided though
		if (( @total_items >= @item_count_to_use_cached ) and ( @date <= '1/1/1990' ))
		begin
				
			-- Return the FIRST facet
			if ( @facettype1 > 0 )
			begin
				-- Return the first 100 values
				select top(100) MetadataValue, Metadata_Count
				from SobekCM_Item_Aggregation_Metadata_Link L, SobekCM_Metadata_Unique_Search_Table M
				where ( L.AggregationID = @aggregationid ) and ( L.MetadataID = M.MetadataID ) and ( L.MetadataTypeID = @facettype1 ) and ( L.OrderNum <= 100 )
				order by Metadata_Count DESC, MetadataValue ASC;
			end;
			
			-- Return the SECOND facet
			if ( @facettype2 > 0 )
			begin
				-- Return the first 100 values
				select top(100) MetadataValue, Metadata_Count
				from SobekCM_Item_Aggregation_Metadata_Link L, SobekCM_Metadata_Unique_Search_Table M
				where ( L.AggregationID = @aggregationid ) and ( L.MetadataID = M.MetadataID ) and ( L.MetadataTypeID = @facettype2 ) and ( L.OrderNum <= 100 )
				order by Metadata_Count DESC, MetadataValue ASC;
			end;
			
			-- Return the THIRD facet
			if ( @facettype3 > 0 )
			begin
				-- Return the first 100 values
				select top(100) MetadataValue, Metadata_Count
				from SobekCM_Item_Aggregation_Metadata_Link L, SobekCM_Metadata_Unique_Search_Table M
				where ( L.AggregationID = @aggregationid ) and ( L.MetadataID = M.MetadataID ) and ( L.MetadataTypeID = @facettype3 ) and ( L.OrderNum <= 100 )
				order by Metadata_Count DESC, MetadataValue ASC;
			end;	
			
			-- Return the FOURTH facet
			if ( @facettype4 > 0 )
			begin
				-- Return the first 100 values
				select top(100) MetadataValue, Metadata_Count
				from SobekCM_Item_Aggregation_Metadata_Link L, SobekCM_Metadata_Unique_Search_Table M
				where ( L.AggregationID = @aggregationid ) and ( L.MetadataID = M.MetadataID ) and ( L.MetadataTypeID = @facettype4 ) and ( L.OrderNum <= 100 )
				order by Metadata_Count DESC, MetadataValue ASC;
			end;
			
			-- Return the FIFTH facet
			if ( @facettype5 > 0 )
			begin
				-- Return the first 100 values
				select top(100) MetadataValue, Metadata_Count
				from SobekCM_Item_Aggregation_Metadata_Link L, SobekCM_Metadata_Unique_Search_Table M
				where ( L.AggregationID = @aggregationid ) and ( L.MetadataID = M.MetadataID ) and ( L.MetadataTypeID = @facettype5 ) and ( L.OrderNum <= 100 )
				order by Metadata_Count DESC, MetadataValue ASC;
			end;
			
			-- Return the SIXTH facet
			if ( @facettype6 > 0 )
			begin
				-- Return the first 100 values
				select top(100) MetadataValue, Metadata_Count
				from SobekCM_Item_Aggregation_Metadata_Link L, SobekCM_Metadata_Unique_Search_Table M
				where ( L.AggregationID = @aggregationid ) and ( L.MetadataID = M.MetadataID ) and ( L.MetadataTypeID = @facettype6 ) and ( L.OrderNum <= 100 )
				order by Metadata_Count DESC, MetadataValue ASC;
			end;
			
			-- Return the SEVENTH facet
			if ( @facettype7 > 0 )
			begin
				-- Return the first 100 values
				select top(100) MetadataValue, Metadata_Count
				from SobekCM_Item_Aggregation_Metadata_Link L, SobekCM_Metadata_Unique_Search_Table M
				where ( L.AggregationID = @aggregationid ) and ( L.MetadataID = M.MetadataID ) and ( L.MetadataTypeID = @facettype7 ) and ( L.OrderNum <= 100 )
				order by Metadata_Count DESC, MetadataValue ASC;
			end;
			
			-- Return the EIGHTH facet
			if ( @facettype8 > 0 )
			begin
				-- Return the first 100 values
				select top(100) MetadataValue, Metadata_Count
				from SobekCM_Item_Aggregation_Metadata_Link L, SobekCM_Metadata_Unique_Search_Table M
				where ( L.AggregationID = @aggregationid ) and ( L.MetadataID = M.MetadataID ) and ( L.MetadataTypeID = @facettype8 ) and ( L.OrderNum <= 100 )
				order by Metadata_Count DESC, MetadataValue ASC;
			end;
		
		end
		else
		begin
		
			-- Get the list of all item ids 
			select distinct(I.ItemID) as ItemID
			into #TEMP_ITEMS_FACETS
			from SobekCM_Item I, SobekCM_Item_Aggregation_Item_Link CL
			where ( CL.ItemID = I.ItemID )
			  and ( CL.AggregationID = @aggregationid )
			  and ( I.IP_Restriction_Mask >= @lower_mask )
			  and ( I.CreateDate >= @date );

			-- Return the FIRST facet
			if ( @facettype1 > 0 )
			begin
				-- Return the first 100 values
				select MetadataValue, Metadata_Count
				from  ( select top(100) T.*
						from (	select L.MetadataID, Metadata_Count = COUNT(*)
								from SobekCM_Metadata_Unique_Link L, SobekCM_Metadata_Unique_Search_Table U, #TEMP_ITEMS_FACETS I
								where ( L.ItemID = I.ItemID )
								  and ( L.MetadataID = U.MetadataID )
								  and ( U.MetadataTypeID = @facettype1 )
								group by L.MetadataID ) T
						 order by Metadata_Count DESC ) F, SobekCM_Metadata_Unique_Search_Table M
				where M.MetadataID = F.MetadataID
				order by Metadata_Count DESC, MetadataValue ASC;
			end;
			
			-- Return the SECOND facet
			if ( @facettype2 > 0 )
			begin
				-- Return the first 100 values
				select MetadataValue, Metadata_Count
				from  ( select top(100) T.*
						from (	select L.MetadataID, Metadata_Count = COUNT(*)
								from SobekCM_Metadata_Unique_Link L, SobekCM_Metadata_Unique_Search_Table U, #TEMP_ITEMS_FACETS I
								where ( L.ItemID = I.ItemID )
								  and ( L.MetadataID = U.MetadataID )
								  and ( U.MetadataTypeID = @facettype2 )
								group by L.MetadataID ) T
						 order by Metadata_Count DESC ) F, SobekCM_Metadata_Unique_Search_Table M
				where M.MetadataID = F.MetadataID
				order by Metadata_Count DESC, MetadataValue ASC;
			end;
			
			-- Return the THIRD facet
			if ( @facettype3 > 0 )
			begin
				-- Return the first 100 values
				select MetadataValue, Metadata_Count
				from  ( select top(100) T.*
						from (	select L.MetadataID, Metadata_Count = COUNT(*)
								from SobekCM_Metadata_Unique_Link L, SobekCM_Metadata_Unique_Search_Table U, #TEMP_ITEMS_FACETS I
								where ( L.ItemID = I.ItemID )
								  and ( L.MetadataID = U.MetadataID )
								  and ( U.MetadataTypeID = @facettype3 )
								group by L.MetadataID ) T
						 order by Metadata_Count DESC ) F, SobekCM_Metadata_Unique_Search_Table M
				where M.MetadataID = F.MetadataID
				order by Metadata_Count DESC, MetadataValue ASC;
			end;	
			
			-- Return the FOURTH facet
			if ( @facettype4 > 0 )
			begin
				-- Return the first 100 values
				select MetadataValue, Metadata_Count
				from  ( select top(100) T.*
						from (	select L.MetadataID, Metadata_Count = COUNT(*)
								from SobekCM_Metadata_Unique_Link L, SobekCM_Metadata_Unique_Search_Table U, #TEMP_ITEMS_FACETS I
								where ( L.ItemID = I.ItemID )
								  and ( L.MetadataID = U.MetadataID )
								  and ( U.MetadataTypeID = @facettype4 )
								group by L.MetadataID ) T
						 order by Metadata_Count DESC ) F, SobekCM_Metadata_Unique_Search_Table M
				where M.MetadataID = F.MetadataID
				order by Metadata_Count DESC, MetadataValue ASC;
			end;
			
			-- Return the FIFTH facet
			if ( @facettype5 > 0 )
			begin
				-- Return the first 100 values
				select MetadataValue, Metadata_Count
				from  ( select top(100) T.*
						from (	select L.MetadataID, Metadata_Count = COUNT(*)
								from SobekCM_Metadata_Unique_Link L, SobekCM_Metadata_Unique_Search_Table U, #TEMP_ITEMS_FACETS I
								where ( L.ItemID = I.ItemID )
								  and ( L.MetadataID = U.MetadataID )
								  and ( U.MetadataTypeID = @facettype5 )
								group by L.MetadataID ) T
						 order by Metadata_Count DESC ) F, SobekCM_Metadata_Unique_Search_Table M
				where M.MetadataID = F.MetadataID
				order by Metadata_Count DESC, MetadataValue ASC;
			end;
			
			-- Return the SIXTH facet
			if ( @facettype6 > 0 )
			begin
				-- Return the first 100 values
				select MetadataValue, Metadata_Count
				from  ( select top(100) T.*
						from (	select L.MetadataID, Metadata_Count = COUNT(*)
								from SobekCM_Metadata_Unique_Link L, SobekCM_Metadata_Unique_Search_Table U, #TEMP_ITEMS_FACETS I
								where ( L.ItemID = I.ItemID )
								  and ( L.MetadataID = U.MetadataID )
								  and ( U.MetadataTypeID = @facettype6 )
								group by L.MetadataID ) T
						 order by Metadata_Count DESC ) F, SobekCM_Metadata_Unique_Search_Table M
				where M.MetadataID = F.MetadataID
				order by Metadata_Count DESC, MetadataValue ASC;
			end;
			
			-- Return the SEVENTH facet
			if ( @facettype7 > 0 )
			begin
				-- Return the first 100 values
				select MetadataValue, Metadata_Count
				from  ( select top(100) T.*
						from (	select L.MetadataID, Metadata_Count = COUNT(*)
								from SobekCM_Metadata_Unique_Link L, SobekCM_Metadata_Unique_Search_Table U, #TEMP_ITEMS_FACETS I
								where ( L.ItemID = I.ItemID )
								  and ( L.MetadataID = U.MetadataID )
								  and ( U.MetadataTypeID = @facettype7 )
								group by L.MetadataID ) T
						 order by Metadata_Count DESC ) F, SobekCM_Metadata_Unique_Search_Table M
				where M.MetadataID = F.MetadataID
				order by Metadata_Count DESC, MetadataValue ASC;
			end;
			
			-- Return the EIGHTH facet
			if ( @facettype8 > 0 )
			begin
				-- Return the first 100 values
				select MetadataValue, Metadata_Count
				from  ( select top(100) T.*
						from (	select L.MetadataID, Metadata_Count = COUNT(*)
								from SobekCM_Metadata_Unique_Link L, SobekCM_Metadata_Unique_Search_Table U, #TEMP_ITEMS_FACETS I
								where ( L.ItemID = I.ItemID )
								  and ( L.MetadataID = U.MetadataID )
								  and ( U.MetadataTypeID = @facettype8 )
								group by L.MetadataID ) T
						 order by Metadata_Count DESC ) F, SobekCM_Metadata_Unique_Search_Table M
				where M.MetadataID = F.MetadataID
				order by Metadata_Count DESC, MetadataValue ASC;
			end;
			
			-- drop this temporary table
			drop table #TEMP_ITEMS_FACETS;
		end;
	end;
	
	SET NOCOUNT ON;
end;
GO


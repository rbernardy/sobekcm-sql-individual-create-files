USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Metadata_By_Bib_Vid]    Script Date: 2/21/2022 8:36:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[SobekCM_Metadata_By_Bib_Vid] 
	@aggregationcode varchar(20),
	@bibid1 varchar(10),
	@vid1 varchar(5),
	@bibid2 varchar(10) = null,
	@vid2 varchar(5) = null,
	@bibid3 varchar(10) = null,
	@vid3 varchar(5) = null,
	@bibid4 varchar(10) = null,
	@vid4 varchar(5) = null,
	@bibid5 varchar(10) = null,
	@vid5 varchar(5) = null,
	@bibid6 varchar(10) = null,
	@vid6 varchar(5) = null,
	@bibid7 varchar(10) = null,
	@vid7 varchar(5) = null,
	@bibid8 varchar(10) = null,
	@vid8 varchar(5) = null,
	@bibid9 varchar(10) = null,
	@vid9 varchar(5) = null,
	@bibid10 varchar(10) = null,
	@vid10 varchar(5) = null										
AS
BEGIN
	-- No need to perform any locks here, especially given the possible
	-- length of this search
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
	SET NOCOUNT ON;

	-- Create the temporary tables first
	-- Create the temporary table to hold all the item id's
	create table #TEMP_ITEMS ( ItemID int primary key, fk_TitleID int, Hit_Count int, SortDate bigint );
		
	-- Determine the aggregationid
	declare @aggregationid int;
	set @aggregationid = coalesce( (select AggregationID from SobekCM_Item_Aggregation where Code=@aggregationcode), -1 );
	
	-- Get the sql which will be used to return the aggregation-specific display values for all the items in this page of results
	declare @item_display_sql nvarchar(max);
	if ( @aggregationid < 0 )
	begin
		select @item_display_sql=coalesce(Browse_Results_Display_SQL, 'select S.ItemID, S.Publication_Date, S.Creator, S.[Publisher.Display], S.Format, S.Edition, S.Material, S.Measurements, S.Style_Period, S.Technique, S.[Subjects.Display], S.Source_Institution, S.Donor from SobekCM_Metadata_Basic_Search_Table S, @itemtable T where S.ItemID = T.ItemID order by T.RowNumber;')
		from SobekCM_Item_Aggregation
		where Code='all';
	end
	else
	begin
		select @item_display_sql=coalesce(Browse_Results_Display_SQL, 'select S.ItemID, S.Publication_Date, S.Creator, S.[Publisher.Display], S.Format, S.Edition, S.Material, S.Measurements, S.Style_Period, S.Technique, S.[Subjects.Display], S.Source_Institution, S.Donor from SobekCM_Metadata_Basic_Search_Table S, @itemtable T where S.ItemID = T.ItemID order by T.RowNumber;')
		from SobekCM_Item_Aggregation
		where AggregationID=@aggregationid;
	end;

	-- Perform the actual metadata search differently, depending on whether an aggregation was 
	-- included to limit this search
	if ( @aggregationid > 0 )
	begin		  
		insert into #TEMP_ITEMS ( ItemID, fk_TitleID, Hit_Count, SortDate )
		select CL.ItemID, I.GroupID, 1, I.SortDate
		from SobekCM_Item AS I inner join
				SobekCM_Item_Aggregation_Item_Link AS CL ON CL.ItemID = I.ItemID inner join
				SobekCM_Item_Group AS M on M.GroupID = I.GroupID
		where ( I.Deleted = 'false' )
			and ( CL.AggregationID = @aggregationid )
			and ( I.Dark = 'false' )
			and (    (( M.BibID=coalesce(@bibid1,'')) and ( I.VID=coalesce(@vid1,'')))
			      or (( M.BibID=coalesce(@bibid2,'')) and ( I.VID=coalesce(@vid2,'')))
				  or (( M.BibID=coalesce(@bibid3,'')) and ( I.VID=coalesce(@vid3,''))) 
				  or (( M.BibID=coalesce(@bibid4,'')) and ( I.VID=coalesce(@vid4,'')))
				  or (( M.BibID=coalesce(@bibid5,'')) and ( I.VID=coalesce(@vid5,'')))
				  or (( M.BibID=coalesce(@bibid6,'')) and ( I.VID=coalesce(@vid6,'')))
				  or (( M.BibID=coalesce(@bibid7,'')) and ( I.VID=coalesce(@vid7,'')))
				  or (( M.BibID=coalesce(@bibid8,'')) and ( I.VID=coalesce(@vid8,'')))
				  or (( M.BibID=coalesce(@bibid9,'')) and ( I.VID=coalesce(@vid9,'')))
				  or (( M.BibID=coalesce(@bibid10,'')) and ( I.VID=coalesce(@vid10,'')))  );			  
			  
	end
	else
	begin	
		insert into #TEMP_ITEMS ( ItemID, fk_TitleID, Hit_Count, SortDate )
		select I.ItemID, I.GroupID, 1, I.SortDate
		from SobekCM_Item AS I inner join
			 SobekCM_Item_Group AS M on M.GroupID = I.GroupID
		where ( I.Deleted = 'false' )
			and ( I.IncludeInAll = 'true' )
			and ( I.Dark = 'false' )
			and (    (( M.BibID=coalesce(@bibid1,'')) and ( I.VID=coalesce(@vid1,'')))
			      or (( M.BibID=coalesce(@bibid2,'')) and ( I.VID=coalesce(@vid2,'')))
				  or (( M.BibID=coalesce(@bibid3,'')) and ( I.VID=coalesce(@vid3,''))) 
				  or (( M.BibID=coalesce(@bibid4,'')) and ( I.VID=coalesce(@vid4,'')))
				  or (( M.BibID=coalesce(@bibid5,'')) and ( I.VID=coalesce(@vid5,'')))
				  or (( M.BibID=coalesce(@bibid6,'')) and ( I.VID=coalesce(@vid6,'')))
				  or (( M.BibID=coalesce(@bibid7,'')) and ( I.VID=coalesce(@vid7,'')))
				  or (( M.BibID=coalesce(@bibid8,'')) and ( I.VID=coalesce(@vid8,'')))
				  or (( M.BibID=coalesce(@bibid9,'')) and ( I.VID=coalesce(@vid9,'')))
				  or (( M.BibID=coalesce(@bibid10,'')) and ( I.VID=coalesce(@vid10,'')))  );		
	end;

	-- Create the temporary item table variable for paging purposes
	declare @TEMP_PAGED_ITEMS TempPagedItemsTableType;
			

	-- create the temporary title table definition
	declare @TEMP_TITLES table ( TitleID int, BibID varchar(10), RowNumber int);		
							  
	-- Create saved select across titles for row numbers
	with TITLES_SELECT AS
		(	select GroupID, G.BibID, ROW_NUMBER() OVER (ORDER BY BibID ASC) as RowNumber
			from #TEMP_ITEMS I, SobekCM_Item_Group G
			where I.fk_TitleID = G.GroupID
			group by G.GroupID, G.BibID, G.SortTitle )

	-- Insert the correct rows into the temp title table	
	insert into @TEMP_TITLES ( TitleID, BibID, RowNumber )
	select GroupID, BibID, RowNumber
	from TITLES_SELECT;
			
	-- Return the title information for this page
	select RowNumber as TitleID, T.BibID, G.GroupTitle, G.ALEPH_Number as OPAC_Number, G.OCLC_Number, coalesce(G.GroupThumbnail,'') as GroupThumbnail, G.[Type], coalesce(G.Primary_Identifier_Type,'') as Primary_Identifier_Type, coalesce(G.Primary_Identifier, '') as Primary_Identifier
	from @TEMP_TITLES T, SobekCM_Item_Group G
	where ( T.TitleID = G.GroupID )
	order by RowNumber ASC;
			
	-- Get the item id's for the items related to these titles
	insert into @TEMP_PAGED_ITEMS
	select ItemID, RowNumber
	from @TEMP_TITLES T, SobekCM_Item I
	where ( T.TitleID = I.GroupID )
		and ( I.Deleted = 'false' )
		and ( I.Dark = 'false' );
			
	-- Return the basic system required item information for this page of results
	select T.RowNumber as fk_TitleID, I.ItemID, VID, Title, IP_Restriction_Mask, coalesce(I.MainThumbnail,'') as MainThumbnail, coalesce(I.Level1_Index, -1) as Level1_Index, coalesce(I.Level1_Text,'') as Level1_Text, coalesce(I.Level2_Index, -1) as Level2_Index, coalesce(I.Level2_Text,'') as Level2_Text, coalesce(I.Level3_Index,-1) as Level3_Index, coalesce(I.Level3_Text,'') as Level3_Text, isnull(I.PubDate,'') as PubDate, I.[PageCount], coalesce(I.Link,'') as Link, coalesce( Spatial_KML, '') as Spatial_KML, coalesce(COinS_OpenURL, '') as COinS_OpenURL		
	from SobekCM_Item I, @TEMP_PAGED_ITEMS T
	where ( T.ItemID = I.ItemID )
	order by T.RowNumber, Level1_Index, Level2_Index, Level3_Index;			
								
	-- Return the aggregation-specific display values for all the items in this page of results
	execute sp_Executesql @item_display_sql, N' @itemtable TempPagedItemsTableType READONLY', @TEMP_PAGED_ITEMS; 	
	
	-- Drop the temporary table
	drop table #TEMP_ITEMS;
	
	SET NOCOUNT OFF;
END;
GO


USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[Tracking_Metadata_Search]    Script Date: 3/22/2022 8:40:12 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Perform metadata search for tracking application
-- This is identical to SobekCM_Metadata_Search, EXCEPT:
--    (1) Title, Author, IP restriction flag, Thumbnail, and Publisher returned with item list
--    (2) Group title, thumbnail, type, OCLC, and ALEPH returned with title list
--    (3) No facets returned and both PRIVATE and PUBLIC items are returned in list
--    (4) All tracking information ( milestones, tracking box, etc..) returned in item list
CREATE PROCEDURE [dbo].[Tracking_Metadata_Search]
	@term1 nvarchar(255),
	@field1 int,
	@link2 int,
	@term2 nvarchar(255),
	@field2 int,
	@link3 int,
	@term3 nvarchar(255),
	@field3 int,
	@link4 int,
	@term4 nvarchar(255),
	@field4 int,
	@link5 int,
	@term5 nvarchar(255),
	@field5 int,
	@link6 int,
	@term6 nvarchar(255),
	@field6 int,
	@link7 int,
	@term7 nvarchar(255),
	@field7 int,
	@link8 int,
	@term8 nvarchar(255),
	@field8 int,
	@link9 int,
	@term9 nvarchar(255),
	@field9 int,
	@link10 int,
	@term10 nvarchar(255),
	@field10 int,
	@aggregationcode varchar(20)
AS
BEGIN

	-- No need to perform any locks here, especially given the possible
	-- length of this search
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
	SET NOCOUNT ON;
	
	-- Field#'s indicate which metadata field (if any).  These are numbers from the 
	-- SobekCM_Metadata_Types table.  A field# of -1, means all fields are included.
	
	-- Link#'s indicate if this is an AND-joiner ( intersect ) or an OR-joiner ( union )
	-- 0 = AND, 1 = OR, 2 = AND NOT
	
	-- Examples of using this procedure are:
	-- exec SobekCM_Metadata_Search 'haiti',1,0,'kesse',4,0,'',0
	-- This searches for materials which have haiti in the title AND kesse in the creator
	
	-- exec SobekCM_Metadata_Search 'haiti',1,1,'kesse',-1,0,'',0
	-- This searches for materials which have haiti in the title OR kesse anywhere
	
	-- Create the temporary tables first
	-- Create the temporary table to hold all the item id's
	create table #TEMPZERO ( ItemID int );
	create table #TEMP1 ( ItemID int primary key, Hit_Count int );
	create table #TEMP_ITEMS ( BibID varchar(10), VID varchar(5), SortDate bigint, Spatial_KML varchar(4000), fk_TitleID int, Title nvarchar(500), IP_Restriction_Mask smallint, ItemID int, Hit_Count int, Author nvarchar(1000), Publisher nvarchar(1000), Thumbnail varchar(100), Internal_Comments nvarchar(1000), Dark bit, Last_MileStone int, Milestone_DigitalAcquisition datetime, Milestone_ImageProcessing datetime, Milestone_QualityControl datetime, Milestone_OnlineComplete datetime, Born_Digital bit, Material_Received_Date datetime, Disposition_Advice int, Disposition_Date datetime, Disposition_Type int, Locally_Archived bit, Remotely_Archived bit, Tracking_Box varchar(25), AggregationCodes varchar(100), Level1_Text nvarchar(255), Level1_Index int, Level2_Text nvarchar(255), Level2_Index int, Level3_Text nvarchar(255), Level3_Index int, Level4_Text nvarchar(255), Level4_Index int, Level5_Text nvarchar(255), Level5_Index int, SortTitle nvarchar(500), PubDate nvarchar(100));
	create table #TEMP_TITLES ( fk_TitleID int, Item_Hit_Count int );
	
	-- Do not need to maintain row counts
	Set NoCount ON;
	    
	-- declare both the sql query and the parameter definitions
	declare @SQLQuery AS nvarchar(max);
    declare @ParamDefinition AS NVarchar(2000);
    
      -- Add the first term
    set @SQLQuery = 'select distinct(itemid) from SobekCM_Metadata_Unique_Search_Table M, SobekCM_Metadata_Unique_Link L where ( contains( MetadataValue, @innerterm1 )) and ( L.MetadataID=M.MetadataID )';
    
    -- Was this search term field specific?
    if ( @field1 > 0 )
		set @SQLQuery = @SQLQuery + ' and ( MetadataTypeID = ' + CAST( @field1 as varchar(2)) + ')';

	-- Add the second term, if there is one
	if (( LEN( ISNULL(@term2,'')) > 0 ) and (( @link2 = 0 ) or ( @link2 = 1 ) or ( @link2 = 2 )))
	begin	
		-- Was this an AND?
		if ( @link2 = 0 )
			set @SQLQuery = @SQLQuery + ' intersect ';
		
		-- Was this an OR?
		if ( @link2 = 1 )
			set @SQLQuery = @SQLQuery + ' union ';
			
		-- Was this an AND NOT?
		if ( @link2 = 2 )
			set @SQLQuery = @SQLQuery + ' except ';
		
		-- Add the term next
		set @SQLQuery = @SQLQuery + 'select distinct(itemid) from SobekCM_Metadata_Unique_Search_Table M, SobekCM_Metadata_Unique_Link L where ( contains( MetadataValue, @innerterm2 )) and ( L.MetadataID=M.MetadataID )';
				
		-- Was this search term field specific?
		if ( @field2 > 0 )
			set @SQLQuery = @SQLQuery + ' and ( MetadataTypeID = ' + CAST( @field2 as varchar(2)) + ')';		
	end;    
	
	-- Add the third term, if there is one
	if (( LEN( ISNULL(@term3,'')) > 0 ) and (( @link3 = 0 ) or ( @link3 = 1 ) or ( @link3 = 2 )))
	begin	
		-- Was this an AND?
		if ( @link3 = 0 )
			set @SQLQuery = @SQLQuery + ' intersect ';
		
		-- Was this an OR?
		if ( @link3 = 1 )
			set @SQLQuery = @SQLQuery + ' union ';
			
		-- Was this an AND NOT?
		if ( @link3 = 2 )
			set @SQLQuery = @SQLQuery + ' except ';
		
		-- Add the term next
		set @SQLQuery = @SQLQuery + 'select distinct(itemid) from SobekCM_Metadata_Unique_Search_Table M, SobekCM_Metadata_Unique_Link L where ( contains( MetadataValue, @innerterm3 )) and ( L.MetadataID=M.MetadataID )';
				
		-- Was this search term field specific?
		if ( @field3 > 0 )
			set @SQLQuery = @SQLQuery + ' and ( MetadataTypeID = ' + CAST( @field3 as varchar(2)) + ')';
	end;
	
	-- Add the fourth term, if there is one
	if (( LEN( ISNULL(@term4,'')) > 0 ) and (( @link4 = 0 ) or ( @link4 = 1 ) or ( @link4 = 2 )))
	begin	
		-- Was this an AND?
		if ( @link4 = 0 )
			set @SQLQuery = @SQLQuery + ' intersect ';
		
		-- Was this an OR?
		if ( @link4 = 1 )
			set @SQLQuery = @SQLQuery + ' union ';
			
		-- Was this an AND NOT?
		if ( @link4 = 2 )
			set @SQLQuery = @SQLQuery + ' except ';
		
		-- Add the term next
		set @SQLQuery = @SQLQuery + 'select distinct(itemid) from SobekCM_Metadata_Unique_Search_Table M, SobekCM_Metadata_Unique_Link L where ( contains( MetadataValue, @innerterm4 )) and ( L.MetadataID=M.MetadataID )';
		
		-- Was this search term field specific?
		if ( @field4 > 0 )
			set @SQLQuery = @SQLQuery + ' and ( MetadataTypeID = ' + CAST( @field4 as varchar(2)) + ')';
	end;
	
	-- Add the fifth term, if there is one
	if (( LEN( ISNULL(@term5,'')) > 0 ) and (( @link5 = 0 ) or ( @link5 = 1 ) or ( @link5 = 2 )))
	begin	
		-- Was this an AND?
		if ( @link5 = 0 )
			set @SQLQuery = @SQLQuery + ' intersect ';
		
		-- Was this an OR?
		if ( @link5 = 1 )
			set @SQLQuery = @SQLQuery + ' union ';
			
		-- Was this an AND NOT?
		if ( @link5 = 2 )
			set @SQLQuery = @SQLQuery + ' except ';
		
		-- Add the term next
		set @SQLQuery = @SQLQuery + 'select distinct(itemid) from SobekCM_Metadata_Unique_Search_Table M, SobekCM_Metadata_Unique_Link L where ( contains( MetadataValue, @innerterm5 )) and ( L.MetadataID=M.MetadataID )';
		
		-- Was this search term field specific?
		if ( @field5 > 0 )
			set @SQLQuery = @SQLQuery + ' and ( MetadataTypeID = ' + CAST( @field5 as varchar(2)) + ')';
	end;
	
	-- Add the sixth term, if there is one
	if (( LEN( ISNULL(@term6,'')) > 0 ) and (( @link6 = 0 ) or ( @link6 = 1 ) or ( @link6 = 2 )))
	begin	
		-- Was this an AND?
		if ( @link6 = 0 )
			set @SQLQuery = @SQLQuery + ' intersect ';
		
		-- Was this an OR?
		if ( @link6 = 1 )
			set @SQLQuery = @SQLQuery + ' union ';
			
		-- Was this an AND NOT?
		if ( @link6 = 2 )
			set @SQLQuery = @SQLQuery + ' except ';
		
		-- Add the term next
		set @SQLQuery = @SQLQuery + 'select distinct(itemid) from SobekCM_Metadata_Unique_Search_Table M, SobekCM_Metadata_Unique_Link L where ( contains( MetadataValue, @innerterm6 )) and ( L.MetadataID=M.MetadataID )';		
		
		-- Was this search term field specific?
		if ( @field6 > 0 )
			set @SQLQuery = @SQLQuery + ' and ( MetadataTypeID = ' + CAST( @field6 as varchar(2)) + ')';
	end;
	
	-- Add the seventh term, if there is one
	if (( LEN( ISNULL(@term7,'')) > 0 ) and (( @link7 = 0 ) or ( @link7 = 1 ) or ( @link7 = 2 )))
	begin	
		-- Was this an AND?
		if ( @link7 = 0 )
			set @SQLQuery = @SQLQuery + ' intersect ';
		
		-- Was this an OR?
		if ( @link7 = 1 )
			set @SQLQuery = @SQLQuery + ' union ';
			
		-- Was this an AND NOT?
		if ( @link7 = 2 )
			set @SQLQuery = @SQLQuery + ' except ';
		
		-- Add the term next
		set @SQLQuery = @SQLQuery + 'select distinct(itemid) from SobekCM_Metadata_Unique_Search_Table M, SobekCM_Metadata_Unique_Link L where ( contains( MetadataValue, @innerterm7 )) and ( L.MetadataID=M.MetadataID )';		
		
		-- Was this search term field specific?
		if ( @field7 > 0 )
			set @SQLQuery = @SQLQuery + ' and ( MetadataTypeID = ' + CAST( @field7 as varchar(2)) + ')';
	end;
	
	-- Add the eighth term, if there is one
	if (( LEN( ISNULL(@term8,'')) > 0 ) and (( @link8 = 0 ) or ( @link8 = 1 ) or ( @link8 = 2 )))
	begin	
		-- Was this an AND?
		if ( @link8 = 0 )
			set @SQLQuery = @SQLQuery + ' intersect ';
		
		-- Was this an OR?
		if ( @link8 = 1 )
			set @SQLQuery = @SQLQuery + ' union ';
			
		-- Was this an AND NOT?
		if ( @link8 = 2 )
			set @SQLQuery = @SQLQuery + ' except ';
		
		-- Add the term next
		set @SQLQuery = @SQLQuery + 'select distinct(itemid) from SobekCM_Metadata_Unique_Search_Table M, SobekCM_Metadata_Unique_Link L where ( contains( MetadataValue, @innerterm8 )) and ( L.MetadataID=M.MetadataID )';
		
		-- Was this search term field specific?
		if ( @field8 > 0 )
			set @SQLQuery = @SQLQuery + ' and ( MetadataTypeID = ' + CAST( @field8 as varchar(2)) + ')';
	end;
	
	-- Add the ninth term, if there is one
	if (( LEN( ISNULL(@term9,'')) > 0 ) and (( @link9 = 0 ) or ( @link9 = 1 ) or ( @link9 = 2 )))
	begin	
		-- Was this an AND?
		if (( @link9 = 0 ) or ( @link9 = 2 ))
			set @SQLQuery = @SQLQuery + ' intersect ';
		
		-- Was this an OR?
		if ( @link9 = 1 )
			set @SQLQuery = @SQLQuery + ' union ';
			
		-- Was this an AND NOT?
		if ( @link9 = 2 )
			set @SQLQuery = @SQLQuery + ' except ';
		
		-- Add the term next
		set @SQLQuery = @SQLQuery + 'select distinct(itemid) from SobekCM_Metadata_Unique_Search_Table M, SobekCM_Metadata_Unique_Link L where ( contains( MetadataValue, @innerterm9 )) and ( L.MetadataID=M.MetadataID )';
		
		-- Was this search term field specific?
		if ( @field9 > 0 )
			set @SQLQuery = @SQLQuery + ' and ( MetadataTypeID = ' + CAST( @field9 as varchar(2)) + ')';
	end;
	
	-- Add the tenth term, if there is one
	if (( LEN( ISNULL(@term10,'')) > 0 ) and (( @link10 = 0 ) or ( @link10 = 1 ) or ( @link10 = 2 )))
	begin	
		-- Was this an AND?
		if (( @link10 = 0 ) or ( @link10 = 2 ))
			set @SQLQuery = @SQLQuery + ' intersect ';
		
		-- Was this an OR?
		if ( @link10 = 1 )
			set @SQLQuery = @SQLQuery + ' union ';
			
		-- Was this an AND NOT?
		if ( @link10 = 2 )
			set @SQLQuery = @SQLQuery + ' except ';
		
		-- Add the term next
		set @SQLQuery = @SQLQuery + 'select distinct(itemid) from SobekCM_Metadata_Unique_Search_Table M, SobekCM_Metadata_Unique_Link L where ( contains( MetadataValue, @innerterm10 )) and ( L.MetadataID=M.MetadataID )';
		
		-- Was this search term field specific?
		if ( @field10 > 0 )
			set @SQLQuery = @SQLQuery + ' and ( MetadataTypeID = ' + CAST( @field10 as varchar(2)) + ')';
	end;
	
	-- Add the recompile option
	set @SQLQuery = @SQLQuery + ' option (RECOMPILE)';
	
	-- Set the parameter definition
	set @ParamDefinition = ' @innerterm1 nvarchar(255), @innerterm2 nvarchar(255), @innerterm3 nvarchar(255), @innerterm4 nvarchar(255), @innerterm5 nvarchar(255), @innerterm6 nvarchar(255), @innerterm7 nvarchar(255), @innerterm8 nvarchar(255), @innerterm9 nvarchar(255), @innerterm10 nvarchar(255)';
	
	-- Execute this stored procedure
	insert #TEMPZERO execute sp_Executesql @SQLQuery, @ParamDefinition, @term1, @term2, @term3, @term4, @term5, @term6, @term7, @term8, @term9, @term10;
	
	-- Select the distinct item id's and sort by relevance
	insert into #TEMP1 ( ItemID, Hit_Count )
	select distinct(ItemID), Hit_Count = COUNT(*)
	from #TEMPZERO
	group by ItemID
	order by Hit_Count DESC;

	-- Drop the big temporary table
	drop table #TEMPZERO;
	
	-- Was an aggregation included?
	if ( LEN(ISNULL( @aggregationcode,'' )) > 0 )
	begin	
		-- Look for matching the provided aggregation
		insert into #TEMP_ITEMS ( BibID, VID, SortDate, Spatial_KML, fk_TitleID, Title, IP_Restriction_Mask, ItemID, Hit_Count, Author, Publisher, Thumbnail, Internal_Comments, Dark, Last_MileStone, Milestone_DigitalAcquisition, Milestone_ImageProcessing, Milestone_QualityControl, Milestone_OnlineComplete, Born_Digital, Material_Received_Date, Disposition_Advice, Disposition_Date, Disposition_Type, Locally_Archived, Remotely_Archived, Tracking_Box, AggregationCodes, Level1_Text, Level1_Index, Level2_Text, Level2_Index, Level3_Text, Level3_Index, Level4_Text, Level4_Index, Level5_Text, Level5_Index, SortTitle, PubDate )
		select G.BibID, I.VID, isnull( I.SortDate,-1), isnull(Spatial_KML,''), I.GroupID, I.Title, IP_Restriction_Mask, I.ItemID, Hit_Count, I.Author, I.Publisher, I.MainThumbnail, I.Internal_Comments, I.Dark, I.Last_MileStone, I.Milestone_DigitalAcquisition, I.Milestone_ImageProcessing, I.Milestone_QualityControl, I.Milestone_OnlineComplete, I.Born_Digital, I.Material_Received_Date, I.Disposition_Advice, I.Disposition_Date, I.Disposition_Type, I.Locally_Archived, I.Remotely_Archived, I.Tracking_Box, I.AggregationCodes, Level1_Text=isnull(Level1_Text,''), Level1_Index=isnull(Level1_Index,-1), Level2_Text=isnull(Level2_Text, ''), Level2_Index=isnull(Level2_Index, -1), Level3_Text=isnull(Level3_Text, ''), Level3_Index=isnull(Level3_Index, -1), Level4_Text=isnull(Level4_Text, ''), Level4_Index=isnull(Level4_Index, -1), Level5_Text=isnull(Level5_Text, ''), Level5_Index=isnull(Level5_Index,-1), SortTitle=ISNULL(I.SortTitle, upper(Title)), I.PubDate
		from #TEMP1 T1, SobekCM_Item I, SobekCM_Item_Aggregation_Item_Link CL, SobekCM_Item_Aggregation C, SobekCM_Item_Group G
		where ( CL.ItemID = I.ItemID )
		  and ( CL.AggregationID = C.AggregationID )
		  and ( C.Code = @aggregationcode )
		  and ( I.Deleted = CONVERT(bit,0) )
		  and ( I.GroupID = G.GroupID ) 
		  and ( T1.ItemID = I.ItemID );
	end
	else
	begin	
		-- Pull the information about item
		insert into #TEMP_ITEMS ( BibID, VID, SortDate, Spatial_KML, fk_TitleID, Title, IP_Restriction_Mask, ItemID, Hit_Count, Author, Publisher, Thumbnail, Internal_Comments, Dark, Last_MileStone, Milestone_DigitalAcquisition, Milestone_ImageProcessing, Milestone_QualityControl, Milestone_OnlineComplete, Born_Digital, Material_Received_Date, Disposition_Advice, Disposition_Date, Disposition_Type, Locally_Archived, Remotely_Archived, Tracking_Box, AggregationCodes, Level1_Text, Level1_Index, Level2_Text, Level2_Index, Level3_Text, Level3_Index, Level4_Text, Level4_Index, Level5_Text, Level5_Index, SortTitle, PubDate )
		select G.BibID, I.VID, isnull( I.SortDate,-1), isnull(Spatial_KML,''), I.GroupID, Title, IP_Restriction_Mask, I.ItemID, Hit_Count, I.Author, I.Publisher, I.MainThumbnail, I.Internal_Comments, I.Dark, I.Last_MileStone, I.Milestone_DigitalAcquisition, I.Milestone_ImageProcessing, I.Milestone_QualityControl, I.Milestone_OnlineComplete, I.Born_Digital, I.Material_Received_Date, I.Disposition_Advice, I.Disposition_Date, I.Disposition_Type, I.Locally_Archived, I.Remotely_Archived, I.Tracking_Box, I.AggregationCodes, Level1_Text=isnull(Level1_Text,''), Level1_Index=isnull(Level1_Index,-1), Level2_Text=isnull(Level2_Text, ''), Level2_Index=isnull(Level2_Index, -1), Level3_Text=isnull(Level3_Text, ''), Level3_Index=isnull(Level3_Index, -1), Level4_Text=isnull(Level4_Text, ''), Level4_Index=isnull(Level4_Index, -1), Level5_Text=isnull(Level5_Text, ''), Level5_Index=isnull(Level5_Index,-1), SortTitle=ISNULL(I.SortTitle, upper(Title)), I.PubDate
		from #TEMP1 T1, SobekCM_Item I, SobekCM_Item_Group G
		where ( I.Deleted = CONVERT(bit,0) )
		  and ( I.GroupID = G.GroupID ) 
		  and ( T1.ItemID = I.ItemID );
	end;
		  
	-- Select the title information
	insert into #TEMP_TITLES ( fk_TitleID, Item_Hit_Count )
	select fk_TitleID, Item_Hit_Count=(SUM(Hit_COunt)/COUNT(*))
	from #TEMP_ITEMS I
	group by fk_TitleID
	order by Item_Hit_Count DESC;

	-- Return the item informaiton
	select BibID, VID, SortDate, Spatial_KML, fk_TitleID, Title, Author, Publisher, Level1_Text, Level1_Index, Level2_Text, Level2_Index, Level3_Text, Level3_Index, Level4_Text, Level4_Index, Level5_Text, Level5_Index, IP_Restriction_Mask, Thumbnail, Internal_Comments, Dark, Last_MileStone, Milestone_DigitalAcquisition, Milestone_ImageProcessing, Milestone_QualityControl, Milestone_OnlineComplete, Born_Digital, Material_Received_Date, isnull(DAT.DispositionFuture,'') AS Disposition_Advice, Disposition_Date, isnull(DT.DispositionPast,'') AS Disposition_Type, Locally_Archived, Remotely_Archived, Tracking_Box, AggregationCodes, ItemID, SortTitle, PubDate
	from #TEMP_ITEMS AS T left outer join
		 Tracking_Disposition_Type AS DAT ON T.Disposition_Advice=DAT.DispositionID left outer join
		 Tracking_Disposition_Type AS DT ON T.Disposition_Type=DT.DispositionID;

	-- Return the title information
	select G.BibID, G.SortTitle, TitleID=G.GroupID, [Rank]=-1, G.GroupTitle, G.GroupThumbnail, G.[Type], G.ALEPH_Number, G.OCLC_Number, isnull(G.Primary_Identifier_Type,'') as Primary_Identifier_Type, isnull(G.Primary_Identifier, '') as Primary_Identifier
	from SobekCM_Item_Group G, #TEMP_TITLES I
	where  G.GroupID = I.fk_TitleID
	order by Item_Hit_Count DESC;
	
	select Query = @SQLQuery;
	
	-- drop the temporary tables
	drop table #TEMP_ITEMS;
	drop table #TEMP_TITLES;
	drop table #TEMP1;
	
	Set NoCount OFF;
			
	If @@ERROR <> 0 GoTo ErrorHandler      
		Return(0);
  
ErrorHandler:
    Return(@@ERROR);
	
END;
GO


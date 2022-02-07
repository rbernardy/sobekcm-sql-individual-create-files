USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Create_Full_Citation_Value]    Script Date: 2/6/2022 8:36:35 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



-- Takes all the individual pieces of metadata linked to an item, and then collapses them 
-- all together into a large single value to be stored for the basic searches which do
-- not indicate anything about which field each search term should appear in.
CREATE PROCEDURE [dbo].[SobekCM_Create_Full_Citation_Value]
	@itemid int
AS
begin

	-- Delete the old tracking box from the metadata unique link, since we wil pull
	-- in the latest value from the item table first
	delete from SobekCM_Metadata_Unique_Link 
	where ItemID=@itemid and exists ( select * from SobekCM_Metadata_Unique_Search_Table T where T.MetadataID = SobekCM_Metadata_Unique_Link.MetadataID and T.MetadataTypeID=36);

	-- Copy the tracking box from the item table
	if ( (select LEN(ISNULL(Tracking_Box,'')) from SobekCM_Item where ItemID=@itemid ) > 0 )
	begin
		-- Get the tracking box from the item table
		declare @tracking_box_add nvarchar(max);
		set @tracking_box_add = ( select Tracking_Box from SobekCM_Item where ItemID=@itemid );
		
		-- Save this in the single metadata portion, in case a search is done by 'tracking box'
		exec [SobekCM_Metadata_Save_Single] @itemid, 'Tracking Box', @tracking_box_add;
	end;
	
	-- Delete the old complete citation
	delete from SobekCM_Metadata_Basic_Search_Table
	where ItemID=@itemid;

	-- Prepare to step through each metadata value and build the full citation and also
	-- each individual search value for the 
	declare @singlevalue nvarchar(max);
	declare @metadatatype int;
	declare @fullcitation nvarchar(max);
	declare @title nvarchar(max);
	declare @type nvarchar(max);
	declare @language nvarchar(max);
	declare @creator nvarchar(max);
	declare @publisher nvarchar(max);
	declare @publication_place nvarchar(max);
	declare @subject_keyword nvarchar(max);
	declare @genre nvarchar(max);
	declare @target_audience nvarchar(max);
	declare @spatial_coverage nvarchar(max);
	declare @country nvarchar(max);
	declare @state nvarchar(max);
	declare @county nvarchar(max);
	declare @city nvarchar(max);
	declare @source_institution nvarchar(max);
	declare @holding_location nvarchar(max);
	declare @identifier nvarchar(max);
	declare @notes nvarchar(max);
	declare @other_citation nvarchar(max);
	declare @tickler nvarchar(max);
	declare @donor nvarchar(max);
	declare @format nvarchar(max);
	declare @bibid nvarchar(max);
	declare @publication_date nvarchar(max);
	declare @affiliation nvarchar(max);
	declare @frequency nvarchar(max);
	declare @name_as_subject nvarchar(max);
	declare @title_as_subject nvarchar(max);
	declare @all_subjects nvarchar(max);
	declare @temporal_subject nvarchar(max);
	declare @attribution nvarchar(max);
	declare @user_description nvarchar(max);
	declare @temporal_decade nvarchar(max);
	declare @mime_type nvarchar(max);
	declare @tracking_box nvarchar(max);
	declare @abstract nvarchar(max);
	declare @edition nvarchar(max);
	declare @toc nvarchar(max);
	declare @zt_kingdom nvarchar(max);
	declare @zt_phylum nvarchar(max);
	declare @zt_class nvarchar(max);
	declare @zt_order nvarchar(max);
	declare @zt_family nvarchar(max);
	declare @zt_genus nvarchar(max);
	declare @zt_species nvarchar(max);
	declare @zt_common_name nvarchar(max);
	declare @zt_scientific_name nvarchar(max);
	declare @zt_all_taxonomy nvarchar(max);
	declare @cultural_context nvarchar(max);
	declare @inscription nvarchar(max);
	declare @material nvarchar(max);
	declare @style_period nvarchar(max);
	declare @technique nvarchar(max);
	declare @accession_number nvarchar(max);
	declare @interviewee nvarchar(max);
	declare @interviewer nvarchar(max);
	declare @temporal_year nvarchar(max);
	declare @etd_committee nvarchar(max);
	declare @etd_degree nvarchar(max);
	declare @etd_degree_discipline nvarchar(max);
	declare @etd_degree_grantor nvarchar(max);
	declare @etd_degree_level nvarchar(max);
	declare @etd_degree_division nvarchar(max);
	declare @userdefined01 nvarchar(max);
	declare @userdefined02 nvarchar(max);
	declare @userdefined03 nvarchar(max);
	declare @userdefined04 nvarchar(max);
	declare @userdefined05 nvarchar(max);
	declare @userdefined06 nvarchar(max);
	declare @userdefined07 nvarchar(max);
	declare @userdefined08 nvarchar(max);
	declare @userdefined09 nvarchar(max);
	declare @userdefined10 nvarchar(max);
	declare @userdefined11 nvarchar(max);
	declare @userdefined12 nvarchar(max);
	declare @userdefined13 nvarchar(max);
	declare @userdefined14 nvarchar(max);
	declare @userdefined15 nvarchar(max);
	declare @userdefined16 nvarchar(max);
	declare @userdefined17 nvarchar(max);
	declare @userdefined18 nvarchar(max);
	declare @userdefined19 nvarchar(max);
	declare @userdefined20 nvarchar(max);
	declare @userdefined21 nvarchar(max);
	declare @userdefined22 nvarchar(max);
	declare @userdefined23 nvarchar(max);
	declare @userdefined24 nvarchar(max);
	declare @userdefined25 nvarchar(max);
	declare @userdefined26 nvarchar(max);
	declare @userdefined27 nvarchar(max);
	declare @userdefined28 nvarchar(max);
	declare @userdefined29 nvarchar(max);
	declare @userdefined30 nvarchar(max);
	declare @userdefined31 nvarchar(max);
	declare @userdefined32 nvarchar(max);
	declare @userdefined33 nvarchar(max);
	declare @userdefined34 nvarchar(max);
	declare @userdefined35 nvarchar(max);
	declare @userdefined36 nvarchar(max);
	declare @userdefined37 nvarchar(max);
	declare @userdefined38 nvarchar(max);
	declare @userdefined39 nvarchar(max);
	declare @userdefined40 nvarchar(max);
	declare @userdefined41 nvarchar(max);
	declare @userdefined42 nvarchar(max);
	declare @userdefined43 nvarchar(max);
	declare @userdefined44 nvarchar(max);
	declare @userdefined45 nvarchar(max);
	declare @userdefined46 nvarchar(max);
	declare @userdefined47 nvarchar(max);
	declare @userdefined48 nvarchar(max);
	declare @userdefined49 nvarchar(max);
	declare @userdefined50 nvarchar(max);
	declare @userdefined51 nvarchar(max);
	declare @userdefined52 nvarchar(max);	
	declare @publisher_display nvarchar(max);
	declare @spatial_display nvarchar(max);
	declare @measurement nvarchar(max);
	declare @subject_display nvarchar(max);
	declare @aggregations nvarchar(max);	
	declare @lom_aggregation nvarchar(max);	
	declare @lom_context nvarchar(max);
	declare @lom_classification nvarchar(max);
	declare @lom_difficulty nvarchar(max);
	declare @lom_user nvarchar(max);
	declare @lom_interactivity_level nvarchar(max);
	declare @lom_interactivity_type nvarchar(max);
	declare @lom_status nvarchar(max);
	declare @lom_requirements nvarchar(max);
	declare @lom_agerange nvarchar(max);

	
	
	set @fullcitation='';
	set @title='';
	set @type='';
	set @language='';
	set @creator='';
	set @publisher='';
	set @publication_place='';
	set @subject_keyword='';
	set @genre='';
	set @target_audience='';
	set @spatial_coverage='';
	set @country='';
	set @state='';
	set @county='';
	set @city='';
	set @source_institution='';
	set @holding_location='';
	set @identifier='';
	set @notes='';
	set @other_citation='';
	set @tickler='';
	set @donor='';
	set @format='';
	set @bibid='';
	set @publication_date='';
	set @affiliation='';
	set @frequency='';
	set @name_as_subject='';
	set @title_as_subject='';
	set @all_subjects='';
	set @temporal_subject='';
	set @attribution='';
	set @user_description='';
	set @temporal_decade='';
	set @mime_type='';
	set @tracking_box='';
	set @abstract='';
	set @edition='';
	set @toc='';
	set @zt_kingdom='';
	set @zt_phylum='';
	set @zt_class='';
	set @zt_order='';
	set @zt_family='';
	set @zt_genus='';
	set @zt_species='';
	set @zt_common_name='';
	set @zt_scientific_name='';
	set @zt_all_taxonomy='';
	set @cultural_context='';
	set @inscription='';
	set @material='';
	set @style_period='';
	set @technique='';
	set @accession_number='';
	set @interviewee ='';
	set @interviewer ='';
	set @temporal_year ='';
	set @etd_committee ='';
	set @etd_degree ='';
	set @etd_degree_discipline ='';
	set @etd_degree_grantor ='';
	set @etd_degree_level ='';
	set @etd_degree_division ='';
	set @userdefined01 ='';
	set @userdefined02 ='';
	set @userdefined03 ='';
	set @userdefined04 ='';
	set @userdefined05 ='';
	set @userdefined06 ='';
	set @userdefined07 ='';
	set @userdefined08 ='';
	set @userdefined09 ='';
	set @userdefined10 ='';
	set @userdefined11 ='';
	set @userdefined12 ='';
	set @userdefined13 ='';
	set @userdefined14 ='';
	set @userdefined15 ='';
	set @userdefined16 ='';
	set @userdefined17 ='';
	set @userdefined18 ='';
	set @userdefined19 ='';
	set @userdefined20 ='';
	set @userdefined21 ='';
	set @userdefined22 ='';
	set @userdefined23 ='';
	set @userdefined24 ='';
	set @userdefined25 ='';
	set @userdefined26 ='';
	set @userdefined27 ='';
	set @userdefined28 ='';
	set @userdefined29 ='';
	set @userdefined30 ='';
	set @userdefined31 ='';
	set @userdefined32 ='';
	set @userdefined33 ='';
	set @userdefined34 ='';
	set @userdefined35 ='';
	set @userdefined36 ='';
	set @userdefined37 ='';
	set @userdefined38 ='';
	set @userdefined39 ='';
	set @userdefined40 ='';
	set @userdefined41 ='';
	set @userdefined42 ='';
	set @userdefined43 ='';
	set @userdefined44 ='';
	set @userdefined45 ='';
	set @userdefined46 ='';
	set @userdefined47 ='';
	set @userdefined48 ='';
	set @userdefined49 ='';
	set @userdefined50 ='';
	set @userdefined51 ='';
	set @userdefined52 ='';
	set @publisher_display ='';
	set @spatial_display ='';
	set @measurement ='';
	set @subject_display ='';
	set @aggregations ='';	
	set @lom_aggregation ='';
	set @lom_context ='';
	set @lom_classification ='';
	set @lom_difficulty ='';
	set @lom_user ='';
	set @lom_interactivity_level ='';
	set @lom_interactivity_type ='';;
	set @lom_status ='';
	set @lom_requirements ='';
	set @lom_agerange ='';
		
	-- Use a cursor to step through all the metadata linked to this item
	declare metadatacursor cursor read_only
	for (select MetadataValue, MetadataTypeID
	    from SobekCM_Metadata_Unique_Search_Table M, SobekCM_Metadata_Unique_Link L
	    where L.ItemID=@itemid 
	      and L.MetadataID = M.MetadataID
	      and M.MetadataTypeID != 35);

	-- Open the cursor to begin stepping through all the unique metadata
	open metadatacursor;

	-- Get the first metadata value
	fetch next from metadatacursor into @singlevalue, @metadatatype;

	while @@fetch_status = 0
	begin
		-- Build the full citation by adding each single value to the full citation
		-- being built
		set @fullcitation = @fullcitation + ' | ' + @singlevalue;
		
		-- Now, build each smaller metadata value
		if ( @metadatatype = 1 ) set @title=@title + ' | ' + @singlevalue;
		if ( @metadatatype = 2 ) set @type=@type + ' | ' + @singlevalue;
		if ( @metadatatype = 3 ) set @language=@language + ' | ' + @singlevalue;
		if ( @metadatatype = 4 ) set @creator=@creator + ' | ' + @singlevalue;
		if ( @metadatatype = 5 ) set @publisher=@publisher + ' | ' + @singlevalue;
		if ( @metadatatype = 6 ) set @publication_place=@publication_place + ' | ' + @singlevalue;
		if ( @metadatatype = 7 ) set @subject_keyword=@subject_keyword + ' | ' + @singlevalue;
		if ( @metadatatype = 8 ) set @genre=@genre + ' | ' + @singlevalue;
		if ( @metadatatype = 9 ) set @target_audience=@target_audience + ' | ' + @singlevalue;
		if ( @metadatatype = 10 ) set @spatial_coverage=@spatial_coverage + ' | ' + @singlevalue;
		if ( @metadatatype = 11 ) set @country=@country + ' | ' + @singlevalue;
		if ( @metadatatype = 12 ) set @state=@state + ' | ' + @singlevalue;
		if ( @metadatatype = 13 ) set @county=@county + ' | ' + @singlevalue;
		if ( @metadatatype = 14 ) set @city=@city + ' | ' + @singlevalue;
		if ( @metadatatype = 15 ) set @source_institution=@source_institution + ' | ' + @singlevalue;
		if ( @metadatatype = 16 ) set @holding_location=@holding_location + ' | ' + @singlevalue;
		if ( @metadatatype = 17 ) set @identifier=@identifier + ' | ' + @singlevalue;
		if ( @metadatatype = 18 ) set @notes=@notes + ' | ' + @singlevalue;
		if ( @metadatatype = 19 ) set @other_citation=@other_citation + ' | ' + @singlevalue;
		if ( @metadatatype = 20 ) set @tickler=@tickler + ' | ' + @singlevalue;
		if ( @metadatatype = 21 ) set @donor=@donor + ' | ' + @singlevalue;
		if ( @metadatatype = 22 ) set @format=@format + ' | ' + @singlevalue;
		if ( @metadatatype = 23 ) set @bibid=@bibid + ' | ' + @singlevalue;
		if ( @metadatatype = 24 ) set @publication_date=@publication_date + ' | ' + @singlevalue;
		if ( @metadatatype = 25 ) set @affiliation=@affiliation + ' | ' + @singlevalue;
		if ( @metadatatype = 26 ) set @frequency=@frequency + ' | ' + @singlevalue;
		if ( @metadatatype = 27 ) set @name_as_subject=@name_as_subject + ' | ' + @singlevalue;
		if ( @metadatatype = 28 ) set @title_as_subject=@title_as_subject + ' | ' + @singlevalue;
		if ( @metadatatype = 29 ) set @all_subjects=@all_subjects + ' | ' + @singlevalue;
		if ( @metadatatype = 30 ) set @temporal_subject=@temporal_subject + ' | ' + @singlevalue;
		if ( @metadatatype = 31 ) set @attribution=@attribution + ' | ' + @singlevalue;
		if ( @metadatatype = 32 ) set @user_description=@user_description + ' | ' + @singlevalue;
		if ( @metadatatype = 33 ) set @temporal_decade=@temporal_decade + ' | ' + @singlevalue;
		if ( @metadatatype = 34 ) set @mime_type=@mime_type + ' | ' + @singlevalue;
		if ( @metadatatype = 36 ) set @tracking_box=@tracking_box + ' | ' + @singlevalue;
		if ( @metadatatype = 37 ) set @abstract=@abstract + ' | ' + @singlevalue;
		if ( @metadatatype = 38 ) set @edition=@edition + ' | ' + @singlevalue;
		if ( @metadatatype = 39 ) set @toc=@toc + ' | ' + @singlevalue;
		if ( @metadatatype = 40 ) set @zt_kingdom=@zt_kingdom + ' | ' + @singlevalue;
		if ( @metadatatype = 41 ) set @zt_phylum=@zt_phylum + ' | ' + @singlevalue;
		if ( @metadatatype = 42 ) set @zt_class=@zt_class + ' | ' + @singlevalue;
		if ( @metadatatype = 43 ) set @zt_order=@zt_order + ' | ' + @singlevalue;
		if ( @metadatatype = 44 ) set @zt_family=@zt_family + ' | ' + @singlevalue;
		if ( @metadatatype = 45 ) set @zt_genus=@zt_genus + ' | ' + @singlevalue;
		if ( @metadatatype = 46 ) set @zt_species=@zt_species + ' | ' + @singlevalue;
		if ( @metadatatype = 47 ) set @zt_common_name=@zt_common_name + ' | ' + @singlevalue;
		if ( @metadatatype = 48 ) set @zt_scientific_name=@zt_scientific_name + ' | ' + @singlevalue;
		if ( @metadatatype = 49 ) set @zt_all_taxonomy=@zt_all_taxonomy + ' | ' + @singlevalue;
		if ( @metadatatype = 50 ) set @cultural_context=@cultural_context + ' | ' + @singlevalue;
		if ( @metadatatype = 51 ) set @inscription=@inscription + ' | ' + @singlevalue;
		if ( @metadatatype = 52 ) set @material=@material + ' | ' + @singlevalue;
		if ( @metadatatype = 53 ) set @style_period=@style_period + ' | ' + @singlevalue;
		if ( @metadatatype = 54 ) set @technique=@technique + ' | ' + @singlevalue;
		if ( @metadatatype = 55 ) set @accession_number=@accession_number + ' | ' + @singlevalue;
		if ( @metadatatype = 62 ) set @interviewee = @interviewee + ' | ' + @singlevalue;
		if ( @metadatatype = 63 ) set @interviewer = @interviewer + ' | ' + @singlevalue;
		if ( @metadatatype = 61 ) set @temporal_year = @temporal_year + ' | ' + @singlevalue;
		if ( @metadatatype = 56 ) set @etd_committee = @etd_committee + ' | ' + @singlevalue;
		if ( @metadatatype = 57 ) set @etd_degree = @etd_degree + ' | ' + @singlevalue;
		if ( @metadatatype = 58 ) set @etd_degree_discipline = @etd_degree_discipline + ' | ' + @singlevalue;
		if ( @metadatatype = 59 ) set @etd_degree_grantor = @etd_degree_grantor + ' | ' + @singlevalue;
		if ( @metadatatype = 60 ) set @etd_degree_level = @etd_degree_level + ' | ' + @singlevalue;
		if ( @metadatatype = 64 ) set @userdefined01 = @userdefined01 + ' | ' + @singlevalue;
		if ( @metadatatype = 65 ) set @userdefined02 = @userdefined02 + ' | ' + @singlevalue;
		if ( @metadatatype = 66 ) set @userdefined03 = @userdefined03 + ' | ' + @singlevalue;
		if ( @metadatatype = 67 ) set @userdefined04 = @userdefined04 + ' | ' + @singlevalue;
		if ( @metadatatype = 68 ) set @userdefined05 = @userdefined05 + ' | ' + @singlevalue;
		if ( @metadatatype = 69 ) set @userdefined06 = @userdefined06 + ' | ' + @singlevalue;
		if ( @metadatatype = 70 ) set @userdefined07 = @userdefined07 + ' | ' + @singlevalue;
		if ( @metadatatype = 71 ) set @userdefined08 = @userdefined08 + ' | ' + @singlevalue;
		if ( @metadatatype = 72 ) set @userdefined09 = @userdefined09 + ' | ' + @singlevalue;
		if ( @metadatatype = 73 ) set @userdefined10 = @userdefined10 + ' | ' + @singlevalue;
		if ( @metadatatype = 74 ) set @userdefined11 = @userdefined11 + ' | ' + @singlevalue;
		if ( @metadatatype = 75 ) set @userdefined12 = @userdefined12 + ' | ' + @singlevalue;
		if ( @metadatatype = 76 ) set @userdefined13 = @userdefined13 + ' | ' + @singlevalue;
		if ( @metadatatype = 77 ) set @userdefined14 = @userdefined14 + ' | ' + @singlevalue;
		if ( @metadatatype = 78 ) set @userdefined15 = @userdefined15 + ' | ' + @singlevalue;
		if ( @metadatatype = 79 ) set @userdefined16 = @userdefined16 + ' | ' + @singlevalue;
		if ( @metadatatype = 80 ) set @userdefined17 = @userdefined17 + ' | ' + @singlevalue;
		if ( @metadatatype = 81 ) set @userdefined18 = @userdefined18 + ' | ' + @singlevalue;
		if ( @metadatatype = 82 ) set @userdefined19 = @userdefined19 + ' | ' + @singlevalue;
		if ( @metadatatype = 83 ) set @userdefined20 = @userdefined20 + ' | ' + @singlevalue;
		if ( @metadatatype = 84 ) set @userdefined21 = @userdefined21 + ' | ' + @singlevalue;
		if ( @metadatatype = 85 ) set @userdefined22 = @userdefined22 + ' | ' + @singlevalue;
		if ( @metadatatype = 86 ) set @userdefined23 = @userdefined23 + ' | ' + @singlevalue;
		if ( @metadatatype = 87 ) set @userdefined24 = @userdefined24 + ' | ' + @singlevalue;
		if ( @metadatatype = 88 ) set @userdefined25 = @userdefined25 + ' | ' + @singlevalue;
		if ( @metadatatype = 89 ) set @userdefined26 = @userdefined26 + ' | ' + @singlevalue;
		if ( @metadatatype = 90 ) set @userdefined27 = @userdefined27 + ' | ' + @singlevalue;
		if ( @metadatatype = 91 ) set @userdefined28 = @userdefined28 + ' | ' + @singlevalue;
		if ( @metadatatype = 92 ) set @userdefined29 = @userdefined29 + ' | ' + @singlevalue;
		if ( @metadatatype = 93 ) set @userdefined30 = @userdefined30 + ' | ' + @singlevalue;
		if ( @metadatatype = 94 ) set @userdefined31 = @userdefined31 + ' | ' + @singlevalue;
		if ( @metadatatype = 95 ) set @userdefined32 = @userdefined32 + ' | ' + @singlevalue;
		if ( @metadatatype = 96 ) set @userdefined33 = @userdefined33 + ' | ' + @singlevalue;
		if ( @metadatatype = 97 ) set @userdefined34 = @userdefined34 + ' | ' + @singlevalue;
		if ( @metadatatype = 98 ) set @userdefined35 = @userdefined35 + ' | ' + @singlevalue;
		if ( @metadatatype = 99 ) set @userdefined36 = @userdefined36 + ' | ' + @singlevalue;
		if ( @metadatatype = 100 ) set @userdefined37 = @userdefined37 + ' | ' + @singlevalue;
		if ( @metadatatype = 101 ) set @userdefined38 = @userdefined38 + ' | ' + @singlevalue;
		if ( @metadatatype = 102 ) set @userdefined39 = @userdefined39 + ' | ' + @singlevalue;
		if ( @metadatatype = 103 ) set @userdefined40 = @userdefined40 + ' | ' + @singlevalue;
		if ( @metadatatype = 104 ) set @userdefined41 = @userdefined41 + ' | ' + @singlevalue;
		if ( @metadatatype = 105 ) set @userdefined42 = @userdefined42 + ' | ' + @singlevalue;
		if ( @metadatatype = 106 ) set @userdefined43 = @userdefined43 + ' | ' + @singlevalue;
		if ( @metadatatype = 107 ) set @userdefined44 = @userdefined44 + ' | ' + @singlevalue;
		if ( @metadatatype = 108 ) set @userdefined45 = @userdefined45 + ' | ' + @singlevalue;
		if ( @metadatatype = 109 ) set @userdefined46 = @userdefined46 + ' | ' + @singlevalue;
		if ( @metadatatype = 110 ) set @userdefined47 = @userdefined47 + ' | ' + @singlevalue;
		if ( @metadatatype = 111 ) set @userdefined48 = @userdefined48 + ' | ' + @singlevalue;
		if ( @metadatatype = 112 ) set @userdefined49 = @userdefined49 + ' | ' + @singlevalue;
		if ( @metadatatype = 113 ) set @userdefined50 = @userdefined50 + ' | ' + @singlevalue;
		if ( @metadatatype = 114 ) set @userdefined51 = @userdefined51 + ' | ' + @singlevalue;
		if ( @metadatatype = 115 ) set @userdefined52 = @userdefined52 + ' | ' + @singlevalue;	
		if ( @metadatatype = 116 ) set @publisher_display = @publisher_display + ' | ' + @singlevalue;
		if ( @metadatatype = 117 ) set @spatial_display = @spatial_display + ' | ' + @singlevalue;
		if ( @metadatatype = 118 ) set @measurement = @measurement + ' | ' + @singlevalue;
		if ( @metadatatype = 119 ) set @subject_display = @subject_display + ' | ' + @singlevalue;
		if ( @metadatatype = 120 ) set @aggregations = @aggregations + ' | ' + @singlevalue;
		if ( @metadatatype = 121 ) set @lom_aggregation = @lom_aggregation + ' | ' + @singlevalue;
		if ( @metadatatype = 122 ) set @lom_context = @lom_context + ' | ' + @singlevalue;
		if ( @metadatatype = 123 ) set @lom_classification = @lom_classification + ' | ' + @singlevalue;
		if ( @metadatatype = 124 ) set @lom_difficulty = @lom_difficulty + ' | ' + @singlevalue;
		if ( @metadatatype = 125 ) set @lom_user = @lom_user + ' | ' + @singlevalue;
		if ( @metadatatype = 126 ) set @lom_interactivity_level = @lom_interactivity_level + ' | ' + @singlevalue;
		if ( @metadatatype = 127 ) set @lom_interactivity_type = @lom_interactivity_type + ' | ' + @singlevalue;
		if ( @metadatatype = 128 ) set @lom_status = @lom_status + ' | ' + @singlevalue;
		if ( @metadatatype = 129 ) set @lom_requirements = @lom_requirements + ' | ' + @singlevalue;
		if ( @metadatatype = 130 ) set @lom_agerange = @lom_agerange + ' | ' + @singlevalue;
		if ( @metadatatype = 131 ) set @etd_degree_division = @etd_degree_division + ' | ' + @singlevalue;
	
		-- Get the next value
		fetch next from metadatacursor into @singlevalue, @metadatatype;

	end;

	-- Close and deallocate the cursor which was used
	close metadatacursor;
	deallocate metadatacursor;
	
	-- Get the sortdate
	declare @sortdate bigint;
	set @sortdate = ( select SortDate from SobekCM_Item where ItemID=@itemid);

	-- Insert the newly created full citation for this item
	insert into SobekCM_Metadata_Basic_Search_Table ( ItemID, FullCitation, Title, [Type], [Language], Creator, Publisher, Publication_Place, Subject_Keyword, Genre, Target_Audience, Spatial_Coverage, Country, [State], County, City, Source_Institution, Holding_Location, Notes, Other_Citation, Tickler, Donor, Format, BibID, Publication_Date, Affiliation, Frequency, Name_as_Subject, Title_as_Subject, All_Subjects, Temporal_Subject, Attribution, User_Description, Temporal_Decade, MIME_Type, Tracking_Box, Abstract, Edition, TOC, ZT_Kingdom, ZT_Phylum, ZT_Class, ZT_Order, ZT_Family, ZT_Genus, ZT_Species, ZT_Common_Name, ZT_Scientific_Name, ZT_All_Taxonomy, Cultural_Context, Inscription, Material, Style_Period, Technique, Accession_Number, Interviewee, Interviewer, Temporal_Year, ETD_Committee, ETD_Degree, ETD_Degree_Discipline, ETD_Degree_Grantor, ETD_Degree_Level, UserDefined01, UserDefined02, UserDefined03, UserDefined04, UserDefined05, UserDefined06, UserDefined07, UserDefined08, UserDefined09, UserDefined10, UserDefined11, UserDefined12, UserDefined13, UserDefined14, UserDefined15, UserDefined16, UserDefined17, UserDefined18, UserDefined19, UserDefined20, UserDefined21, UserDefined22, UserDefined23, UserDefined24, UserDefined25, UserDefined26, UserDefined27, UserDefined28, UserDefined29, UserDefined30, UserDefined31, UserDefined32, UserDefined33, UserDefined34, UserDefined35, UserDefined36, UserDefined37, UserDefined38, UserDefined39, UserDefined40, UserDefined41, UserDefined42, UserDefined43, UserDefined44, UserDefined45, UserDefined46, UserDefined47, UserDefined48, UserDefined49, UserDefined50, UserDefined51, UserDefined52, [Publisher.Display], [Spatial_Coverage.Display], Measurements, [Subjects.Display], Aggregations, LOM_Aggregation, LOM_Context, LOM_Classification, LOM_Difficulty, LOM_Intended_End_User, LOM_Interactivity_Level, LOM_Interactivity_Type, LOM_Status, LOM_Requirement, LOM_AgeRange, ETD_Degree_Division, SortDate )
	values ( @itemid, @fullcitation + ' | ', @title , @type , @language , @creator , @publisher , @publication_place , @subject_keyword , @genre , @target_audience , @spatial_coverage , @country , @state , @county , @city , @source_institution , @holding_location , @notes , @other_citation , @tickler , @donor , @format , @bibid , @publication_date , @affiliation , @frequency , @name_as_subject , @title_as_subject , @all_subjects , @temporal_subject , @attribution , @user_description , @temporal_decade , @mime_type , @tracking_box , @abstract , @edition , @toc , @zt_kingdom , @zt_phylum , @zt_class , @zt_order , @zt_family , @zt_genus , @zt_species , @zt_common_name , @zt_scientific_name , @zt_all_taxonomy , @cultural_context , @inscription , @material , @style_period , @technique , @accession_number, @interviewee, @interviewer, @temporal_year, @etd_committee, @etd_degree, @etd_degree_discipline, @etd_degree_grantor, @etd_degree_level, @userdefined01, @userdefined02, @userdefined03, @userdefined04, @userdefined05, @userdefined06, @userdefined07, @userdefined08, @userdefined09, @userdefined10, @userdefined11, @userdefined12, @userdefined13, @userdefined14, @userdefined15, @userdefined16, @userdefined17, @userdefined18, @userdefined19, @userdefined20, @userdefined21, @userdefined22, @userdefined23, @userdefined24, @userdefined25, @userdefined26, @userdefined27, @userdefined28, @userdefined29, @userdefined30, @userdefined31, @userdefined32, @userdefined33, @userdefined34, @userdefined35, @userdefined36, @userdefined37, @userdefined38, @userdefined39, @userdefined40, @userdefined41, @userdefined42, @userdefined43, @userdefined44, @userdefined45, @userdefined46, @userdefined47, @userdefined48, @userdefined49, @userdefined50, @userdefined51, @userdefined52, @publisher_display, @spatial_display, @measurement, @subject_display, @aggregations, @lom_aggregation, @lom_context, @lom_classification, @lom_difficulty, @lom_user, @lom_interactivity_level, @lom_interactivity_type, @lom_status, @lom_requirements, @lom_agerange, @etd_degree_division, @sortdate );

	-- Compute the overall spatial footprint string and distance
	with ItemPoints as
	(
		select Point_Latitude as Latitude, Point_Longitude as Longitude
		from SobekCM_Item_Footprint
		where ( ItemID=@itemID )
		  and ( Point_Latitude is not null )
		  and ( Point_Longitude is not null )
		union
		select Rect_Latitude_A, Rect_Longitude_A
		from SobekCM_Item_Footprint
		where ( ItemID=@itemID )
		  and ( Rect_Latitude_A is not null )
		  and ( Rect_Longitude_A is not null )
		union
		select Rect_Latitude_B, Rect_Longitude_B
		from SobekCM_Item_Footprint
		where ( ItemID=@itemID )
		  and ( Rect_Latitude_B is not null )
		  and ( Rect_Longitude_B is not null )
	), MinMaxItemPoints as
	(
		select Min(Latitude) as Min_Latitude, 
			   Max(Latitude) as Max_Latitude, 
			   Min(Longitude) as Min_Longitude, 
			   Max(Longitude) as Max_Longitude
		from ItemPoints
	)
	select CASE WHEN Min_Latitude=Max_Latitude and Min_Longitude=Max_Longitude THEN 'P|' + cast(Min_Latitude as varchar(20)) + '|' + cast(Min_Longitude as varchar(20))
				ELSE 'A|' + cast(Min_Latitude as varchar(20)) + '|' + cast(Min_Longitude as varchar(20)) + '|' + cast(Max_Latitude as varchar(20)) + '|' + cast(Max_Longitude as varchar(20))
		   END as SpatialFootprint,
		   Square(Max_Latitude - Min_Latitude ) + Square(Max_Longitude-Min_Longitude) as SpatialFootprintDistance
	into #FinalValues
    from MinMaxItemPoints;

	update SobekCM_Item 
	set SpatialFootprint= coalesce(( select SpatialFootprint from #FinalValues ),''),
	    SpatialFootprintDistance = coalesce(( select SpatialFootprintDistance from #FinalValues ), 999)
	where ItemID=@ItemID;

	drop table #FinalValues;
	
end;
GO


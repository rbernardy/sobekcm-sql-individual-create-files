USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Save_Item]    Script Date: 2/22/2022 9:01:27 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Saves all the main data about an item in UFDC (but not behaviors)
-- Written by Mark Sullivan ( September 2005, Edited Decemver 2016 )
CREATE PROCEDURE [dbo].[SobekCM_Save_Item]
	@GroupID int,
	@VID varchar(5),
	@PageCount int,
	@FileCount int,
	@Title nvarchar(500),
	@SortTitle nvarchar(500), --NEW
	@AccessMethod int,
	@Link varchar(500),
	@CreateDate datetime,
	@PubDate nvarchar(100),
	@SortDate bigint,
	@HoldingCode varchar(20),
	@SourceCode varchar(20),
	@Author nvarchar(1000),
	@Spatial_KML varchar(4000),
	@Spatial_KML_Distance float,
	@DiskSize_KB bigint,
	@Spatial_Display nvarchar(1000), 
	@Institution_Display nvarchar(1000), 
	@Edition_Display nvarchar(1000),
	@Material_Display nvarchar(1000),
	@Measurement_Display nvarchar(1000), 
	@StylePeriod_Display nvarchar(1000), 
	@Technique_Display nvarchar(1000), 
	@Subjects_Display nvarchar(1000), 
	@Donor nvarchar(250),
	@Publisher nvarchar(1000),
	@ItemID int output,
	@Existing bit output,
	@New_VID varchar(5) output
AS
begin transaction

	-- Set the return VID value first
	set @New_VID = @VID;

	-- If this already exists (BibID, VID) then just update
	if ( (	 select count(*) from SobekCM_Item I where ( I.VID = @VID ) and ( I.GroupID = @GroupID ) )  > 0 )
	begin
		-- Save the item id
		select @ItemID = I.ItemID
		from SobekCM_Item I
		where  ( I.VID = @VID ) and ( I.GroupID = @GroupID );

		--Update the main item
		update SobekCM_Item
		set [PageCount] = @PageCount, 
			Deleted = 0, Title=@Title, SortTitle=@SortTitle, AccessMethod=@AccessMethod, Link=@Link,
			PubDate=@PubDate, SortDate=@SortDate, FileCount=@FileCount, Author=@Author, 
			Spatial_KML=@Spatial_KML, Spatial_KML_Distance=@Spatial_KML_Distance,  
			Donor=@Donor, Publisher=@Publisher, 
			GroupID = GroupID, LastSaved=GETDATE(), Spatial_Display=@Spatial_Display, Institution_Display=@Institution_Display, 
			Edition_Display=@Edition_Display, Material_Display=@Material_Display, Measurement_Display=@Measurement_Display, 
			StylePeriod_Display=@StylePeriod_Display, Technique_Display=@Technique_Display, Subjects_Display=@Subjects_Display 
		where ( ItemID = @ItemID );

		-- Set the existing flag to true (1)
		set @Existing = 1;
	end
	else
	begin
	
		-- Verify the VID is a complete bibid, otherwise find the next one
		if ( LEN(@VID) < 5 )
		begin
			declare @next_vid_number int;

			-- Find the next vid number
			select @next_vid_number = isnull(CAST(MAX(VID) as int) + 1,-1)
			from SobekCM_Item
			where GroupID = @GroupID;
			
			-- If no matches to this BibID, just start at 00001
			if ( @next_vid_number < 0 )
			begin
				select @New_VID = '00001';
			end
			else
			begin
				select @New_VID = RIGHT('0000' + (CAST( @next_vid_number as varchar(5))), 5);	
			end;	
		end;
		
		-- Add the values to the main SobekCM_Item table first
		insert into SobekCM_Item ( VID, [PageCount], FileCount, Deleted, Title, SortTitle, AccessMethod, Link, CreateDate, PubDate, SortDate, Author, Spatial_KML, Spatial_KML_Distance, GroupID, LastSaved, Donor, Publisher, Spatial_Display, Institution_Display, Edition_Display, Material_Display, Measurement_Display, StylePeriod_Display, Technique_Display, Subjects_Display )
		values (  @New_VID, @PageCount, @FileCount, 0, @Title, @SortTitle, @AccessMethod, @Link, @CreateDate, @PubDate, @SortDate, @Author, @Spatial_KML, @Spatial_KML_Distance, @GroupID, GETDATE(), @Donor, @Publisher, @Spatial_Display, @Institution_Display, @Edition_Display, @Material_Display, @Measurement_Display, @StylePeriod_Display, @Technique_Display, @Subjects_Display  );

		-- Get the item id identifier for this row
		set @ItemID = @@identity;

		-- Set existing flag to false
		set @Existing = 0;
		
		-- Copy over all the default viewer information
		insert into SobekCM_Item_Viewers ( ItemID, ItemViewTypeID, Attribute, Label, Exclude )
		select @itemid, ItemViewTypeID, '', '', 'false' 
		from SobekCM_Item_Viewer_Types
		where ( DefaultView = 'true' );
	end;

	-- Check for Holding Institution Code
	declare @AggregationID int;
	if ( len ( isnull ( @HoldingCode, '' ) ) > 0 )
	begin
		-- Does this institution already exist?
		if (( select count(*) from SobekCM_Item_Aggregation where Code = @HoldingCode ) = 0 )
		begin
			-- Add new institution
			insert into SobekCM_Item_Aggregation ( Code, [Name], ShortName, Description, ThematicHeadingID, [Type], isActive, Hidden, DisplayOptions, Map_Search, Map_Display, OAI_Flag, ContactEmail, HasNewItems )
			values ( @HoldingCode, 'Added automatically', 'Added automatically', 'Added automatically', -1, 'Institution', 'false', 'true', '', 0, 0, 'false', '', 'false' );
		end;
		
		-- Add the link to this holding code ( and any legitimate parent aggregations )
		exec SobekCM_Save_Item_Item_Aggregation_Link @ItemID, @HoldingCode;		
	end;

	-- Check for Source Institution Code
	if ( len ( isnull ( @SourceCode, '' ) ) > 0 )
	begin
		-- Does this institution already exist?
		if (( select count(*) from SobekCM_Item_Aggregation where Code = @SourceCode ) = 0 )
		begin
			-- Add new institution
			insert into SobekCM_Item_Aggregation ( Code, [Name], ShortName, Description, ThematicHeadingID, [Type], isActive, Hidden, DisplayOptions, Map_Search, Map_Display, OAI_Flag, ContactEmail, HasNewItems )
			values ( @SourceCode, 'Added automatically', 'Added automatically', 'Added automatically', -1, 'Institution', 'false', 'true', '', 0, 0, 'false', '', 'false' );
		end;

		-- Add the link to this holding code ( and any legitimate parent aggregations )
		exec SobekCM_Save_Item_Item_Aggregation_Link @ItemID, @SourceCode;	
	end;
	
	-- If a size was included, set that value
	if ( @DiskSize_KB > 0 )
	begin
		update SobekCM_Item set DiskSize_KB = @DiskSize_KB where ItemID=@ItemID;
	end;

	-- Finally set the volume count for this group correctly
	declare @itemcount int;
	set @itemcount = ( select count(*) from SobekCM_Item I where ( I.GroupID = @GroupID ) and ( I.Deleted = 'false' ));

	-- Update the item group count
	update SobekCM_Item_Group
	set ItemCount = @itemcount
	where GroupID = @GroupID;

	-- If this was an update, and this group had only this one VID, look at changing the
	-- group title to match the item title
	if (( @Existing = 1 ) and ( @itemcount = 1 ))
	begin
		-- Only make this update if this is not a SERIAL or NEWSPAPER
		if ( exists ( select 1 from SobekCM_Item_Group where GroupID=@GroupID and [Type] != 'Serial' and [Type] != 'Newspaper' ))
		begin
			update SobekCM_Item_Group 
			set GroupTitle = @Title, SortTitle = @SortTitle
			where GroupID=@GroupID;
		end;
	end;

commit transaction;
GO


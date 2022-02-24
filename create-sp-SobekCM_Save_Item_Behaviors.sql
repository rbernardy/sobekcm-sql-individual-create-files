USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Save_Item_Behaviors]    Script Date: 2/23/2022 8:40:22 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




-- Saves the behavior information about an item in this library
-- Written by Mark Sullivan 
CREATE PROCEDURE [dbo].[SobekCM_Save_Item_Behaviors]
	@ItemID int,
	@TextSearchable bit,
	@MainThumbnail varchar(100),
	@MainJPEG varchar(100),
	@IP_Restriction_Mask smallint,
	@CheckoutRequired bit,
	@Dark_Flag bit,
	@Born_Digital bit,
	@Disposition_Advice int,
	@Disposition_Advice_Notes varchar(150),
	@Material_Received_Date datetime,
	@Material_Recd_Date_Estimated bit,
	@Tracking_Box varchar(25),
	@AggregationCode1 varchar(20),
	@AggregationCode2 varchar(20),
	@AggregationCode3 varchar(20),
	@AggregationCode4 varchar(20),
	@AggregationCode5 varchar(20),
	@AggregationCode6 varchar(20),
	@AggregationCode7 varchar(20),
	@AggregationCode8 varchar(20),
	@HoldingCode varchar(20),
	@SourceCode varchar(20),
	@Icon1_Name varchar(50),
	@Icon2_Name varchar(50),
	@Icon3_Name varchar(50),
	@Icon4_Name varchar(50),
	@Icon5_Name varchar(50),
	@Left_To_Right bit,
	@CitationSet varchar(50)
AS
begin transaction

	--Update the main item
	update SobekCM_Item
	set TextSearchable = @TextSearchable, Deleted = 0, MainThumbnail=@MainThumbnail,
		MainJPEG=@MainJPEG, CheckoutRequired=@CheckoutRequired, IP_Restriction_Mask=@IP_Restriction_Mask,
		Dark=@Dark_Flag, Born_Digital=@Born_Digital, Disposition_Advice=@Disposition_Advice,
		Material_Received_Date=@Material_Received_Date, Material_Recd_Date_Estimated=@Material_Recd_Date_Estimated,
		Tracking_Box=@Tracking_Box, Disposition_Advice_Notes = @Disposition_Advice_Notes, Left_To_Right=@Left_To_Right,
		CitationSet=@CitationSet
	where ( ItemID = @ItemID );

	-- Clear the links to all existing icons
	delete from SobekCM_Item_Icons where ItemID=@ItemID;
	
	-- Add the first icon to this object  (this requires the icons have been pre-established )
	declare @IconID int
	if ( len( isnull( @Icon1_Name, '' )) > 0 ) 
	begin
		-- Get the Icon ID for this icon
		select @IconID = IconID from SobekCM_Icon where Icon_Name = @Icon1_Name;

		-- Tie this item to this icon
		if ( ISNULL(@IconID,-1) > 0 )
		begin
			insert into SobekCM_Item_Icons ( ItemID, IconID, [Sequence] )
			values ( @ItemID, @IconID, 1 );
		end;
	end;

	-- Add the second icon to this object  (this requires the icons have been pre-established )
	if ( len( isnull( @Icon2_Name, '' )) > 0 ) 
	begin
		-- Get the Icon ID for this icon
		select @IconID = IconID from SobekCM_Icon where Icon_Name = @Icon2_Name;

		-- Tie this item to this icon
		if (( ISNULL(@IconID,-1) > 0 )  and ( not exists ( select 1 from SobekCM_Item_Icons where ItemID=@ItemID and IconID=@IconID )))
		begin
			insert into SobekCM_Item_Icons ( ItemID, IconID, [Sequence] )
			values ( @ItemID, @IconID, 2 );
		end;
	end;

	-- Add the third icon to this object  (this requires the icons have been pre-established )
	if ( len( isnull( @Icon3_Name, '' )) > 0 ) 
	begin
		-- Get the Icon ID for this icon
		select @IconID = IconID from SobekCM_Icon where Icon_Name = @Icon3_Name;

		-- Tie this item to this icon
		if (( ISNULL(@IconID,-1) > 0 ) and ( not exists ( select 1 from SobekCM_Item_Icons where ItemID=@ItemID and IconID=@IconID )))
		begin
			insert into SobekCM_Item_Icons ( ItemID, IconID, [Sequence] )
			values ( @ItemID, @IconID, 3 );
		end;
	end;

	-- Add the fourth icon to this object  (this requires the icons have been pre-established )
	if ( len( isnull( @Icon4_Name, '' )) > 0 ) 
	begin
		-- Get the Icon ID for this icon
		select @IconID = IconID from SobekCM_Icon where Icon_Name = @Icon4_Name;
		
		-- Tie this item to this icon
		if (( ISNULL(@IconID,-1) > 0 ) and ( not exists ( select 1 from SobekCM_Item_Icons where ItemID=@ItemID and IconID=@IconID )))
		begin
			insert into SobekCM_Item_Icons ( ItemID, IconID, [Sequence] )
			values ( @ItemID, @IconID, 4 );
		end;
	end;

	-- Add the fifth icon to this object  (this requires the icons have been pre-established )
	if ( len( isnull( @Icon5_Name, '' )) > 0 ) 
	begin
		-- Get the Icon ID for this icon
		select @IconID = IconID from SobekCM_Icon where Icon_Name = @Icon5_Name;

		-- Tie this item to this icon
		if (( ISNULL(@IconID,-1) > 0 ) and ( not exists ( select 1 from SobekCM_Item_Icons where ItemID=@ItemID and IconID=@IconID )))
		begin
			insert into SobekCM_Item_Icons ( ItemID, IconID, [Sequence] )
			values ( @ItemID, @IconID, 5 );
		end;
	end;

	-- Clear all links to aggregations
	delete from SobekCM_Item_Aggregation_Item_Link where ItemID = @ItemID;

	-- Add all of the aggregations
	exec SobekCM_Save_Item_Item_Aggregation_Link @ItemID, @AggregationCode1;
	exec SobekCM_Save_Item_Item_Aggregation_Link @ItemID, @AggregationCode2;
	exec SobekCM_Save_Item_Item_Aggregation_Link @ItemID, @AggregationCode3;
	exec SobekCM_Save_Item_Item_Aggregation_Link @ItemID, @AggregationCode4;
	exec SobekCM_Save_Item_Item_Aggregation_Link @ItemID, @AggregationCode5;
	exec SobekCM_Save_Item_Item_Aggregation_Link @ItemID, @AggregationCode6;
	exec SobekCM_Save_Item_Item_Aggregation_Link @ItemID, @AggregationCode7;
	exec SobekCM_Save_Item_Item_Aggregation_Link @ItemID, @AggregationCode8;
	
	-- Create one string of all the aggregation codes
	declare @aggregationCodes varchar(100);
	set @aggregationCodes = rtrim(isnull(@AggregationCode1,'') + ' ' + isnull(@AggregationCode2,'') + ' ' + isnull(@AggregationCode3,'') + ' ' + isnull(@AggregationCode4,'') + ' ' + isnull(@AggregationCode5,'') + ' ' + isnull(@AggregationCode6,'') + ' ' + isnull(@AggregationCode7,'') + ' ' + isnull(@AggregationCode8,''));
	
	-- Update matching items to have the aggregation codes value
	update SobekCM_Item set AggregationCodes = @aggregationCodes where ItemID=@ItemID;

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

	-- If this is being made public, set the public data
	if (( @Dark_Flag = 'false' ) and ( @IP_Restriction_Mask >= 0 ))
	begin
		update SobekCM_Item 
		set MadePublicDate = coalesce(MadePublicDate, getdate())
		where ItemID=@ItemID;
	end;
	
commit transaction;
GO


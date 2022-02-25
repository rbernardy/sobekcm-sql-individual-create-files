USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Save_Item_Group_Web_Skins]    Script Date: 2/24/2022 10:14:29 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Saves all the web skin data about a group of items in UFDC
-- Written by Mark Sullivan (September 2006, Modified August 2010 )
CREATE PROCEDURE [dbo].[SobekCM_Save_Item_Group_Web_Skins]
	@GroupID int,
	@Primary_WebSkin varchar(20),
	@Alt_WebSkin1 varchar(20),
	@Alt_WebSkin2 varchar(20),
	@Alt_WebSkin3 varchar(20),
	@Alt_WebSkin4 varchar(20),
	@Alt_WebSkin5 varchar(20),
	@Alt_WebSkin6 varchar(20),
	@Alt_WebSkin7 varchar(20),
	@Alt_WebSkin8 varchar(20),
	@Alt_WebSkin9 varchar(20)	
AS
begin transaction

	-- Clear existing web skins
	delete from SobekCM_Item_Group_Web_Skin_Link 
	where GroupID = @GroupID

	-- Add the first web skin to this object  (this requires the web skins have been pre-established )
	declare @InterfaceID int
	if ( len( isnull( @Primary_WebSkin, '' )) > 0 ) 
	begin
		-- Get the Interface ID for this interface
		select @InterfaceID = WebSkinID from SobekCM_Web_Skin where WebSkinCode = @Primary_WebSkin

		-- Ensure this web skin exists
		if ( ISNULL(@InterfaceID,-1) > 0 )
		begin		
			-- Tie this item to this interface
			insert into SobekCM_Item_Group_Web_Skin_Link ( GroupID, WebSkinID, [Sequence] )
			values ( @GroupID, @InterfaceID, 1 )
		end
	end

	-- Add the second web skin to this object  (this requires the web skins have been pre-established )
	if ( len( isnull( @Alt_WebSkin1, '' )) > 0 ) 
	begin	
		-- Get the Interface ID for this interface
		select @InterfaceID = WebSkinID from SobekCM_Web_Skin where WebSkinCode = @Alt_WebSkin1

		-- Ensure this web skin exists
		if ( ISNULL(@InterfaceID,-1) > 0 )
		begin		
			-- Tie this item to this interface
			insert into SobekCM_Item_Group_Web_Skin_Link ( GroupID, WebSkinID, [Sequence] )
			values ( @GroupID, @InterfaceID, 2 )
		end
	end

	-- Add the third web skin to this object  (this requires the web skins have been pre-established )
	if ( len( isnull( @Alt_WebSkin2, '' )) > 0 ) 
	begin		
		-- Get the Interface ID for this interface
		select @InterfaceID = WebSkinID from SobekCM_Web_Skin where WebSkinCode = @Alt_WebSkin2

		-- Ensure this web skin exists
		if ( ISNULL(@InterfaceID,-1) > 0 )
		begin		
			-- Tie this item to this interface
			insert into SobekCM_Item_Group_Web_Skin_Link ( GroupID, WebSkinID, [Sequence] )
			values ( @GroupID, @InterfaceID, 3 )
		end
	end

	-- Add the fourth web skin to this object  (this requires the web skins have been pre-established )
	if ( len( isnull( @Alt_WebSkin3, '' )) > 0 ) 
	begin	
		-- Get the Interface ID for this interface
		select @InterfaceID = WebSkinID from SobekCM_Web_Skin where WebSkinCode = @Alt_WebSkin3

		-- Ensure this web skin exists
		if ( ISNULL(@InterfaceID,-1) > 0 )
		begin		
			-- Tie this item to this interface
			insert into SobekCM_Item_Group_Web_Skin_Link ( GroupID, WebSkinID, [Sequence] )
			values ( @GroupID, @InterfaceID, 4 )
		end
	end
	
	-- Add the fifth web skin to this object  (this requires the web skins have been pre-established )
	if ( len( isnull( @Alt_WebSkin4, '' )) > 0 ) 
	begin	
		-- Get the Interface ID for this interface
		select @InterfaceID = WebSkinID from SobekCM_Web_Skin where WebSkinCode = @Alt_WebSkin4

		-- Ensure this web skin exists
		if ( ISNULL(@InterfaceID,-1) > 0 )
		begin		
			-- Tie this item to this interface
			insert into SobekCM_Item_Group_Web_Skin_Link ( GroupID, WebSkinID, [Sequence] )
			values ( @GroupID, @InterfaceID, 5 )
		end
	end

	-- Add the sixth web skin to this object  (this requires the web skins have been pre-established )
	if ( len( isnull( @Alt_WebSkin5, '' )) > 0 ) 
	begin		
		-- Get the Interface ID for this interface
		select @InterfaceID = WebSkinID from SobekCM_Web_Skin where WebSkinCode = @Alt_WebSkin5

		-- Ensure this web skin exists
		if ( ISNULL(@InterfaceID,-1) > 0 )
		begin		
			-- Tie this item to this interface
			insert into SobekCM_Item_Group_Web_Skin_Link ( GroupID, WebSkinID, [Sequence] )
			values ( @GroupID, @InterfaceID, 6 )
		end
	end

	-- Add the seventh web skin to this object  (this requires the web skins have been pre-established )
	if ( len( isnull( @Alt_WebSkin6, '' )) > 0 ) 
	begin	
		-- Get the Interface ID for this interface
		select @InterfaceID = WebSkinID from SobekCM_Web_Skin where WebSkinCode = @Alt_WebSkin6

		-- Ensure this web skin exists
		if ( ISNULL(@InterfaceID,-1) > 0 )
		begin		
			-- Tie this item to this interface
			insert into SobekCM_Item_Group_Web_Skin_Link ( GroupID, WebSkinID, [Sequence] )
			values ( @GroupID, @InterfaceID, 7 )
		end
	end

-- Add the eight web skin to this object  (this requires the web skins have been pre-established )
	if ( len( isnull( @Alt_WebSkin7, '' )) > 0 ) 
	begin	
		-- Get the Interface ID for this interface
		select @InterfaceID = WebSkinID from SobekCM_Web_Skin where WebSkinCode = @Alt_WebSkin7

		-- Ensure this web skin exists
		if ( ISNULL(@InterfaceID,-1) > 0 )
		begin		
			-- Tie this item to this interface
			insert into SobekCM_Item_Group_Web_Skin_Link ( GroupID, WebSkinID, [Sequence] )
			values ( @GroupID, @InterfaceID, 8 )
		end
	end

	-- Add the ninth web skin to this object  (this requires the web skins have been pre-established )
	if ( len( isnull( @Alt_WebSkin8, '' )) > 0 ) 
	begin		
		-- Get the Interface ID for this interface
		select @InterfaceID = WebSkinID from SobekCM_Web_Skin where WebSkinCode = @Alt_WebSkin8

		-- Ensure this web skin exists
		if ( ISNULL(@InterfaceID,-1) > 0 )
		begin		
			-- Tie this item to this interface
			insert into SobekCM_Item_Group_Web_Skin_Link ( GroupID, WebSkinID, [Sequence] )
			values ( @GroupID, @InterfaceID, 9 )
		end
	end

	-- Add the tenth web skin to this object  (this requires the web skins have been pre-established )
	if ( len( isnull( @Alt_WebSkin9, '' )) > 0 ) 
	begin	
		-- Get the Interface ID for this interface
		select @InterfaceID = WebSkinID from SobekCM_Web_Skin where WebSkinCode = @Alt_WebSkin9

		-- Ensure this web skin exists
		if ( ISNULL(@InterfaceID,-1) > 0 )
		begin		
			-- Tie this item to this interface
			insert into SobekCM_Item_Group_Web_Skin_Link ( GroupID, WebSkinID, [Sequence] )
			values ( @GroupID, @InterfaceID, 10 )
		end
	end		
commit transaction
GO


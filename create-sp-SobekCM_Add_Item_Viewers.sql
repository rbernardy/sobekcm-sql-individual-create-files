USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Add_Item_Viewers]    Script Date: 1/23/2022 10:32:36 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Add or update existing viewers for an item
-- NOTE: This does not delete any existing viewers
CREATE PROCEDURE [dbo].[SobekCM_Add_Item_Viewers] 
	@ItemID int,
	@Viewer1_Type varchar(50),
	@Viewer1_Label nvarchar(50),
	@Viewer1_Attribute nvarchar(250),
	@Viewer2_Type varchar(50),
	@Viewer2_Label nvarchar(50),
	@Viewer2_Attribute nvarchar(250),
	@Viewer3_Type varchar(50),
	@Viewer3_Label nvarchar(50),
	@Viewer3_Attribute nvarchar(250),
	@Viewer4_Type varchar(50),
	@Viewer4_Label nvarchar(50),
	@Viewer4_Attribute nvarchar(250),
	@Viewer5_Type varchar(50),
	@Viewer5_Label nvarchar(50),
	@Viewer5_Attribute nvarchar(250),
	@Viewer6_Type varchar(50),
	@Viewer6_Label nvarchar(50),
	@Viewer6_Attribute nvarchar(250)
AS
BEGIN 

	
	-- Add the first viewer information, if provided
	if ( len(coalesce(@Viewer1_Type, '')) > 0 )
	begin
		-- Get the primary key for this viewer type
		declare @Viewer1_TypeID int;
		set @Viewer1_TypeID = coalesce(( select ItemViewTypeID from SobekCM_Item_Viewer_Types where ViewType = @Viewer1_Type ), -1 );

		-- Only continue if that viewer type was found
		if ( @Viewer1_TypeID > 0 )
		begin
			-- Does this already exist?
			if ( exists ( select 1 from SobekCM_Item_Viewers where ItemID=@ItemID and ItemViewTypeID=@Viewer1_TypeID ))
			begin
				-- Update this viewer information
				update SobekCM_Item_Viewers
				set Attribute=@Viewer1_Attribute, Label=@Viewer1_Label, Exclude='false'
				where ( ItemID = @ItemID )
				  and ( ItemViewTypeID = @Viewer1_TypeID );
			end
			else
			begin
				-- Insert this viewer information
				insert into SobekCM_Item_Viewers ( ItemID, ItemViewTypeID, Attribute, Label )
				values ( @ItemID, @Viewer1_TypeID, @Viewer1_Attribute, @Viewer1_Label );
			end;
		end;
	end;
	
	-- Add the second viewer information, if provided
	if ( len(coalesce(@Viewer2_Type, '')) > 0 )
	begin
		-- Get the primary key for this viewer type
		declare @Viewer2_TypeID int;
		set @Viewer2_TypeID = coalesce(( select ItemViewTypeID from SobekCM_Item_Viewer_Types where ViewType = @Viewer2_Type ), -1 );

		-- Only continue if that viewer type was found
		if ( @Viewer2_TypeID > 0 )
		begin
			-- Does this already exist?
			if ( exists ( select 1 from SobekCM_Item_Viewers where ItemID=@ItemID and ItemViewTypeID=@Viewer2_TypeID ))
			begin
				-- Update this viewer information
				update SobekCM_Item_Viewers
				set Attribute=@Viewer2_Attribute, Label=@Viewer2_Label, Exclude='false'
				where ( ItemID = @ItemID )
				  and ( ItemViewTypeID = @Viewer2_TypeID );
			end
			else
			begin
				-- Insert this viewer information
				insert into SobekCM_Item_Viewers ( ItemID, ItemViewTypeID, Attribute, Label )
				values ( @ItemID, @Viewer2_TypeID, @Viewer2_Attribute, @Viewer2_Label );
			end;
		end;
	end;
	
	-- Add the third viewer information, if provided
	if ( len(coalesce(@Viewer3_Type, '')) > 0 )
	begin
		-- Get the primary key for this viewer type
		declare @Viewer3_TypeID int;
		set @Viewer3_TypeID = coalesce(( select ItemViewTypeID from SobekCM_Item_Viewer_Types where ViewType = @Viewer3_Type ), -1 );

		-- Only continue if that viewer type was found
		if ( @Viewer3_TypeID > 0 )
		begin
			-- Does this already exist?
			if ( exists ( select 1 from SobekCM_Item_Viewers where ItemID=@ItemID and ItemViewTypeID=@Viewer3_TypeID ))
			begin
				-- Update this viewer information
				update SobekCM_Item_Viewers
				set Attribute=@Viewer3_Attribute, Label=@Viewer3_Label, Exclude='false'
				where ( ItemID = @ItemID )
					and ( ItemViewTypeID = @Viewer3_TypeID );
			end
			else
			begin
				-- Insert this viewer information
				insert into SobekCM_Item_Viewers ( ItemID, ItemViewTypeID, Attribute, Label )
				values ( @ItemID, @Viewer3_TypeID, @Viewer3_Attribute, @Viewer3_Label );
			end;
		end;
	end;
	
	-- Add the fourth viewer information, if provided
	if ( len(coalesce(@Viewer4_Type, '')) > 0 )
	begin
		-- Get the primary key for this viewer type
		declare @Viewer4_TypeID int;
		set @Viewer4_TypeID = coalesce(( select ItemViewTypeID from SobekCM_Item_Viewer_Types where ViewType = @Viewer4_Type ), -1 );

		-- Only continue if that viewer type was found
		if ( @Viewer4_TypeID > 0 )
		begin
			-- Does this already exist?
			if ( exists ( select 1 from SobekCM_Item_Viewers where ItemID=@ItemID and ItemViewTypeID=@Viewer4_TypeID ))
			begin
				-- Update this viewer information
				update SobekCM_Item_Viewers
				set Attribute=@Viewer4_Attribute, Label=@Viewer4_Label, Exclude='false'
				where ( ItemID = @ItemID )
				  and ( ItemViewTypeID = @Viewer4_TypeID );
			end
			else
			begin
				-- Insert this viewer information
				insert into SobekCM_Item_Viewers ( ItemID, ItemViewTypeID, Attribute, Label )
				values ( @ItemID, @Viewer4_TypeID, @Viewer4_Attribute, @Viewer4_Label );
			end;
		end;
	end;
	
	-- Add the fifth viewer information, if provided
	if ( len(coalesce(@Viewer5_Type, '')) > 0 )
	begin
		-- Get the primary key for this viewer type
		declare @Viewer5_TypeID int;
		set @Viewer5_TypeID = coalesce(( select ItemViewTypeID from SobekCM_Item_Viewer_Types where ViewType = @Viewer5_Type ), -1 );

		-- Only continue if that viewer type was found
		if ( @Viewer5_TypeID > 0 )
		begin
			-- Does this already exist?
			if ( exists ( select 1 from SobekCM_Item_Viewers where ItemID=@ItemID and ItemViewTypeID=@Viewer5_TypeID ))
			begin
				-- Update this viewer information
				update SobekCM_Item_Viewers
				set Attribute=@Viewer5_Attribute, Label=@Viewer5_Label, Exclude='false'
				where ( ItemID = @ItemID )
				  and ( ItemViewTypeID = @Viewer5_TypeID );
			end
			else
			begin
				-- Insert this viewer information
				insert into SobekCM_Item_Viewers ( ItemID, ItemViewTypeID, Attribute, Label )
				values ( @ItemID, @Viewer5_TypeID, @Viewer5_Attribute, @Viewer5_Label );
			end;
		end;
	end;
	
	-- Add the sixth viewer information, if provided
	if ( len(coalesce(@Viewer6_Type, '')) > 0 )
	begin
		-- Get the primary key for this viewer type
		declare @Viewer6_TypeID int;
		set @Viewer6_TypeID = coalesce(( select ItemViewTypeID from SobekCM_Item_Viewer_Types where ViewType = @Viewer6_Type ), -1 );

		-- Only continue if that viewer type was found
		if ( @Viewer6_TypeID > 0 )
		begin
			-- Does this already exist?
			if ( exists ( select 1 from SobekCM_Item_Viewers where ItemID=@ItemID and ItemViewTypeID=@Viewer6_TypeID ))
			begin
				-- Update this viewer information
				update SobekCM_Item_Viewers
				set Attribute=@Viewer6_Attribute, Label=@Viewer6_Label, Exclude='false'
				where ( ItemID = @ItemID )
				  and ( ItemViewTypeID = @Viewer6_TypeID );
			end
			else
			begin
				-- Insert this viewer information
				insert into SobekCM_Item_Viewers ( ItemID, ItemViewTypeID, Attribute, Label )
				values ( @ItemID, @Viewer6_TypeID, @Viewer6_Attribute, @Viewer6_Label );
			end;
		end;
	end;
END;
GO


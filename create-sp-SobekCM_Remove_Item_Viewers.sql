USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Remove_Item_Viewers]    Script Date: 2/22/2022 8:16:14 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Remove an existing viewer for an item
CREATE PROCEDURE [dbo].[SobekCM_Remove_Item_Viewers] 
	@ItemID int,
	@Viewer1_Type varchar(50),
	@Viewer2_Type varchar(50),
	@Viewer3_Type varchar(50),
	@Viewer4_Type varchar(50),
	@Viewer5_Type varchar(50),
	@Viewer6_Type varchar(50)
AS
BEGIN 

	-- Exclude the first viewer
	if ( len(coalesce(@Viewer1_Type, '')) > 0 )
	begin
		-- Get the primary key for this viewer type
		declare @Viewer1_TypeID int;
		set @Viewer1_TypeID = coalesce(( select ItemViewTypeID from SobekCM_Item_Viewer_Types where ViewType = @Viewer1_Type ), -1 );

		-- Only continue if that viewer type was found
		if ( @Viewer1_TypeID > 0 )
		begin
			update SobekCM_Item_Viewers 
			set Exclude='true' 
			where ItemID=@ItemID and ItemViewTypeID=@Viewer1_TypeID;
		end;
	end;

	-- Exclude the second viewer
	if ( len(coalesce(@Viewer2_Type, '')) > 0 )
	begin
		-- Get the primary key for this viewer type
		declare @Viewer2_TypeID int;
		set @Viewer2_TypeID = coalesce(( select ItemViewTypeID from SobekCM_Item_Viewer_Types where ViewType = @Viewer2_Type ), -1 );

		-- Only continue if that viewer type was found
		if ( @Viewer2_TypeID > 0 )
		begin
			update SobekCM_Item_Viewers 
			set Exclude='true' 
			where ItemID=@ItemID and ItemViewTypeID=@Viewer2_TypeID;
		end;
	end;

	-- Exclude the third viewer
	if ( len(coalesce(@Viewer3_Type, '')) > 0 )
	begin
		-- Get the primary key for this viewer type
		declare @Viewer3_TypeID int;
		set @Viewer3_TypeID = coalesce(( select ItemViewTypeID from SobekCM_Item_Viewer_Types where ViewType = @Viewer3_Type ), -1 );

		-- Only continue if that viewer type was found
		if ( @Viewer3_TypeID > 0 )
		begin
			update SobekCM_Item_Viewers 
			set Exclude='true' 
			where ItemID=@ItemID and ItemViewTypeID=@Viewer3_TypeID;
		end;
	end;

	-- Exclude the fourth viewer
	if ( len(coalesce(@Viewer4_Type, '')) > 0 )
	begin
		-- Get the primary key for this viewer type
		declare @Viewer4_TypeID int;
		set @Viewer4_TypeID = coalesce(( select ItemViewTypeID from SobekCM_Item_Viewer_Types where ViewType = @Viewer4_Type ), -1 );

		-- Only continue if that viewer type was found
		if ( @Viewer4_TypeID > 0 )
		begin
			update SobekCM_Item_Viewers 
			set Exclude='true' 
			where ItemID=@ItemID and ItemViewTypeID=@Viewer4_TypeID;
		end;
	end;

	-- Exclude the fifth viewer
	if ( len(coalesce(@Viewer5_Type, '')) > 0 )
	begin
		-- Get the primary key for this viewer type
		declare @Viewer5_TypeID int;
		set @Viewer5_TypeID = coalesce(( select ItemViewTypeID from SobekCM_Item_Viewer_Types where ViewType = @Viewer5_Type ), -1 );

		-- Only continue if that viewer type was found
		if ( @Viewer5_TypeID > 0 )
		begin
			update SobekCM_Item_Viewers 
			set Exclude='true' 
			where ItemID=@ItemID and ItemViewTypeID=@Viewer5_TypeID;
		end;
	end;

	-- Exclude the sixth viewer
	if ( len(coalesce(@Viewer6_Type, '')) > 0 )
	begin
		-- Get the primary key for this viewer type
		declare @Viewer6_TypeID int;
		set @Viewer6_TypeID = coalesce(( select ItemViewTypeID from SobekCM_Item_Viewer_Types where ViewType = @Viewer6_Type ), -1 );

		-- Only continue if that viewer type was found
		if ( @Viewer6_TypeID > 0 )
		begin
			update SobekCM_Item_Viewers 
			set Exclude='true' 
			where ItemID=@ItemID and ItemViewTypeID=@Viewer6_TypeID;
		end;
	end;
END;
GO


USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Save_Item_Views]    Script Date: 3/14/2022 8:08:10 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Saves the behavior information about an item in this library
-- Written by Mark Sullivan 
CREATE PROCEDURE [dbo].[SobekCM_Save_Item_Views]
	@BibID varchar(10),
	@VID varchar(5),
	@Viewer1_TypeID int,
	@Viewer1_Label nvarchar(50),
	@Viewer1_Attribute nvarchar(250),
	@Viewer2_TypeID int,
	@Viewer2_Label nvarchar(50),
	@Viewer2_Attribute nvarchar(250),
	@Viewer3_TypeID int,
	@Viewer3_Label nvarchar(50),
	@Viewer3_Attribute nvarchar(250)
AS
begin transaction

	-- Get the volume id
	declare @itemid int

	select @itemid = ItemID
	from SobekCM_Item_Group G, SobekCM_Item I
	where ( BibID = @bibid )
	    and ( I.GroupID = G.GroupID ) 
	    and ( VID = @vid)

	-- continue if a volumeid was located
	if ( isnull( @itemid, -1 ) > 0 )
	begin
	
		-- Add the first viewer information
		if (( @Viewer1_TypeID > 0 ) and ( ( select COUNT(*) from SobekCM_Item_Viewers where ItemViewTypeID=@Viewer1_TypeID and ItemID=@itemid ) = 0 ))
		begin
			-- Insert this viewer information
			insert into SobekCM_Item_Viewers ( ItemID, ItemViewTypeID, Attribute, Label )
			values ( @ItemID, @Viewer1_TypeID, @Viewer1_Attribute, @Viewer1_Label )
		end
		
		-- Add the second viewer information
		if (( @Viewer2_TypeID > 0 ) and ( ( select COUNT(*) from SobekCM_Item_Viewers where ItemViewTypeID=@Viewer2_TypeID and ItemID=@itemid ) = 0 ))
		begin
			-- Insert this viewer information
			insert into SobekCM_Item_Viewers ( ItemID, ItemViewTypeID, Attribute, Label )
			values ( @ItemID, @Viewer2_TypeID, @Viewer2_Attribute, @Viewer2_Label )
		end
		
		-- Add the third viewer information
		if (( @Viewer3_TypeID > 0 ) and ( ( select COUNT(*) from SobekCM_Item_Viewers where ItemViewTypeID=@Viewer3_TypeID and ItemID=@itemid ) = 0 ))
		begin
			-- Insert this viewer information
			insert into SobekCM_Item_Viewers ( ItemID, ItemViewTypeID, Attribute, Label )
			values ( @ItemID, @Viewer3_TypeID, @Viewer3_Attribute, @Viewer3_Label )
		end	
	end
commit transaction
GO


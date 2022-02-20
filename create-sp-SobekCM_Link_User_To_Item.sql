USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Link_User_To_Item]    Script Date: 2/20/2022 6:39:13 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Links an item to an item with a given relationship.  This is used for reporting
-- usage statistics to individuals, etc..
CREATE PROCEDURE [dbo].[SobekCM_Link_User_To_Item]
	@ItemID int,
	@UserID int,
	@RelationshipID int,
	@Change_Existing bit
AS
BEGIN

	-- Only continue if there is currently no link between the user and the item
	if (( select COUNT(*) from mySobek_User_Item_Link L where L.UserID=@UserID and L.ItemID=@ItemID ) = 0 )
	begin	
		-- Add this link
		insert into mySobek_User_Item_Link ( UserID, ItemID, RelationshipID )
		values ( @UserID, @ItemID, @RelationshipID );
	end
	else if ( @Change_Existing = 'true' )
	begin
	
		-- Change the existing
		update mySobek_User_Item_Link
		set RelationshipID=@RelationshipID
		where UserID=@UserID and ItemID=@ItemID;
	
	end;
end;
GO


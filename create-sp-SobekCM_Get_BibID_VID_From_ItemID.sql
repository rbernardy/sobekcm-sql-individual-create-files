USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Get_BibID_VID_From_ItemID]    Script Date: 2/12/2022 4:17:33 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Allows a lookup of the BibID/VID for an item from the database's primary key.
-- This is used for legacy URLs which may reference the item by itemid.
CREATE PROCEDURE [dbo].[SobekCM_Get_BibID_VID_From_ItemID]
	@itemid int
as
begin

	-- No need to perform any locks here
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	-- Return the item group / item information exactly like it is returned in the Item list brief procedure
	select G.BibID, I.VID
	from SobekCM_Item I, SobekCM_Item_Group G
	where ( I.GroupID = G.GroupID )
	  and ( G.Deleted = CONVERT(bit,0) )
	  and ( I.Deleted = CONVERT(bit,0) )
	  and ( I.ItemID = @itemid );

end;
GO


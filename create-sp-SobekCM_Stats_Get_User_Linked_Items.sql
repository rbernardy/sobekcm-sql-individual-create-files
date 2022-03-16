USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Stats_Get_User_Linked_Items]    Script Date: 3/16/2022 7:47:59 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Get the list of all items linked to a user for statistics reporting purposes
CREATE PROCEDURE [dbo].[SobekCM_Stats_Get_User_Linked_Items]
	@userid int
AS
begin
	-- No need to perform any locks here.
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
	
	select L.ItemID, R.RelationshipID, R.RelationshipLabel, G.BibID, I.VID, G.GroupTitle, I.Title
	from mySobek_User_Item_Link L, mySobek_User_Item_Link_Relationship R, SobekCM_Item I, SobekCM_Item_Group G
	where ( L.ItemID = I.ItemID )
	  and ( L.RelationshipID = R.RelationshipID )
	  and ( I.GroupID = G.GroupID )
	  and ( R.Include_In_Results = 'true' );
end;
GO


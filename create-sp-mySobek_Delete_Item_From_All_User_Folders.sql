USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[mySobek_Delete_Item_From_All_User_Folders]    Script Date: 1/17/2022 6:31:02 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Delete an item from the user's folder
CREATE PROCEDURE [dbo].[mySobek_Delete_Item_From_All_User_Folders]
	@userid int,
	@bibid varchar(10),
	@vid varchar(5)
AS
begin
	
		-- Is there a match for this bib id /vid?
	if (( select COUNT(*) from SobekCM_Item I, SobekCM_Item_Group G where I.GroupID = G.GroupID and G.BibID = @bibid and I.VID = @vid ) = 1 )
	begin
		-- Get the item id
		declare @itemid int
		select @itemid = ItemID from SobekCM_Item I, SobekCM_Item_Group G where I.GroupID = G.GroupID and G.BibID = @bibid and I.VID = @vid
	
		-- Delete this item from this users folder
		delete from mySobek_User_Item
		where ( ItemID=@itemid ) 
		  and exists (	select FolderName 
						from mySobek_User_Folder F 
						where F.UserID=@userid 
						  and F.UserFolderID=mySobek_User_Item.UserFolderID
						  and FolderName != 'Submitted Items' )
	end
end
GO


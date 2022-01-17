USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[mySobek_Delete_Item_From_User_Folder]    Script Date: 1/17/2022 6:43:08 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Delete an item from the user's folder
CREATE PROCEDURE [dbo].[mySobek_Delete_Item_From_User_Folder]
	@userid int,
	@foldername varchar(255),
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
	
		-- First, get the user folder id for this
		if (( select count(*) from mySobek_User_Folder where UserID=@userid and FolderName=@foldername) > 0 )
		begin
			-- Get the existing folder id
			declare @userfolderid int
			select @userfolderid = UserFolderID from mySobek_User_Folder where UserID=@userid and FolderName=@foldername

			-- Now, delete this item
			delete from mySobek_User_Item where UserFolderID=@userfolderid and ItemID=@itemid
		end
	end
end
GO


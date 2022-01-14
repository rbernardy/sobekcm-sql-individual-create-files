USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[mySobek_Add_Item_To_User_Folder]    Script Date: 1/13/2022 10:51:24 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Add an item to the user's folder
CREATE PROCEDURE [dbo].[mySobek_Add_Item_To_User_Folder]
	@userid int,
	@foldername varchar(255),
	@bibid varchar(10),
	@vid varchar(5),
	@itemorder int,
	@usernotes nvarchar(2000)
AS
begin

	-- Is there a match for this bib id /vid?
	if (( select COUNT(*) from SobekCM_Item I, SobekCM_Item_Group G where I.GroupID = G.GroupID and G.BibID = @bibid and I.VID = @vid ) = 1 )
	begin
		-- Get the item id
		declare @itemid int
		select @itemid = ItemID from SobekCM_Item I, SobekCM_Item_Group G where I.GroupID = G.GroupID and G.BibID = @bibid and I.VID = @vid
	
		-- First, see if this user already has a folder named this
		declare @userfolderid int
		if (( select count(*) from mySobek_User_Folder where UserID=@userid and FolderName=@foldername) > 0 )
		begin
			-- Get the existing folder id
			select @userfolderid = UserFolderID from mySobek_User_Folder where UserID=@userid and FolderName=@foldername
		end
		else
		begin
			-- Add this folder
			insert into mySobek_User_Folder ( UserID, FolderName, isPublic )
			values ( @userid, @foldername, 'false' )

			-- Get the new id
			select @userfolderid = @@identity
		end	

		-- Now, see if the item is already linked to the folder
		if (( select count(*) from mySobek_User_Item where ItemID=@itemid and UserFolderID=@userfolderid ) > 0 )
		begin
			-- Just update the existing link then
			update mySobek_User_Item
			set ItemOrder = @itemorder, UserNotes=@usernotes
			where UserFolderID = @userfolderid and ItemID=@itemid
		end
		else
		begin
			-- Add a new link then
			insert into mySobek_User_Item( UserFolderID, ItemID, ItemOrder, UserNotes, DateAdded )
			values ( @userfolderid, @itemid, @itemorder, @usernotes, getdate() )
		end
	end
end
GO


USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[mySobek_Delete_User_Folder]    Script Date: 1/17/2022 7:04:41 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Delete a user's folder
CREATE PROCEDURE [dbo].[mySobek_Delete_User_Folder]
	@userfolderid int,
	@userid int
AS
begin transaction
	
	-- Only continue if the folder exists and is tagged to this user
	if ((select count(*) from mySobek_User_Folder where userfolderid=@userfolderid and userid=@userid) > 0 )
	begin
		
		-- Only continue if there are no subfolders
		if (( select count(*) from mySobek_User_Folder where ParentFolderID = @userfolderid ) <= 0 )
		begin
			DELETE FROM mySobek_User_Folder
			where UserID=@userid and UserFolderID=@userfolderid
		end
	end
commit transaction
GO


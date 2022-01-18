USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[mySobek_Edit_User_Folder]    Script Date: 1/17/2022 7:36:32 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Edit a user's folder information
CREATE PROCEDURE [dbo].[mySobek_Edit_User_Folder]
	@userfolderid int,
	@userid int,
	@parentfolderid int,
	@foldername nvarchar(255),
	@is_public bit,
	@description nvarchar(4000),
	@new_folder_id int out
AS
begin transaction

	-- Does this reference an existing folder?
	if ( @userfolderid > 0 )
	begin
		-- Update the existing folder
		update mySobek_User_Folder 
		set FolderName=@foldername, isPublic=@is_public, FolderDescription=@description
		where UserFolderID=@userfolderid and UserID=@userid;

		-- Return the old folder id
		set @new_folder_id = @userfolderid;
	end
	else
	begin
		-- Ensure a folder of the same name does not exist
		if (( select count(*) from mySobek_User_Folder where UserID=@userid and FolderName=@foldername ) > 0 )
		begin
			-- update this existing folder
			update mySobek_User_Folder 
			set FolderName=@foldername, isPublic=@is_public, FolderDescription=@description
			where FolderName=@foldername and UserID=@userid;

			-- Get the primary key
			set @new_folder_id = ( select UserFolderID from mySobek_User_Folder where FolderName=@foldername and UserID=@userid);
		end
		else
		begin		
			-- Add this as a new folder
			if ( @parentfolderid < 0 )
			begin
				-- Insert this as a new folder, without a parent
				insert into mySobek_User_Folder( UserID, FolderName, isPublic, FolderDescription )
				values ( @userid, @foldername, @is_public, @description );
			end
			else
			begin
				-- Insert this as a new folder, with a parent
				insert into mySobek_User_Folder( UserID, FolderName, isPublic, FolderDescription, ParentFolderID )
				values ( @userid, @foldername, @is_public, @description, @parentfolderid );
			end;	

			-- Return the new folder id
			set @new_folder_id = @@identity;
		end;
	end;
commit transaction;
GO


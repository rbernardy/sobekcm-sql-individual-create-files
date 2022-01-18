USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[mySobek_Delete_User]    Script Date: 1/17/2022 7:00:23 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Fully removes an existing user
CREATE PROCEDURE [dbo].[mySobek_Delete_User] 
	@username varchar(20)
as
begin transaction

	if ( exists ( select 1 from mySobek_User where UserName=@username ))
	begin

		-- Get the 	user id
		declare @userid int;
		set @userid = ( select UserID from mySobek_User where Username=@username);

		-- Delete from all the satellite tables
		delete from mySobek_User_Bib_Link where UserID=@userid;
		delete from mySobek_User_DefaultMetadata_Link where UserID=@userid;
		delete from mySobek_User_Description_Tags where UserID=@userid;
		delete from mySobek_User_Edit_Aggregation where UserID=@userid;
		delete from mySobek_User_Editable_Link where UserID=@userid;

		delete from mySobek_User_Item_Link where UserID=@userid;
		delete from mySobek_User_Item_Permissions where UserID=@userid;
		delete from mySobek_User_Search where UserID=@userid;
		delete from mySobek_User_Settings where UserID=@userid;
		delete from mySobek_User_Template_Link where UserID=@userid;
		delete from mySobek_User_Group_Link where UserID=@userid;

		-- Delete the folder
		delete from mySobek_User_Item where UserFolderID in ( select UserFolderID from mySobek_User_Folder where UserID=@userid);
		delete from mySobek_User_Folder where UserID=@userid;

		-- Delete from main user table
		delete from mySobek_User where UserID=@userid;

	end;

commit transaction
GO


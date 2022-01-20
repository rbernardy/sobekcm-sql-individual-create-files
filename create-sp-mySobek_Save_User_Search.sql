USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[mySobek_Save_User_Search]    Script Date: 1/19/2022 7:39:04 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Add a sarch to the user's list of saved searches
CREATE PROCEDURE [dbo].[mySobek_Save_User_Search]
	@userid int,
	@searchurl nvarchar(500),
	@searchdescription nvarchar(500),
	@itemorder int,
	@usernotes nvarchar(2000),
	@new_usersearchid int output
AS
begin

	-- See if this already exists
	if (( select count(*) from mySobek_User_Search where UserID=@userid and SearchURL=@searchurl ) > 0 )
	begin
		-- update existing
		update mySobek_User_Search
		set ItemOrder=@itemorder, UserNotes=@usernotes
		where UserID=@userid and SearchURL=@searchurl

		-- Just set this to -1, since nothing new was added
		set @new_usersearchid = -1
	end
	else
	begin
		-- Add a new search
		insert into mySobek_User_Search( UserID, SearchURL, SearchDescription, ItemOrder, UserNotes, DateAdded )
		values ( @userid, @searchurl, @searchdescription, @itemorder, @usernotes, getdate())

		-- Return the new identifier
		set @new_usersearchid = @@identity
	end
end
GO


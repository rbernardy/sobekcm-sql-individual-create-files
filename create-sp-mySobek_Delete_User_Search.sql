USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[mySobek_Delete_User_Search]    Script Date: 1/17/2022 7:24:42 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Delete a saved search
CREATE PROCEDURE [dbo].[mySobek_Delete_User_Search]
	@usersearchid int
AS
BEGIN
	delete from mySobek_User_Search
	where UserSearchID=@usersearchid
END
GO


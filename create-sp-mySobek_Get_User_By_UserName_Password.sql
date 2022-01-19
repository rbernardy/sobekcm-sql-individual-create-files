USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[mySobek_Get_User_By_UserName_Password]    Script Date: 1/18/2022 7:54:24 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Gets all the user information by the username and hashed password
CREATE PROCEDURE [dbo].[mySobek_Get_User_By_UserName_Password]
	@username varchar(100),
	@password varchar(100)
AS
BEGIN

	-- No need to perform any locks here.  A slightly dirty read won't hurt much
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	-- Look for the current user by username and hashed password.  Does one exist?
	if (( select COUNT(*) from mySobek_User where UserName=@username and [Password]=@password and isActive = 'true' ) = 1 )
	begin
		-- Get the userid for this user
		declare @userid int;
		select @userid = UserID from mySobek_User where UserName=@username and [Password]=@password and isActive = 'true';
		
		-- Stored procedure used to return standard data across all user fetch stored procedures
		exec mySobek_Get_User_By_UserID @userid;
	end  -- Look for current user by email and hashed password...
	else if (( select COUNT(*) from mySobek_User where EmailAddress=@username and [Password]=@password and isActive = 'true' ) = 1 )
	begin
		-- Get the userid for this user by email and hashed password
		declare @userid2 int;
		select @userid2 = UserID from mySobek_User where EmailAddress=@username and [Password]=@password and isActive = 'true';
		
		-- Stored procedure used to return standard data across all user fetch stored procedures
		exec mySobek_Get_User_By_UserID @userid2;
	end;
END;
GO


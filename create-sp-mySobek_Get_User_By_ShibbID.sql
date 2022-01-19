USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[mySobek_Get_User_By_ShibbID]    Script Date: 1/18/2022 7:37:47 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[mySobek_Get_User_By_ShibbID]
	@shibbid char(8)
AS
BEGIN  

	-- No need to perform any locks here.  A slightly dirty read won't hurt much
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
	
	-- Look for the user by Shibboleth ID.  Does one exist?
	if (( select COUNT(*) from mySobek_User where ShibbID=@shibbid and isActive = 'true' ) = 1 )
	begin
		-- Get the userid for this user
		declare @userid int;
		select @userid = UserID from mySobek_User where ShibbID=@shibbid and isActive = 'true';  
  
		-- Stored procedure used to return standard data across all user fetch stored procedures
		exec mySobek_Get_User_By_UserID @userid; 
	end;
END;
GO


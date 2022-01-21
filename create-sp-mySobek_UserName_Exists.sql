USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[mySobek_UserName_Exists]    Script Date: 1/20/2022 8:32:52 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Checks to see if the username or email exists
CREATE PROCEDURE [dbo].[mySobek_UserName_Exists]
	@username nvarchar(100),
	@email varchar(100),
	@username_exists bit output,
	@email_exists bit output
AS
BEGIN

	-- Check if username exists
	if ( ( select count(*) from mySobek_User where UserName = @username ) = 0 )
	begin
		set @username_exists = 'false';
	end
	else
	begin
		set @username_exists = 'true';
	end	

	-- Check if email exists
	if ( ( select count(*) from mySobek_User where EmailAddress = @email ) = 0 )
	begin
		set @email_exists = 'false';
	end
	else
	begin
		set @email_exists = 'true';
	end	

END
GO


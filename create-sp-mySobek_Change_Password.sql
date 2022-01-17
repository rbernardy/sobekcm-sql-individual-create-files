USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[mySobek_Change_Password]    Script Date: 1/17/2022 6:06:22 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Change a user's password
CREATE PROCEDURE [dbo].[mySobek_Change_Password]
	@username nvarchar(100),
	@current_password nvarchar(100),
	@new_password nvarchar(100),
	@isTemporaryPassword bit,
	@password_changed bit output
AS
BEGIN
	
	if ( ( select count(*) from mySobek_User where username=@username and [password]=@current_password ) > 0 )
	begin

		update mySobek_User 
		set isTemporary_Password=@isTemporaryPassword, [Password]=@new_password
		where ( UserName = @username ) and ( [Password]=@current_password )

		set @password_changed = 'true';

	end
	else
	begin
		
		set @password_changed = 'false';

	end

END
GO


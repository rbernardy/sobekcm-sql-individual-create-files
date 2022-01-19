USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[mySobek_Reset_User_Password]    Script Date: 1/18/2022 11:11:34 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Reset a user's password
CREATE PROCEDURE [dbo].[mySobek_Reset_User_Password]
	@userid int,
	@password varchar(100),
	@is_temporary bit
AS
BEGIN
	
	update mySobek_User
	set [Password]=@password, isTemporary_Password=@is_temporary
	where UserID = @userid

END
GO


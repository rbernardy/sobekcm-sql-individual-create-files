USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[mySobek_Set_Receive_Stats_Email_Flag]    Script Date: 1/19/2022 8:31:01 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[mySobek_Set_Receive_Stats_Email_Flag]
	@userid int,
	@newflag bit
AS
begin

	update mySobek_User
	set Receive_Stats_Emails=@newflag	

end
GO


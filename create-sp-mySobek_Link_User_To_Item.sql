USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[mySobek_Link_User_To_Item]    Script Date: 1/18/2022 8:40:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Links a user to an item for editing purposes
CREATE PROCEDURE [dbo].[mySobek_Link_User_To_Item]
	@userid int,
	@groupid char(10)
AS
BEGIN
	
	if (( select COUNT(*) from mySobek_User_Bib_Link where UserID=@userid and GroupID = @groupid ) = 0 )
	begin
		insert into mySobek_User_Bib_Link ( UserID, GroupID )
		values ( @userid, @groupid )
	end

END
GO


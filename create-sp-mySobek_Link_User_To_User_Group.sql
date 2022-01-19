USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[mySobek_Link_User_To_User_Group]    Script Date: 1/18/2022 8:54:46 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[mySobek_Link_User_To_User_Group]
	@userid int,
	@usergroupid int
AS
begin

	if (( select COUNT(*) from mySobek_User_Group_Link where UserID=@userid and UserGroupID = @usergroupid ) = 0 )
	begin
	
		insert into mySobek_User_Group_Link ( UserGroupID, UserID )
		values ( @usergroupid, @userid );
	
	end;

end;
GO


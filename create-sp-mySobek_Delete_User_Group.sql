USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[mySobek_Delete_User_Group]    Script Date: 1/17/2022 7:14:57 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[mySobek_Delete_User_Group]
	@usergroupid int,
	@message int output
AS
begin transaction

	if ( exists ( select 1 from mySobek_User_Group_Link where UserGroupID=@usergroupid ))
	begin
		set @message = -1;
	end
	else if ( exists ( select 1 from mySobek_User_Group where UserGroupID=@usergroupid and isSpecialGroup = 'true' ))
	begin
		set @message = -2;
	end
	else
	begin

		delete from mySobek_User_Group_DefaultMetadata_Link where UserGroupID=@usergroupid;
		delete from mySobek_User_Group_Edit_Aggregation where UserGroupID=@usergroupid;
		delete from mySobek_User_Group_Item_Permissions where UserGroupID=@usergroupid;
		delete from mySobek_User_Group_Editable_Link where UserGroupID=@usergroupid;
		delete from mySobek_User_Group_Template_Link where UserGroupID=@usergroupid;
		delete from mySobek_User_Group where UserGroupID = @usergroupid;

		set @message = 1;
	end;

commit transaction;
GO


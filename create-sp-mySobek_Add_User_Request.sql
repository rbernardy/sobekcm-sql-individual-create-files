USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[mySobek_Add_User_Request]    Script Date: 1/17/2022 5:50:42 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



/****** Object:  StoredProcedure [dbo].[[mySobek_Add_User_DefaultMetadata_Link]]    Script Date: 12/20/2013 05:43:35 ******/
-- Add a link between a user and default metadata 
CREATE PROCEDURE [dbo].[mySobek_Add_User_Request]
	@userid int,
	@usergroupid int,
	@requestsubmitpermissions bit,
	@requesturl nvarchar(255),
	@notes nvarchar(2000)
AS
begin

	insert into mySobek_User_Request(UserID, UserGroupID, RequestSubmitPermissions, RequestUrl, Notes, Pending, RequestDate, Approved )
	values ( @Userid, @usergroupid, @requestsubmitpermissions, @requesturl, @notes, 'true', getdate(), 'false');
	
end;

GO


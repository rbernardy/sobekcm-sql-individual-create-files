USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[mySobek_Get_Folder_Information]    Script Date: 1/17/2022 8:40:03 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Get all the information about a folder, by folder id
CREATE PROCEDURE [dbo].[mySobek_Get_Folder_Information]
	@folderid int
AS
BEGIN
	select UserFolderID, FolderName, isPublic, FolderDescription, U.UserID, FirstName, LastName, NickName, EmailAddress
	from mySobek_User_Folder F, mySobek_User U
	where ( UserFolderID=@folderid )
	  and ( U.UserID = F.UserID )
END
GO


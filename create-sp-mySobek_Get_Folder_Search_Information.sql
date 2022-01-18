USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[mySobek_Get_Folder_Search_Information]    Script Date: 1/17/2022 8:54:56 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Get overall information about folders and searches for this user
CREATE PROCEDURE [dbo].[mySobek_Get_Folder_Search_Information]
	@userid int
AS
BEGIN
	-- Return the names of all the folders first
	select F.UserFolderID, ParentFolderID=isnull(F.ParentFolderID,-1), F.FolderName, F.isPublic, Item_Count=(select count(*) from mySobek_User_Item I where I.UserFolderID=F.UserFolderID )
	from mySobek_User_Folder F
	where UserID=@userid

	-- Return the number of searches
	select Search_Count=count(*)
	from mySobek_User_Search
	where UserID=@userid
END
GO


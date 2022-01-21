USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[mySobek_View_All_User_Tags]    Script Date: 1/20/2022 8:48:59 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- View all of a single user's tag
CREATE PROCEDURE [dbo].[mySobek_View_All_User_Tags]
	@UserID int
AS
begin

	if ( @UserID < 0 )
	begin
		select T.TagID, G.BibID, I.VID, T.Description_Tag, T.Date_Modified, U.UserID, U.FirstName, U.NickName, U.LastName 
		from mySobek_User_Description_Tags T, mySobek_User U, SobekCM_Item I, SobekCM_Item_Group G
		where T.UserID=U.UserID
		  and T.ItemID = I.ItemID
		  and I.GroupID = G.GroupID
	end
	else
	begin
		select T.TagID, G.BibID, I.VID, T.Description_Tag, T.Date_Modified, U.UserID, U.FirstName, U.NickName, U.LastName 
		from mySobek_User_Description_Tags T, mySobek_User U, SobekCM_Item I, SobekCM_Item_Group G
		where T.UserID=U.UserID 
		  and T.UserID=@UserID
		  and T.ItemID = I.ItemID
		  and I.GroupID = G.GroupID
	end
end
GO


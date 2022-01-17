USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[mySobek_Delete_Description_Tag]    Script Date: 1/17/2022 6:18:33 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Delete a user's tag
CREATE PROCEDURE [dbo].[mySobek_Delete_Description_Tag] 
	@TagID int
AS
begin
	delete from mySobek_User_Description_Tags where TagID=@TagID
end
GO


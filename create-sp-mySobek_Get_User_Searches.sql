USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[mySobek_Get_User_Searches]    Script Date: 1/18/2022 8:32:13 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Get list of saved searches
CREATE PROCEDURE [dbo].[mySobek_Get_User_Searches]
	@userid int
AS
BEGIN
	select * 
	from mySobek_User_Search
	where UserID = @userid
	order by ItemOrder, DateAdded
END
GO


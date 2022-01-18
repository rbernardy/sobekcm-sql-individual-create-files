USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[mySobek_Get_All_Users]    Script Date: 1/17/2022 8:20:42 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[mySobek_Get_All_Users] AS
BEGIN
	
	select UserID, LastName + ', ' + FirstName AS [Full_Name], UserName, EmailAddress
	from mySobek_User 
	order by Full_Name;
END;
GO


USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Stats_Get_Users_Linked_To_Items]    Script Date: 3/16/2022 7:54:50 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Get the list of all users that have items which may have statistics
CREATE PROCEDURE [dbo].[SobekCM_Stats_Get_Users_Linked_To_Items] AS
begin
	-- No need to perform any locks here.
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
	
	select U.FirstName, U.LastName, U.NickName, U.UserName, U.UserID, U.EmailAddress
	from mySobek_User U
	where ( Receive_Stats_Emails = 'true' )
	   and exists ( select * from mySobek_User_Item_Link L, mySobek_User_Item_Link_Relationship R where L.UserID=U.UserID and L.RelationshipID=R.RelationshipID and R.Include_In_Results = 'true' );
end;
GO


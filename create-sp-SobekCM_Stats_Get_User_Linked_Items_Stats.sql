USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Stats_Get_User_Linked_Items_Stats]    Script Date: 3/16/2022 7:51:21 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Get the list of items linked to this user, along with usage for that month
CREATE PROCEDURE [dbo].[SobekCM_Stats_Get_User_Linked_Items_Stats]
	@userid int,
	@month int,
	@year int
AS
begin
	-- No need to perform any locks here.
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	select L.ItemID, L.RelationshipID, R.RelationshipLabel, I.Title, G.BibID, I.VID, I.CreateDate, I.Total_Hits, I.Total_Sessions, ISNULL(S2.Hits,0) as Month_Hits, ISNULL(S2.[Sessions],0) as Month_Sessions
	from mySobek_User_Item_Link_Relationship AS R join
		 mySobek_User_Item_Link AS L ON ( L.RelationshipID=R.RelationshipID ) join
		 SobekCM_Item AS I ON ( L.ItemID=I.ItemID ) join
		 SobekCM_Item_Group AS G ON ( G.GroupID=I.GroupID) left join
		 SobekCM_Item_Statistics AS S2 ON ( S2.ItemID=L.ItemID and S2.[Month]=@month and S2.[Year]=@year)		  
	where ( L.UserID=@userid ) and ( R.Include_In_Results = 'true' );
end;
GO


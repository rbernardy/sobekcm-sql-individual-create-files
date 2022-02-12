USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Get_Description_Tags_By_Aggregation]    Script Date: 2/12/2022 5:34:42 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Returns the list of any descriptive tags entered by users and
-- linked to an item aggregation.  If no code, or 'ALL', is passed in 
-- as the argument, then all descriptive tags are returned.
CREATE PROCEDURE [dbo].[SobekCM_Get_Description_Tags_By_Aggregation]
	@aggregationcode varchar(20)
AS
BEGIN

	-- No need to perform any locks here
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	-- If the code has length and is not 'ALL', return the descriptive tags for that aggregation
	if (( len( @aggregationcode) > 0 ) and ( @aggregationcode != 'ALL' ))
	begin
		-- Return tags linked to that aggregation code
		select U.FirstName, U.NickName, U.LastName, G.BibID, I.VID, T.Description_Tag, T.TagID, T.Date_Modified, U.UserID
		from mySobek_User U, mySobek_User_Description_Tags T, SobekCM_Item I, SobekCM_Item_Group G, SobekCM_Item_Aggregation_Item_Link L, SobekCM_Item_Aggregation A
		where ( I.ItemID = L.ItemID )
		  and ( L.AggregationID = A.AggregationID )
		  and ( A.Code = @aggregationcode )
		  and ( I.GroupID = G.GroupID )
		  and ( T.ItemID = I.ItemID )
		  and ( T.UserID = U.UserID )
		order by T.Date_Modified DESC;
	end
	else
	begin
		-- Return any descriptive tags
		select U.FirstName, U.NickName, U.LastName, G.BibID, I.VID, T.Description_Tag, T.TagID, T.Date_Modified, U.UserID
		from mySobek_User U, mySobek_User_Description_Tags T, SobekCM_Item I, SobekCM_Item_Group G
		where ( I.GroupID = G.GroupID )
		  and ( T.ItemID = I.ItemID )
		  and ( T.UserID = U.UserID )
		order by T.Date_Modified DESC;
	end;		  
END;
GO


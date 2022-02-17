USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Get_Items_Needing_Aditional_Work]    Script Date: 2/16/2022 9:55:47 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Gets the list of itesm currently flagged for needing additional work.
-- This is used by the builder to determine what needs post-processing.
CREATE procedure [dbo].[SobekCM_Get_Items_Needing_Aditional_Work]
as
begin

	-- No need to perform any locks here.  A slightly dirty read won't hurt much
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	-- Return the bibid, vid, and primary key to the items which are flagged
	select G.BibID, I.VID, I.ItemID
	from SobekCM_Item I, SobekCM_Item_Group G
	where ( I.GroupID = G.GroupID )
	  and ( I.AdditionalWorkNeeded = 'true' )
	order by BibID, VID;
end;
GO


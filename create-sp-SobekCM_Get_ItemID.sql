USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Get_ItemID]    Script Date: 2/15/2022 11:35:30 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



-- Procedure returns the item id as a single row given the bibid and vid.
-- This also doubles as a quick way to check if a certain item exists in
-- the database and is employed by some of the workflow tools
CREATE PROCEDURE [dbo].[SobekCM_Get_ItemID]
	@bibid varchar(10),
	@vid varchar(5)
AS
begin

	-- No need to perform any locks here
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	-- Return the item id as a single row relation
	select ItemID
	from SobekCM_Item I, SobekCM_Item_Group G
	where I.GroupID=G.GroupID 
	  and I.VID=@vid
	  and G.BibID=@bibid;

end;
GO


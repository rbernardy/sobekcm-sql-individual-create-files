USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Items_By_ALEPH]    Script Date: 2/20/2022 6:09:16 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Get the list of items by ALEPH number
CREATE PROCEDURE [dbo].[SobekCM_Items_By_ALEPH] 
	@aleph_number int
AS
BEGIN
	
	-- Return the item informaiton
	select BibID, VID, SortDate, Spatial_KML, fk_TitleID = I.GroupID, Title 
	from SobekCM_Item I, SobekCM_Item_Group G
	where I.GroupID = G.GroupID 
	  and G.ALEPH_Number = @aleph_number
	order by BibID ASC, VID ASC

	-- Return the title information
	select G.BibID, G.SortTitle, TitleID=G.GroupID, [Rank]=-1
	from SobekCM_Item_Group G
	where  G.ALEPH_Number = @aleph_number
	order by BibID ASC
	
END
GO


USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Items_By_OCLC]    Script Date: 2/20/2022 6:23:10 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Get the list of items by OCLC number
CREATE PROCEDURE [dbo].[SobekCM_Items_By_OCLC] 
	@oclc_number bigint
AS
BEGIN
	
	-- Return the item informaiton
	select BibID, VID, SortDate, Spatial_KML, fk_TitleID = I.GroupID, Title 
	from SobekCM_Item I, SobekCM_Item_Group G
	where I.GroupID = G.GroupID 
	  and G.OCLC_Number = @oclc_number
	order by BibID ASC, VID ASC

	-- Return the title information
	select G.BibID, G.SortTitle, TitleID=G.GroupID, [Rank]=-1
	from SobekCM_Item_Group G
	where  G.OCLC_Number = @oclc_number
	order by BibID ASC
	
END
GO


USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[Tracking_Items_By_ALEPH]    Script Date: 3/17/2022 11:17:02 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Get the list of items by ALEPH number
-- This is identical to SobekCM_Items_By_ALEPH, EXCEPT:
--    (1) Title, Author, IP restriction flag, Thumbnail, and Publisher returned with item list
--    (2) Group title, thumbnail, type, OCLC, and ALEPH returned with title list
CREATE PROCEDURE [dbo].[Tracking_Items_By_ALEPH] 
	@aleph_number int
AS
BEGIN
	
	-- Return the item informaiton
	select BibID, VID, SortDate, Spatial_KML, fk_TitleID = I.GroupID, Title, Author, Publisher, IP_Restriction_Mask, MainThumbnail as Thumbnail
	from SobekCM_Item I, SobekCM_Item_Group G
	where I.GroupID = G.GroupID 
	  and G.ALEPH_Number = @aleph_number
	order by BibID ASC, VID ASC

	-- Return the title information
	select G.BibID, G.SortTitle, TitleID=G.GroupID, [Rank]=-1, G.GroupTitle, G.GroupThumbnail, G.[Type], G.ALEPH_Number, G.OCLC_Number
	from SobekCM_Item_Group G
	where  G.ALEPH_Number = @aleph_number
	order by BibID ASC
	
END
GO


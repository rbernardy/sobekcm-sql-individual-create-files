USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Clear_Region_Link_By_Item]    Script Date: 2/6/2022 7:50:03 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Clears any link between a region and an item
CREATE PROCEDURE [dbo].[SobekCM_Clear_Region_Link_By_Item] 
	@itemid int
AS
begin

	-- Delete all lnks
	delete from SobekCM_Item_GeoRegion_Link
	where ItemID = @itemid;

end;
GO


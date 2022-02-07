USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Clear_Old_Item_Info]    Script Date: 2/6/2022 7:40:39 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


/****** Object:  StoredProcedure [dbo].[SobekCM_Clear_Old_Item_Info]    Script Date: 12/20/2013 05:43:36 ******/
-- Clears all the periphery data about an item in UFDC
CREATE PROCEDURE [dbo].[SobekCM_Clear_Old_Item_Info]
	@ItemID int
AS
begin

		-- Delete all lnks to georegion (if table exists)
		IF ( OBJECT_ID('SobekCM_Item_GeoRegion_Link') IS NOT NULL )
		BEGIN
			delete from SobekCM_Item_GeoRegion_Link where ItemID = @itemid;
		END;

		-- Deletes the immediate geographic footprint (if table exists)
		IF ( OBJECT_ID('SobekCM_Item_Footprint') IS NOT NULL )
		BEGIN
			delete from SobekCM_Item_Footprint where ItemID = @ItemID;
		END;

end;
GO


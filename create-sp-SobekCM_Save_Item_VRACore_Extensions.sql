USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Save_Item_VRACore_Extensions]    Script Date: 3/14/2022 8:37:46 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Save the metadata from the VRACore metadata extension
CREATE PROCEDURE [dbo].[SobekCM_Save_Item_VRACore_Extensions]
	@ItemID int,
	@Material_Display nvarchar(1000),
	@Measurement_Display nvarchar(1000), 
	@StylePeriod_Display nvarchar(1000), 
	@Technique_Display nvarchar(1000)
AS
BEGIN
	-- Update existing row
	update SobekCM_Item
	set Material_Display=@Material_Display, Measurement_Display=@Measurement_Display,
	    StylePeriod_Display=@StylePeriod_Display, Technique_Display=@Technique_Display
	where ItemID=@ItemID;
	
END;
GO


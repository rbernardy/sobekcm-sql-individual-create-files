USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Delete_Portal]    Script Date: 2/8/2022 9:15:36 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Delete an entire URL Portal, by URL portal ID
CREATE PROCEDURE [dbo].[SobekCM_Delete_Portal]
	@PortalID int
AS
BEGIN

	-- Remove anything linked to this one
	delete from SobekCM_Portal_Item_Aggregation_Link where PortalID=@PortalID;
	delete from SobekCM_Portal_Web_Skin_Link where PortalID=@PortalID;
	delete from SobekCM_Portal_URL_Statistics where PortalID=@PortalID;
	delete from SobekCM_Portal_URL where PortalID = @PortalID;
END;
GO


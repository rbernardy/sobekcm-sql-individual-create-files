USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Save_Item_Complete_KML]    Script Date: 2/23/2022 9:23:45 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SobekCM_Save_Item_Complete_KML]
	@ItemID int,
	@CompleteKML varchar(max)
AS
BEGIN

	update SobekCM_Item
	set Complete_KML = @CompleteKML
	where ItemID=@ItemID;
END;
GO


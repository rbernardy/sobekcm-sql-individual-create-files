USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[Tracking_Update_Born_Digital]    Script Date: 3/22/2022 9:33:53 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Tracking_Update_Born_Digital]
	@Born_Digital bit,
	@ItemID int
AS
begin

	-- Update the item row
	update SobekCM_Item 
	set Born_Digital = @Born_Digital 
	where ItemID = @ItemID

end
GO


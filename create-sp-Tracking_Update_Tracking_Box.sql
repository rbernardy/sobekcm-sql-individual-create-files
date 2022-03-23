USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[Tracking_Update_Tracking_Box]    Script Date: 3/22/2022 10:28:52 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Tracking_Update_Tracking_Box]
	@Tracking_Box varchar(25),
	@ItemID int
AS
begin

	-- Update the item row
	update SobekCM_Item set Tracking_Box = @Tracking_Box where ItemID = @ItemID
	
	-- Create the full citation, which also copies this into the metadata table
	exec SobekCM_Create_Full_Citation_Value @ItemID	
end
GO


USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Save_Item_Behaviors_Minimal]    Script Date: 2/23/2022 9:18:30 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Saves the behavior information about an item in this library
-- Written by Mark Sullivan 
CREATE PROCEDURE [dbo].[SobekCM_Save_Item_Behaviors_Minimal]
	@ItemID int,
	@TextSearchable bit
AS
begin transaction;

	--Update the main item
	update SobekCM_Item
	set TextSearchable = @TextSearchable
	where ( ItemID = @ItemID );

commit transaction;
GO


USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[Tracking_Update_Disposition_Advice]    Script Date: 3/22/2022 10:05:21 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Tracking_Update_Disposition_Advice]
	@Disposition_Advice int,
	@Disposition_Advice_Notes varchar(150),
	@ItemID int
AS
begin

	-- Update the item row
	update SobekCM_Item set Disposition_Advice = @Disposition_Advice, Disposition_Advice_Notes = @Disposition_Advice_Notes where ItemID = @ItemID

end
GO


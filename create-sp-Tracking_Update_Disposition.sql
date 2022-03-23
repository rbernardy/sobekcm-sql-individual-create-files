USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[Tracking_Update_Disposition]    Script Date: 3/22/2022 9:57:30 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Tracking_Update_Disposition]
	@Disposition_Date datetime,
	@Disposition_Type int,
	@Disposition_Notes varchar(150),
	@ItemID int,
	@UserName varchar(50)
AS
begin

	-- Update the item row
	update SobekCM_Item set Disposition_Date = @Disposition_Date, Disposition_Type = @Disposition_Type, Disposition_Notes=@Disposition_Notes where ItemID = @ItemID
	
	-- Add as a workflow
	insert into Tracking_Progress ( ItemID, WorkFlowID, DateCompleted, WorkPerformedBy, ProgressNote, WorkingFilePath )
	values ( @itemid, 43, @Disposition_Date, @UserName, @Disposition_Notes + ' (ADDED ' + CONVERT(VARCHAR(10), GETDATE(), 101) + ')', '' )	
end
GO


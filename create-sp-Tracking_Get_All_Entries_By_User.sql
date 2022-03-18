USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[Tracking_Get_All_Entries_By_User]    Script Date: 3/17/2022 9:39:11 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


--Stored procedure for getting all the tracking workflow entries by user
--entered through the tracking sheet
CREATE PROCEDURE [dbo].[Tracking_Get_All_Entries_By_User]
	@username nvarchar(50)
	
AS
BEGIN

	
		select P.ItemID,P.ProgressID, W.WorkFlowName, W.Start_Event_Desc, W.End_Event_Desc, W.Start_Event_Number, W.End_Event_Number, W.Start_And_End_Event_Number,
		       P.DateStarted, P.DateCompleted, P.RelatedEquipment, P.WorkPerformedBy, P.WorkingFilePath, P.ProgressNote
		from Tracking_Progress P, Tracking_Workflow W
		where P.WorkFlowID = W.WorkFlowID
		and P.WorkPerformedBy = @username;


END;
GO


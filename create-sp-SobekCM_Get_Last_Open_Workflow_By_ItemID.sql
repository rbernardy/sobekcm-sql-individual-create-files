USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Get_Last_Open_Workflow_By_ItemID]    Script Date: 2/16/2022 10:01:12 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SobekCM_Get_Last_Open_Workflow_By_ItemID]
	@ItemID int,
	@EventNumber int
AS
BEGIN

	-- Get the workflow id
	declare @workflowid int;
	set @workflowid = coalesce((select WorkFlowID from Tracking_Workflow where Start_Event_Number = @EventNumber or End_Event_Number = @EventNumber ), -1);
	
	-- If there is a match continue
	if ( @workflowid > 0 )
	begin
	
		select P.ItemID,P.ProgressID, W.WorkFlowName, W.Start_Event_Desc, W.End_Event_Desc, W.Start_Event_Number, W.End_Event_Number, W.Start_And_End_Event_Number,
		       P.DateStarted, P.DateCompleted, P.RelatedEquipment, P.WorkPerformedBy, P.WorkingFilePath, P.ProgressNote
		from Tracking_Progress P, Tracking_Workflow W
		where ItemID = @ItemID
		  and P.WorkFlowID = @workflowid
		  and P.WorkFlowID = W.WorkFlowID
		  and ( DateCompleted is null );
		  
	
	end;
END;
GO


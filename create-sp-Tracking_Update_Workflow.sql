USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[Tracking_Update_Workflow]    Script Date: 3/22/2022 10:33:45 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Tracking_Update_Workflow]
	@itemid int,
	@user varchar(50),
	@dateStarted DateTime,
	@dateCompleted DateTime,
	@relatedEquipment varchar(1000),
	@EventNumber int,
	@StartEventNumber int,
	@EndEventNumber int,
	@workflow_entry_id int 
AS
	
	begin
		-- Get the workflow id
		declare @workflowid int
		
		-- Get the existing ID for this workflow
			
	    set @workflowid = coalesce((select WorkFlowID from Tracking_Workflow where Start_Event_Number = @EventNumber or End_Event_Number = @EventNumber ), -1);
	
		-- Update this workflow entry 
		Update Tracking_Progress
		set DateStarted=@dateStarted, 
		    DateCompleted=@dateCompleted,
		    RelatedEquipment=@relatedEquipment,
		    Start_Event_Number=@StartEventNumber,
		    End_Event_Number = @EndEventNumber,
		    WorkFlowID = @workflowid,
		    WorkPerformedBy = @user
		where ProgressID=@workflow_entry_id;
		 
	end
GO


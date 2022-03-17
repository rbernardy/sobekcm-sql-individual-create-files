USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[Tracking_Add_New_Workflow]    Script Date: 3/17/2022 7:56:44 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Tracking_Add_New_Workflow]
	@itemid int,
	@user varchar(50),
	@dateStarted DateTime,
	@dateCompleted DateTime,
	@relatedEquipment varchar(1000),
	@EventNumber int,
	@StartEventNumber int,
	@EndEventNumber int,
	@Start_End_Event int,
	@workflow_entry_id int output
AS
begin transaction
	
	begin
		-- Get the workflow id
		declare @workflowid int
		
		-- Get the matching ID for this workflow
			
	    set @workflowid = coalesce((select WorkFlowID from Tracking_Workflow where Start_Event_Number = @EventNumber or End_Event_Number = @EventNumber ), -1);
	
		-- Add this new workflow entry 
		insert into Tracking_Progress ( ItemID, WorkFlowID, DateStarted, DateCompleted, WorkPerformedBy, RelatedEquipment, Start_Event_Number, End_Event_Number, Start_And_End_Event_Number)
		values ( @itemid, @workflowid, @dateStarted, @dateCompleted, @user, @relatedEquipment, @StartEventNumber, @EndEventNumber, @Start_End_Event );
		
		set @workflow_entry_id=@@IDENTITY;
	end
commit transaction
GO


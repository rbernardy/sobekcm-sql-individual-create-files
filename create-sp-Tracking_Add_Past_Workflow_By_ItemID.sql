USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[Tracking_Add_Past_Workflow_By_ItemID]    Script Date: 3/17/2022 8:12:28 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Tracking_Add_Past_Workflow_By_ItemID]
	@itemid int,
	@user varchar(50),
	@progressnote varchar(1000),
	@workflow varchar(100),
	@storagelocation varchar(255),
	@date datetime
AS
begin transaction
	    
	-- continue if an itemid was located
	if ( isnull( @itemid, -1 ) > 0 )
	begin
		-- Get the workflow id
		declare @workflowid int
		if ( ( select COUNT(*) from Tracking_WorkFlow where ( WorkFlowName=@workflow)) > 0 )
		begin
			-- Get the existing ID for this workflow
			select @workflowid = workflowid from Tracking_WorkFlow where WorkFlowName=@workflow
		end
		else
		begin 
			-- Create the workflow for this
			insert into Tracking_WorkFlow ( WorkFlowName, WorkFlowNotes )
			values ( @workflow, 'Added ' + CONVERT(VARCHAR(10), GETDATE(), 101) + ' by ' + @user )
			
			-- Get this ID
			set @workflow = @@IDENTITY
		end
	
		-- Just add this new progress then
		insert into Tracking_Progress ( ItemID, WorkFlowID, DateCompleted, WorkPerformedBy, ProgressNote, WorkingFilePath )
		values ( @itemid, @workflowid, @date, @user, @progressnote, @storagelocation )
	end
commit transaction
GO


USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[Tracking_Add_Workflow_Once_Per_Day]    Script Date: 3/17/2022 9:00:11 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Tracking_Add_Workflow_Once_Per_Day]
	@bibid varchar(10),
	@vid varchar(5),
	@user varchar(50),
	@progressnote varchar(1000),
	@workflowid int,
	@storagelocation varchar(255)
AS
begin transaction

	-- Get the volume id
	declare @itemid int

	select @itemid = ItemID
	from SobekCM_Item_Group G, SobekCM_Item I
	where ( BibID = @bibid )
	    and ( I.GroupID = G.GroupID ) 
	    and ( VID = @vid)

	-- continue if an itemid was located
	if ( isnull( @itemid, -1 ) > 0 )
	begin
		-- Does a progress already exist for this which is not completed?
		if ( (select count(*) from Tracking_Progress where ( ItemID = @itemid ) and ( WorkFlowID = @workflowid ) and ( DateCompleted is null )) > 0 )
		begin
			-- If this is to mark it complete, alter existing progress
			update Tracking_Progress
			set DateCompleted = getdate(), WorkPerformedBy = @user, WorkingFilePath=@storagelocation, ProgressNote = @progressnote
			where ( ItemID = @itemid ) and ( WorkFlowID = @workflowid ) and ( DateCompleted is null )
		end
		else
		begin
			-- only enter one of these per day
			if ( (select count(*) from Tracking_Progress where ( ItemID = @itemid ) and ( WorkFlowID=@workflowid ) and ( isnull( CONVERT(VARCHAR(10), DateCompleted, 102), '') = CONVERT(VARCHAR(10), getdate(), 102) )) = 0 )
			begin
				-- Just add this new progress then
				insert into Tracking_Progress ( ItemID, WorkFlowID, DateCompleted, WorkPerformedBy, ProgressNote, WorkingFilePath )
				values ( @itemid, @workflowid, getdate(), @user, @progressnote, @storagelocation )
			end
		end
	end
commit transaction
GO


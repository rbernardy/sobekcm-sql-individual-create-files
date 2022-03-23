USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[Tracking_Submit_QC_Log]    Script Date: 3/22/2022 9:31:08 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Submit a log about QCing a volume
-- Written by Mark Sullivan ( March 2006 )
CREATE PROCEDURE [dbo].[Tracking_Submit_QC_Log]
	@bibid varchar(10),
	@vid varchar(5),
	@notes varchar(255),
	@scanqc varchar(100),
	@qcstatusid int,
	@volumeerrortypeid int,
	@storagelocation varchar(50)
AS
begin transaction

	-- Get the volume id
	declare @itemid int

	select @itemid = ItemID
	from SobekCM_Item_Group G, SobekCM_Item I
	where ( BibID = @bibid )
	    and ( I.GroupID = G.GroupID ) 
	    and ( VID = @vid)

	-- Add REJECTS to the process table
	if ( @qcstatusid = 3 )
	begin
			-- Add this new progress 
			insert into Tracking_Progress ( ItemID, WorkFlowID, DateCompleted, ProgressNote, WorkPerformedBy, WorkingFilePath )
			values ( @itemid, 31,  getdate(), @notes, @scanqc, @storagelocation )
	end

	-- Add PRELIMINARIES to the process table
	if ( @qcstatusid = 5 )
	begin
			-- Add this new progress 
			insert into Tracking_Progress ( ItemID, WorkFlowID, DateCompleted, ProgressNote, WorkPerformedBy, WorkingFilePath )
			values ( @itemid, 41,  getdate(), @notes, @scanqc, @storagelocation )
	end
	
	-- Add ACCEPTS and also close some milestones
	if ( @qcstatusid = 4 )
	begin
		-- Add this new progress 
		insert into Tracking_Progress ( ItemID, WorkFlowID, DateCompleted, ProgressNote, WorkPerformedBy, WorkingFilePath )
		values ( @itemid, 5, getdate(), @notes, @scanqc, @storagelocation )
		
		-- Update the QC milestones
		update SobekCM_Item
		set Milestone_DigitalAcquisition = ISNULL(Milestone_DigitalAcquisition, getdate()),
		    Milestone_ImageProcessing = ISNULL(Milestone_ImageProcessing, getdate()),
		    Milestone_QualityControl = ISNULL(Milestone_QualityControl, getdate()),
		    Last_MileStone = 3
		where ItemID=@itemid
		
		-- If the item is public, update the last milestone as well
		if ( ( select COUNT(*) from SobekCM_Item where ItemID=@itemid and (( Dark = 'true' ) or ( IP_Restriction_Mask >= 0 ))) > 0 )
		begin		
			-- Move along to the COMPLETED milestone
			update SobekCM_Item
			set Milestone_OnlineComplete = ISNULL(Milestone_OnlineComplete, getdate()),
				Last_MileStone=4
			where ItemID=@itemid		
		end		
	end

commit transaction
GO


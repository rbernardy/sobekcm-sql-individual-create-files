USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Set_IP_Restriction_Mask]    Script Date: 3/15/2022 7:38:44 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Set the IP restriction mask on a single item, by a single user, and
-- add a progress note that this was done
CREATE PROCEDURE [dbo].[SobekCM_Set_IP_Restriction_Mask]
	@itemid int,
	@newipmask int,
	@user varchar(50),
	@progressnote varchar(1000)
AS
begin transaction

	-- Update the item table
	update SobekCM_Item
	set IP_Restriction_Mask=@newipmask
	where ItemID=@itemid;
	
	-- Update the workhistory and possibly milestones
	if ( @newipmask < 0 )
	begin
		-- Add a worklog for this making the item PRIVATE
		insert into Tracking_Progress ( ItemID, WorkFlowID, DateCompleted, WorkPerformedBy, ProgressNote )
		values ( @itemid, 35, GETDATE(), @user, @progressnote );
	end
	else
	begin
		if ( @newipmask = 0 )
		begin
			-- Add a worklog for this making the item PUBLIC
			insert into Tracking_Progress ( ItemID, WorkFlowID, DateCompleted, WorkPerformedBy, ProgressNote )
			values ( @itemid, 34, GETDATE(), @user, @progressnote )		;
			
			-- Set the aggregations linked to this item's LastItemAdded date
			update SobekCM_Item_Aggregation
			set LastItemAdded = GETDATE()
			where exists ( select * from SobekCM_Item_Aggregation_Item_Link L where L.ItemID=@itemid and L.AggregationID = SobekCM_Item_Aggregation.AggregationID );	
		end
		else
		begin
			-- Add a worklog for this making the item RESTRICTED
			insert into Tracking_Progress ( ItemID, WorkFlowID, DateCompleted, WorkPerformedBy, ProgressNote )
			values ( @itemid, 36, GETDATE(), @user, @progressnote );
		end;
		
		-- Move along to the COMPLETED milestone
		update SobekCM_Item
		set Milestone_DigitalAcquisition = ISNULL(Milestone_DigitalAcquisition, getdate()),
		    Milestone_ImageProcessing = ISNULL(Milestone_ImageProcessing, getdate()),
		    Milestone_QualityControl = ISNULL(Milestone_QualityControl, getdate()),
		    Milestone_OnlineComplete = ISNULL(Milestone_OnlineComplete, getdate()),
		    Last_MileStone=4
		where ItemID=@itemid;
	end;

commit transaction;
GO


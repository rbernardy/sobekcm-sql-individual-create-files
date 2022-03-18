USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[Tracking_Get_Work_History]    Script Date: 3/17/2022 11:08:30 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



-- Get the tracking work history against this item and the milestones
CREATE PROCEDURE [dbo].[Tracking_Get_Work_History]
	@bibid varchar(10),
	@vid varchar(5)
AS
BEGIN	

	-- No need to perform any locks here
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
	
	-- Get the item id
	declare @itemid int;
	set @itemid = coalesce( ( select I.ItemID from SobekCM_Item I, SobekCM_Item_Group G where I.GroupID=G.GroupID and I.VID=@vid and G.BibiD=@bibid ), -1 );

	-- Get the item id
	declare @groupid int;
	set @groupid = coalesce( ( select G.GroupID from SobekCM_Item_Group G where G.BibiD=@bibid ), -1 );

	-- Return all the progress information for this volume
	select P.WorkFlowID, [Workflow Name]=WorkFlowName, [Completed Date]=isnull(CONVERT(CHAR(10), DateCompleted, 102),''), WorkPerformedBy=isnull(WorkPerformedBy, ''), Note=isnull(ProgressNote,'')
	from Tracking_Progress P, Tracking_Workflow W
	where (P.workflowid = W.workflowid)
	  and (P.ItemID = @itemid )
	order by DateCompleted ASC;		

	-- Return the milestones as well
	select CreateDate, Milestone_DigitalAcquisition, Milestone_ImageProcessing, Milestone_QualityControl, Milestone_OnlineComplete, Material_Received_Date, Disposition_Date from SobekCM_Item where ItemID=@itemid;
		
END
GO


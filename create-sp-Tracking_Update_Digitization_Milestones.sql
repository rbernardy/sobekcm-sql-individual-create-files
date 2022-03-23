USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[Tracking_Update_Digitization_Milestones]    Script Date: 3/22/2022 9:38:26 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Tracking_Update_Digitization_Milestones]
	@ItemID int,
	@Last_Milestone int,
	@Milestone_Date date
AS
begin

	-- Digital Acquisition milestone
	if ( @Last_Milestone = 1 )
	begin
		-- Move along to the Post-acquisition processing
		update SobekCM_Item
		set Milestone_DigitalAcquisition = ISNULL(Milestone_DigitalAcquisition, @Milestone_Date),
		    Milestone_ImageProcessing = null,
		    Milestone_QualityControl = null,
		    Milestone_OnlineComplete = null,
		    Last_MileStone=1
		where ItemID=@itemid	
	end
	
	-- Post acquisition processing
	if ( @Last_Milestone = 2 )
	begin
		-- Move along to the Post-acquisition processing
		update SobekCM_Item
		set Milestone_DigitalAcquisition = ISNULL(Milestone_DigitalAcquisition, @Milestone_Date),
		    Milestone_ImageProcessing = ISNULL(Milestone_ImageProcessing, @Milestone_Date),
		    Milestone_QualityControl = null,
		    Milestone_OnlineComplete = null,
		    Last_MileStone=2
		where ItemID=@itemid		
	end
	
	-- Quality control complete
	if ( @Last_Milestone = 3 )
	begin
		-- Move along to the QC Complete milestone
		update SobekCM_Item
		set Milestone_DigitalAcquisition = ISNULL(Milestone_DigitalAcquisition, @Milestone_Date),
		    Milestone_ImageProcessing = ISNULL(Milestone_ImageProcessing, @Milestone_Date),
		    Milestone_QualityControl = ISNULL(Milestone_QualityControl, @Milestone_Date),
		    Milestone_OnlineComplete = null,
		    Last_MileStone=3
		where ItemID=@itemid	
	end
	
	-- Digitization complete
	if ( @Last_Milestone = 4 )
	begin	
		-- Move along to the COMPLETED milestone
		update SobekCM_Item
		set Milestone_DigitalAcquisition = ISNULL(Milestone_DigitalAcquisition, @Milestone_Date),
		    Milestone_ImageProcessing = ISNULL(Milestone_ImageProcessing, @Milestone_Date),
		    Milestone_QualityControl = ISNULL(Milestone_QualityControl, @Milestone_Date),
		    Milestone_OnlineComplete = ISNULL(Milestone_OnlineComplete, @Milestone_Date),
		    Last_MileStone=4
		where ItemID=@itemid	
	end
end
GO


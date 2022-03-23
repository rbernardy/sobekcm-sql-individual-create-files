USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[Tracking_Submit_Online_Page_Division]    Script Date: 3/22/2022 9:08:10 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Submit a log about QCing a volume
-- Written by Mark Sullivan ( July 2013 )
CREATE PROCEDURE [dbo].[Tracking_Submit_Online_Page_Division]
	@itemid int,
	@notes varchar(255),
	@onlineuser varchar(100),
	@mainthumbnail varchar(100),
	@mainjpeg varchar(100),
	@pagecount int,
	@filecount int,
	@disksize_kb bigint
AS
begin transaction

		-- Add this new progress 
		if (( select count(*)
		      from Tracking_Progress T
		      where ( T.ItemID=@itemid ) and ( ProgressNote=@notes ) and ( WorkPerformedBy=@onlineuser ) 
		        and ( CONVERT(varchar(10), getdate(), 10) = CONVERT(varchar(10), DateCompleted, 10))
				and ( WorkFlowID=45 )) = 0 )
		begin
			insert into Tracking_Progress ( ItemID, WorkFlowID, DateCompleted, ProgressNote, WorkPerformedBy, WorkingFilePath )
			values ( @itemid, 45, getdate(), @notes, @onlineuser, '' );
		end;
		
		-- Update the QC milestones
		update SobekCM_Item
		set Milestone_DigitalAcquisition = ISNULL(Milestone_DigitalAcquisition, getdate()),
		    Milestone_ImageProcessing = ISNULL(Milestone_ImageProcessing, getdate()),
		    Milestone_QualityControl = ISNULL(Milestone_QualityControl, getdate())
		where ItemID=@itemid;
		
		-- update last mileston
		update SobekCM_Item
		set Last_Milestone = 3
		where ItemID = @itemid and Last_Milestone < 3;
		
		-- If the item is public, update the last milestone as well
		if ( ( select COUNT(*) from SobekCM_Item where ItemID=@itemid and (( Dark = 'true' ) or ( IP_Restriction_Mask >= 0 ))) > 0 )
		begin		
			-- Move along to the COMPLETED milestone
			update SobekCM_Item
			set Milestone_OnlineComplete = ISNULL(Milestone_OnlineComplete, getdate()),
				Last_MileStone=4
			where ItemID=@itemid		
		end;		

		--Update the item table
		update SobekCM_Item set [PageCount]=@pagecount, MainThumbnail = @mainthumbnail, MainJPEG = @mainjpeg, FileCount = @filecount, DiskSize_KB = @disksize_kb
		where ItemID = @itemid;
		
commit transaction
GO


USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[Tracking_PreQC_Complete]    Script Date: 3/22/2022 9:04:40 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Marks this volume''s image complete and qc as selected and pending
-- This is called when an item successfully passes ''Pre-QC!''
-- Written by Mark Sullivan (March 2006)
CREATE PROCEDURE [dbo].[Tracking_PreQC_Complete]
	@bibid varchar(10),
	@vid varchar(5),
	@user varchar(255),
	@storagelocation varchar(255)
AS
begin transaction

	-- Add this pre-qc to the workhistory log
	exec [Tracking_Add_Workflow_Once_Per_Day] @bibid, @vid, @user, '', 4, @storagelocation

	-- Get the volume id
	declare @itemid int

	select @itemid = ItemID
	from SobekCM_Item_Group G, SobekCM_Item I
	where ( BibID = @bibid )
	    and ( I.GroupID = G.GroupID ) 
	    and ( VID = @vid)

	-- continue if a volumeid was located
	if ( isnull( @itemid, -1 ) > 0 )
	begin
		-- Update the milestones
		update SobekCM_Item
		set Milestone_DigitalAcquisition = ISNULL(Milestone_DigitalAcquisition, getdate()),
		    Milestone_ImageProcessing = ISNULL(Milestone_ImageProcessing, getdate()),
		    Last_MileStone=2
		where ItemID=@itemid
	end

commit transaction
GO


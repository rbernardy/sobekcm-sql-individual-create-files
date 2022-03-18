USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[Tracking_Archive_Complete]    Script Date: 3/17/2022 9:04:15 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Marks this volume as having files archived to TIVOLI
-- This is called when an item is moved into the tivoli area by the Tivoli Processor application
-- Written by Mark Sullivan (October 2009)
CREATE PROCEDURE [dbo].[Tracking_Archive_Complete]
	@bibid varchar(10),
	@vid varchar(5),
	@user varchar(50),
	@usernotes varchar(1000)
AS
begin transaction

	-- Add this archiving to the workhistory log
	exec [Tracking_Add_Workflow_Once_Per_Day] @bibid, @vid, @user, @usernotes, 28, null
	
	-- If this item is not marked as being internally archived, mark that now
	if (( select COUNT(*) from SobekCM_Item I, SobekCM_Item_Group G where I.GroupID = G.GroupID and I.VID = @vid and G.BibiD=@bibid ) = 1 )
	begin
		-- Get the item id
		declare @itemid int
		select @itemid=ItemID from SobekCM_Item I, SobekCM_Item_Group G where I.GroupID = G.GroupID and I.VID = @vid and G.BibiD=@bibid
		
		-- Check that this is marked as archived
		update SobekCM_Item 
		set Locally_Archived='true'
		where ItemID=@itemid
	
	end

commit transaction
GO


USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[Tracking_Digital_Acquisition_Complete]    Script Date: 3/17/2022 9:21:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Marks this volume image processing complete
-- Written by Mark Sullivan 
CREATE PROCEDURE [dbo].[Tracking_Digital_Acquisition_Complete]
	@bibid varchar(10),
	@vid varchar(5),
	@user varchar(255),
	@storagelocation varchar(255),
	@date datetime
AS
begin transaction

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
		set Milestone_DigitalAcquisition = ISNULL(Milestone_DigitalAcquisition, @date)
		where ItemID=@itemid
	end

commit transaction
GO


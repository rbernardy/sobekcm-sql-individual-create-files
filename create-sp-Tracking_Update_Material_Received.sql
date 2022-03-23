USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[Tracking_Update_Material_Received]    Script Date: 3/22/2022 10:17:40 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Tracking_Update_Material_Received]
	@Material_Received_Date datetime,
	@Material_Recd_Date_Estimated bit,
	@ItemID int,
	@User varchar(255),
	@ProgressNote varchar(1000)
AS
begin

	-- Update the item row
	update SobekCM_Item 
	set Material_Received_Date=@Material_Received_Date, Material_Recd_Date_Estimated=@Material_Recd_Date_Estimated
	where ItemID = @ItemID
	
	-- If this is not a widely innacurate estimate, add this as a worklog entry as well
	if ( @Material_Recd_Date_Estimated = 'false' )
	begin
		-- Add into worklog history
		insert into Tracking_Progress ( ItemID, WorkFlowID, DateCompleted, WorkPerformedBy, ProgressNote, WorkingFilePath )
		values ( @ItemID, 42, @Material_Received_Date, @User, @ProgressNote, '' )	
	end
end
GO


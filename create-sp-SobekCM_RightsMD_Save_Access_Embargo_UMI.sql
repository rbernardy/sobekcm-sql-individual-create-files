USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_RightsMD_Save_Access_Embargo_UMI]    Script Date: 2/22/2022 8:30:26 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SobekCM_RightsMD_Save_Access_Embargo_UMI]
	@ItemID int,
	@Original_AccessCode varchar(25),
	@EmbargoEnd date,
	@UMI varchar(20)
AS
BEGIN

	-- Only insert if it doesn't exist
	if ( exists ( select * from Tracking_Item where ItemID=@ItemID ))
	begin
		--update existing, not updating 'original_' columns
		update Tracking_Item
		set EmbargoEnd = @EmbargoEnd, UMI=@UMI
		where ItemID=@ItemID;
	end
	else
	begin
		-- Insert ALL the data
		insert into Tracking_Item ( ItemID, Original_AccessCode, Original_EmbargoEnd, EmbargoEnd, UMI )
		values ( @ItemID, @Original_AccessCode, @EmbargoEnd, @EmbargoEnd, @UMI );
	end;
END;
GO


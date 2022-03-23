USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[Tracking_Update_Physical_Milestones]    Script Date: 3/22/2022 10:25:10 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Tracking_Update_Physical_Milestones] 
	@bibid varchar(10),
	@vid varchar(5),
	@tracking_box varchar(25),
	@born_digital bit,
	@material_received_date datetime,
	@material_recd_date_estimated bit,
	@disposition_advice int,
	@disposition_date datetime,
	@disposition_type int
AS
begin

	-- Get the item id
	declare @itemid int
	select @itemid = ItemID
	from SobekCM_Item_Group G, SobekCM_Item I
	where ( BibID = @bibid )
	    and ( I.GroupID = G.GroupID ) 
	    and ( VID = @vid)

	-- Now, update the item row
	update SobekCM_Item
	set Tracking_BOx=@tracking_box, Born_Digital=@born_digital, Material_Received_Date=@material_received_date,
		Disposition_Advice=@disposition_advice, Disposition_Date=@disposition_date,
		Disposition_Type=@disposition_type, Material_Recd_Date_Estimated = @material_recd_date_estimated
	where ItemID=@itemid

end
GO


USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Set_Item_Comments]    Script Date: 3/15/2022 7:59:51 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Procedure sets the internal comments for an item
CREATE PROCEDURE [dbo].[SobekCM_Set_Item_Comments]
	@itemid int,
	@newcomments nvarchar(1000)
AS
begin

	-- Update the item table
	update SobekCM_Item
	set Internal_Comments=@newcomments
	where ItemID = @itemid;

end;
GO


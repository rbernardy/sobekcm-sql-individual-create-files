USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Save_Serial_Hierarchy]    Script Date: 3/14/2022 10:36:09 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Adds the link between the item and the group and also adds the serial hierarchy
-- Stored procedure written by Mark Sullivan ( September 2006 )
CREATE PROCEDURE [dbo].[SobekCM_Save_Serial_Hierarchy]
	@GroupID int,
	@ItemID int,
	@Level1_Text varchar(255),
	@Level1_Index int,
	@Level2_Text varchar(255),
	@Level2_Index int,
	@Level3_Text varchar(255),
	@Level3_Index int,
	@Level4_Text varchar(255),
	@Level4_Index int,
	@Level5_Text varchar(255),
	@Level5_Index int,
	@SerialHierarchy varchar(500)
AS
begin transaction

	update SobekCM_Item
	set Level1_Text = @Level1_Text, Level1_Index = @Level1_Index, 
		Level2_Text = @Level2_Text, Level2_Index = @Level2_Index,
		Level3_Text = @Level3_Text, Level3_Index = @Level3_Index, 
		Level4_Text = @Level4_Text, Level4_Index = @Level4_Index,
		Level5_Text = @Level5_Text, Level5_Index = @Level5_Index
	where ItemID=@ItemID

commit transaction
GO


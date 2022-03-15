USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Save_Project_Item_Link]    Script Date: 3/14/2022 10:24:13 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SobekCM_Save_Project_Item_Link]
	@ProjectID int,
	@ItemID int
AS
Begin
  --If this link does not already exist, insert it
  if((select count(*) from SobekCM_Project_Item_Link  where ( ProjectID = @ProjectID and ItemID=@ItemID ))  < 1 )
    insert into SobekCM_Project_Item_Link(ProjectID, ItemID)
    values(@ProjectID, @ItemID);
End
GO


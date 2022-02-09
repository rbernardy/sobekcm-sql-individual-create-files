USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Delete_Project_Item_Link]    Script Date: 2/8/2022 9:44:02 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[SobekCM_Delete_Project_Item_Link]
	@ProjectID int,
	@ItemID int	
AS
Begin
  --If this link exists, delete it
  if((select count(*) from SobekCM_Project_Item_Link  where ( ProjectID = @ProjectID and ItemID=@ItemID ))  = 1 )
    delete from SobekCM_Project_Item_Link
    where (ProjectID=@ProjectID and ItemID=@ItemID);
End
GO


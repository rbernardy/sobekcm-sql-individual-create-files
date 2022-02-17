USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Get_Items_By_ProjectID]    Script Date: 2/16/2022 9:50:40 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SobekCM_Get_Items_By_ProjectID]
	@ProjectID int
AS
Begin  
  select ItemID 
  from SobekCM_Project_Item_Link
  where ProjectID=@ProjectID;
End
GO


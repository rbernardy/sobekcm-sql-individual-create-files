USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Get_BibID_VID_From_Identifier]    Script Date: 2/10/2022 10:01:51 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SobekCM_Get_BibID_VID_From_Identifier]
	@identifier nvarchar(max)	
AS
BEGIN

  SELECT ig.BibID as bibid,i.VID as vid
  FROM dbo.SobekCM_Metadata_Unique_Search_Table as must join dbo.SobekCM_Metadata_Unique_Link as mul on must.MetadataID=mul.MetadataID
	join dbo.SobekCM_Item as i on mul.ItemID=i.ItemID join dbo.SobekCM_Item_Group as ig on i.GroupID = ig.GroupID 
  where must.MetadataTypeID=17 and must.MetadataValue=@identifier;

END;
GO


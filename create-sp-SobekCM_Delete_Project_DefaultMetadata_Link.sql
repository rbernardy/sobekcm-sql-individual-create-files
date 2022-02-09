USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Delete_Project_DefaultMetadata_Link]    Script Date: 2/8/2022 9:32:18 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SobekCM_Delete_Project_DefaultMetadata_Link]
	@ProjectID int,
	@DefaultMetadataID int	
AS
Begin
  --If this link exists, delete it
  if((select count(*) from SobekCM_Project_DefaultMetadata_Link  where ( ProjectID = @ProjectID and DefaultMetadataID=@DefaultMetadataID ))  = 1 )
    delete from SobekCM_Project_DefaultMetadata_Link
    where (ProjectID=@ProjectID and DefaultMetadataID=@DefaultMetadataID);
End
GO


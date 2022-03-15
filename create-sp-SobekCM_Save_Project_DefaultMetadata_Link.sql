USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Save_Project_DefaultMetadata_Link]    Script Date: 3/14/2022 10:17:50 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SobekCM_Save_Project_DefaultMetadata_Link]
	@ProjectID int,
	@DefaultMetadataID int
AS
Begin
  --If this link does not already exist, insert it
  if((select count(*) from SobekCM_Project_DefaultMetadata_Link  where ( ProjectID = @ProjectID and DefaultMetadataID=@DefaultMetadataID ))  < 1 )
    insert into SobekCM_Project_DefaultMetadata_Link(ProjectID, DefaultMetadataID)
    values(@ProjectID, @DefaultMetadataID);
End
GO


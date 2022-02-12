USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Get_DefaultMetadata_By_ProjectID]    Script Date: 2/12/2022 5:25:42 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SobekCM_Get_DefaultMetadata_By_ProjectID]
	@ProjectID int		
AS
Begin
  
  select DefaultMetadataID from SobekCM_Project_DefaultMetadata_Link
  where ProjectID=@ProjectID;
End
GO


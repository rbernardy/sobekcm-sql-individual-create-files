USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Delete_Project_Template_Link]    Script Date: 2/8/2022 9:52:37 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SobekCM_Delete_Project_Template_Link]
	@ProjectID int,
	@TemplateID int	
AS
Begin
  --If this link exists, delete it
  if((select count(*) from SobekCM_Project_Template_Link  where ( ProjectID = @ProjectID and TemplateID=@TemplateID ))  = 1 )
    delete from SobekCM_Project_Template_Link
    where (ProjectID=@ProjectID and TemplateID=@TemplateID);
End
GO


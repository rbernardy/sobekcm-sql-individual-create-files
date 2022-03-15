USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Save_Project_Template_Link]    Script Date: 3/14/2022 10:29:37 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SobekCM_Save_Project_Template_Link]
	@ProjectID int,
	@TemplateID int
AS
Begin
  --If this link does not already exist, insert it
  if((select count(*) from SobekCM_Project_Template_Link  where ( ProjectID = @ProjectID and TemplateID=@TemplateID ))  < 1 )
    insert into SobekCM_Project_Template_Link(ProjectID, TemplateID)
    values(@ProjectID, @TemplateID);
End
GO


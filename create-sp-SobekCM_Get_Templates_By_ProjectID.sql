USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Get_Templates_By_ProjectID]    Script Date: 2/17/2022 9:48:12 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SobekCM_Get_Templates_By_ProjectID]
	@ProjectID int
AS
Begin
  
  select TemplateID from SobekCM_Project_Template_Link
  where ProjectID=@ProjectID;
End
GO


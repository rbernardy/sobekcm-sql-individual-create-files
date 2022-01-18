USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[mySobek_Get_All_Template_DefaultMetadatas]    Script Date: 1/17/2022 7:56:06 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Get the list of all templates and default metadata sets 
CREATE PROCEDURE [dbo].[mySobek_Get_All_Template_DefaultMetadatas]
AS
BEGIN
	
	select MetadataCode, MetadataName, [Description], UserID
	from mySobek_DefaultMetadata
	order by MetadataCode;

	select TemplateCode, TemplateName, [Description]
	from mySobek_Template
	order by TemplateCode;

END;
GO


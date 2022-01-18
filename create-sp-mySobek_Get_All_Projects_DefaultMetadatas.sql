USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[mySobek_Get_All_Projects_DefaultMetadatas]    Script Date: 1/17/2022 7:48:47 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Get the list of all templates and default metadata sets 
CREATE PROCEDURE [dbo].[mySobek_Get_All_Projects_DefaultMetadatas]
AS
BEGIN
	
	select * 
	from mySobek_DefaultMetadata
	order by MetadataCode;

	select * 
	from mySobek_Template
	order by TemplateCode;

END;
GO


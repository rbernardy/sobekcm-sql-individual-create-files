USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Get_Translation]    Script Date: 2/17/2022 10:00:17 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Gets the translations for the headings used in the SobekCM system
CREATE PROCEDURE [dbo].[SobekCM_Get_Translation] AS
begin
	
	-- No need to perform any locks here
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	select * from SobekCM_Metadata_Translation;

end;
GO


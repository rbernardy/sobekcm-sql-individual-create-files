USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Get_OAI_Data_Codes]    Script Date: 2/16/2022 11:22:24 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Gets the distinct data codes present in the database for OAI (such as 'oai_dc')
CREATE PROCEDURE [dbo].[SobekCM_Get_OAI_Data_Codes]
AS
BEGIN
	-- Dirty read here won't hurt anything
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	-- Return distinct codes used in the OAI table
	select distinct(Data_Code)
	from SobekCM_Item_OAI;
END;
GO


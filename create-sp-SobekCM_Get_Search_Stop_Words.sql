USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Get_Search_Stop_Words]    Script Date: 2/17/2022 8:43:41 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



-- Get the list of stop words which are skipped during searching.  This is
-- used to ensure stop words are not passed into the database searching
-- mechanism, which will cause it to fail in certain searches
CREATE PROCEDURE [dbo].[SobekCM_Get_Search_Stop_Words]
AS
BEGIN
	-- Return all the stored stop words
	select *
	from SobekCM_Search_Stop_Words;
END;
GO


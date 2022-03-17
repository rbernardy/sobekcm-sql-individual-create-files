USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_WebContent_All_Brief]    Script Date: 3/16/2022 8:38:23 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Return a brief account of all the web content pages, regardless of whether they are redirects or an actual content page
CREATE PROCEDURE [dbo].[SobekCM_WebContent_All_Brief]
AS
BEGIN

	-- Get the complete list of all active web content pages, with segment level names, primary key, and redirect URL
	select W.WebContentID, W.Level1, W.Level2, W.Level3, W.Level4, W.Level5, W.Level6, W.Level7, W.Level8, W.Redirect
	from SobekCM_WebContent W 
	where Deleted = 'false'
	order by W.Level1, W.Level2, W.Level3, W.Level4, W.Level5, W.Level6, W.Level7, W.Level8;

END;
GO


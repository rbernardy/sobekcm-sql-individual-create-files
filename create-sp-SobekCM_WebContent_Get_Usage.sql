USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_WebContent_Get_Usage]    Script Date: 3/16/2022 9:06:35 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Get the usage stats for a webcontent page (by ID)
CREATE PROCEDURE [dbo].[SobekCM_WebContent_Get_Usage]
	@WebContentID int
AS
BEGIN

	-- Get all stats
	select [Year], [Month], Hits, Hits_Complete
	from SobekCM_WebContent_Statistics
	where WebContentID=@WebContentID
	order by [Year], [Month];

END;
GO


USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Get_Statistics_Dates]    Script Date: 2/17/2022 9:40:12 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Gets the year/month pairing for which this system appears to have 
-- some usage statistics recorded.  This is for the drop-down select 
-- boxes when viewing the usage statistics online
CREATE PROCEDURE [dbo].[SobekCM_Get_Statistics_Dates]
AS
BEGIN

	-- No need to perform any locks here
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
	
	-- Get the distinct years and months
	select [Year], [Month]
	from SobekCM_Statistics
	group by [Year], [Month];

END;
GO


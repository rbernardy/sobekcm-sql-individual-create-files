USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Get_Item_Aggregation_Aliases]    Script Date: 2/12/2022 7:40:39 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



-- Gets the list of all item aggregation aliases and what they forward to
CREATE PROCEDURE [dbo].[SobekCM_Get_Item_Aggregation_Aliases]
AS
BEGIN

	-- No need to perform any locks here
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
	
	-- Return all teh alias information
	select A.AggregationAliasID, A.AggregationAlias, C.Code
	from SobekCM_Item_Aggregation C, SobekCM_Item_Aggregation_Alias A
	where A.AggregationID = C.AggregationID
	order by AggregationAlias;
	
END;
GO


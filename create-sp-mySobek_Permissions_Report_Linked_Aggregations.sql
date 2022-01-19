USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[mySobek_Permissions_Report_Linked_Aggregations]    Script Date: 1/18/2022 10:43:12 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



-- Get the list of aggregations that have special rights given to some users
CREATE PROCEDURE [dbo].[mySobek_Permissions_Report_Linked_Aggregations] AS
BEGIN


	-- Get the list of all aggregations that have special links
	with aggregations_permissioned as
	(
		select distinct AggregationID 
		from mySobek_User_Edit_Aggregation
		union
		select distinct AggregationID 
		from mySobek_User_Group_Edit_Aggregation
	)
	select A.Code, A.Name, A.Type
	from SobekCM_Item_Aggregation A, aggregations_permissioned P
	where A.AggregationID = P.AggregationID
	order by A.Code;

END;
GO


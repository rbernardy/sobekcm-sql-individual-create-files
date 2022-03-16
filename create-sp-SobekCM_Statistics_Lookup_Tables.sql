USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Statistics_Lookup_Tables]    Script Date: 3/15/2022 10:09:37 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Returns the lookup tables for assembling the statistics information
CREATE PROCEDURE [dbo].[SobekCM_Statistics_Lookup_Tables]
AS
BEGIN
	
	-- No need to perform any locks here.
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
	
	-- Return the item id
	select I.ItemID, G.BibID, I.VID
	from SobekCM_Item I, SobekCM_Item_Group G
	where ( I.GroupID = G.GroupID );

	-- Return the group id
	select G.GroupID, G.BibID
	from SobekCM_Item_Group G;

	-- Return the aggregation ids
	select S.AggregationID, S.Code, S.[Type]
	from SobekCM_Item_Aggregation S;
	
	-- Return the portal ids
	select P.PortalID, P.Base_URL, P.Abbreviation, P.isDefault
	from SobekCM_Portal_URL P
	where P.isActive = 'true';

END;
GO


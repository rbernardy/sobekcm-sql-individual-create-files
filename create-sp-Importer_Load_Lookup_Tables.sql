USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[Importer_Load_Lookup_Tables]    Script Date: 1/13/2022 10:35:40 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- This procedure calls other procedures to load data into the 
-- various look up tables used in the application.
CREATE PROCEDURE [dbo].[Importer_Load_Lookup_Tables]
 AS
begin

	-- No need to perform any locks here.  A slightly dirty read won't hurt much
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	-- Get the list of items with identifiers for match checking
	select G.GroupID, ItemID, BibID, VID, G.ALEPH_Number, G.OCLC_Number, GroupTitle, Title
	from SobekCM_Item_Group G, SobekCM_Item I
	where ( G.GroupID = I.GroupID );
	
	-- Get all the institutions and other aggregations
	select *
	from SobekCM_Item_Aggregation A
	order by Code;

	-- Get all the wordmarks
	select * 
	from SobekCM_Icon
    order by Icon_Name;
	
end;
GO


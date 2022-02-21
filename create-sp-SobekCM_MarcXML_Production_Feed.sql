USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_MarcXML_Production_Feed]    Script Date: 2/20/2022 7:19:50 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Pulls the list of items for MARC XML Automation during
-- load of records to production mango
CREATE PROCEDURE [dbo].[SobekCM_MarcXML_Production_Feed]
AS
BEGIN
	
	-- No need to perform any locks here
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
	
	-- Get the list of each BibID and the first VID
	with temp as (
		select G.BibID, G.GroupID, I.VID, I.ItemID, CreateDate, File_Location,
    		row_number() over (partition by G.GroupID order by I.VID) as rownum
		from SobekCM_Item_Group G, SobekCM_Item I
		where ( G.GroupID=I.GroupID )
		  and ( I.Deleted = 'false' )
		  and ( I.IP_Restriction_Mask = 0 )
		  and ( G.Deleted = 'false' )
		  and ( G.Include_In_MarcXML_Prod_Feed = 'true' )
	)
	select BibID, GroupID, VID, ItemID, CreateDate, File_Location
	into #ONE_VID_PER_BIB
	from temp 
	where rownum = 1;
	
	-- Get the list of all public items which are marked to include in 
	-- the marc xml production feed
	select BibID, VID, CreateDate, CollectionCode=C.Code, File_Location
	from #ONE_VID_PER_BIB I, SobekCM_Item_Aggregation_Item_Link CL, SobekCM_Item_Aggregation C
	where ( CL.ItemID = I.ItemID )
	  and ( CL.AggregationID = C.AggregationID )
	  and ( CL.impliedLink = 'false' )
	order by BibID;
	  
	-- Drop the temporary table we are completed with
	drop table #ONE_VID_PER_BIB;

END;
GO


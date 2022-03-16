USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Statistics_Aggregation_Titles]    Script Date: 3/15/2022 9:09:32 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Returns most often hit titles and items for an aggregation
CREATE PROCEDURE [dbo].[SobekCM_Statistics_Aggregation_Titles]
	@code varchar(20)
AS
BEGIN

	-- No need to perform any locks here.
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	-- Is this for the whole library, or just one aggregation?
	if (( @code != 'all' ) and ( LEN(@code) > 0 ))
	begin
		-- Get the aggregation id
		declare @aggregationid int;
		set @aggregationid = ISNULL( (select AggregationID from SobekCM_Item_Aggregation where Code=@code), -1 );
		
		-- Return top 100 items
		select top 100 G.BibID, I.VID, G.GroupTitle, I.Total_Hits
		from SobekCM_Item I, SobekCM_Item_Group G, SobekCM_Item_Aggregation_Item_Link L
		where ( I.GroupID = G.GroupID )
		  and ( I.ItemID = L.ItemID )
		  and ( L.AggregationID = @aggregationid )
		  and ( I.Total_Hits > 0 )
		order by I.Total_Hits DESC;
		
		-- Get the top 100 titles with the most hits
		select top 100 BibID, GroupTitle, SUM(I.Total_Hits) as Title_Hits
		from SobekCM_Item I, SobekCM_Item_Group G, SobekCM_Item_Aggregation_Item_Link L
		where ( I.GroupID = G.GroupID )
		  and ( I.ItemID = L.ItemID )
		  and ( L.AggregationID = @aggregationid )		  
		group by BibID, GroupTitle
		having SUM(I.Total_Hits) > 0
		order by Title_Hits DESC;
	end
	else
	begin
		-- Return top 100 items, library-wide
		select top 100 G.BibID, I.VID, G.GroupTitle, I.Total_Hits
		from SobekCM_Item I, SobekCM_Item_Group G
		where ( I.GroupID = G.GroupID )
		  and ( I.Total_Hits > 0 )
		order by I.Total_Hits DESC;
		
		-- Get the top 100 titles with the most hits, library-wide
		select top 100 BibID, GroupTitle, SUM(I.Total_Hits) as Title_Hits
		from SobekCM_Item I, SobekCM_Item_Group G
		where ( I.GroupID = G.GroupID )
		group by BibID, GroupTitle
		having SUM(I.Total_Hits) > 0
		order by Title_Hits DESC	
	end;
END;
GO


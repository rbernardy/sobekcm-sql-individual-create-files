USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Statistics_Item_Group]    Script Date: 3/15/2022 10:06:24 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Procedure returns all the usage stats on a title, both at the title
-- level, and on each individual item (summed up) under this title
CREATE PROCEDURE [dbo].[SobekCM_Statistics_Item_Group]
	@bibid varchar(10)
AS
begin

	-- No need to perform any locks here.
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	-- Get the item group stats
	WITH Group_CTE ( [Year], [Month], Group_Hits, Group_Sessions )
	AS
	(
		select [Year], [Month], Hits as Group_Hits, [Sessions] as Group_Sessions
		from SobekCM_Item_Group_Statistics GRS, SobekCM_Item_Group G
		where G.BibID=@bibid
		  and G.GroupID = GRS.GroupID
	),
	Items_CTE ( [Year], [Month], Item_Hits, JPEG_Views, Zoomable_Views, Citation_Views, Thumbnail_Views, Text_Search_Views, Flash_Views, Google_Map_Views, Download_Views )
	AS
	(
		-- Get the summed item stats
		select [Year], [Month], SUM(Hits) as Item_Hits, SUM(JPEG_Views) as JPEG_Views, SUM(Zoomable_Views) as Zoomable_Views, 
				SUM(Citation_Views) as Citation_Views, SUM(Thumbnail_Views) as Thumbnail_Views, SUM(Text_Search_Views) as Text_Search_Views, 
				SUM( Flash_Views ) as Flash_Views, SUM( Google_Map_Views) as Google_Map_Views, SUM(Download_Views) as Download_Views
		from SobekCM_Item_Statistics ITS, SobekCM_Item_Group G, SobekCM_Item I
		where G.BibID=@bibid
		  and G.GroupID = I.GroupID
		  and I.ItemID = ITS.ItemID
		group by [Year], [Month]
	)
	  
	-- Return a merged table
	select I.[Year], I.[Month], Total_Hits=ISNULL(Group_Hits,0) + Item_Hits, isnull(Group_Hits,0) as Group_Hits, Item_Hits, JPEG_Views, Zoomable_Views, Citation_Views, Thumbnail_Views, Text_Search_Views, Flash_Views, Google_Map_Views, Download_Views
	from Items_CTE AS I left join
		 Group_CTE as G on G.[Year]=I.[Year] and G.[Month]=I.[Month]	     
	order by I.[Year], I.[Month];

end;
GO


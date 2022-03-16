USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Statistics_Save_Aggregation]    Script Date: 3/15/2022 10:13:06 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SobekCM_Statistics_Save_Aggregation]
	@aggregationid int,
	@year smallint,
	@month smallint,
	@hits int,
	@sessions int,
	@home_page_views int,
	@browse_views int,
	@advanced_search_views int,
	@search_results_views int
as
begin
	insert into SobekCM_Item_Aggregation_Statistics ( AggregationID, [Year], [Month], [Hits], [Sessions], Home_Page_Views, Browse_Views, Advanced_Search_Views, Search_Results_Views ) 
	values ( @aggregationid, @year, @month, @hits, @sessions, @home_page_views, @browse_views, @advanced_search_views, @search_results_views );
end;
GO


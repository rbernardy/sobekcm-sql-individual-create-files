USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Statistics_Save_Item]    Script Date: 3/15/2022 10:16:27 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SobekCM_Statistics_Save_Item]
	@year smallint,
	@month smallint,
	@hits int,
	@sessions int,
	@itemid int,
	@jpeg_views int,
	@zoomable_views int,
	@citation_views int,
	@thumbnail_views int,
	@text_search_views int,
	@flash_views int,
	@google_map_views int,
	@download_views int,
	@static_views int
as
begin

	insert into SobekCM_Item_Statistics ( ItemID, [Year], [Month], [Hits], [Sessions], JPEG_Views, Zoomable_Views, Citation_Views,
		Thumbnail_Views, Text_Search_Views, Flash_Views, Google_Map_Views, Download_Views, Static_Views ) 
	values ( @itemid, @year, @month, @hits, @sessions, @jpeg_views, @zoomable_views, @citation_views,
		@thumbnail_views, @text_search_views, @flash_views, @google_map_views, @download_views, @static_views );

end;
GO


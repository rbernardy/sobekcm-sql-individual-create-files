USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Get_Item_Brief_Info]    Script Date: 2/15/2022 9:41:12 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Get some basic information about an item, which is pulled from the database before the item
-- is displayed online.  Many of these values correspond to the item group/title or how this
-- item relates to the item group and any item aggregations within the system.
CREATE PROCEDURE [dbo].[SobekCM_Get_Item_Brief_Info]
	@bibid varchar(10),
	@vid varchar(5),
	@include_aggregations bit
as
begin

	-- No need to perform any locks here
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	-- Return the item group / item information exactly like it is returned in the Item list brief procedure
	select G.BibID, I.VID, G.GroupTitle, 
			isnull(I.Level1_Text, '') as Level1_Text, isnull( I.Level1_Index, 0 ) as Level1_Index, 
			isnull(I.Level2_Text, '') as Level2_Text, isnull( I.Level2_Index, 0 ) as Level2_Index, 
			isnull(I.Level3_Text, '') as Level3_Text, isnull( I.Level3_Index, 0 ) as Level3_Index, 
			PubDate=isnull(I.PubDate,''), SortDate=isnull( I.SortDate,-1), MainThumbnail=G.File_Location + '/' + VID + '/' + isnull( I.MainThumbnail,''), 
			I.Title, Author=isnull(I.Author,''), IP_Restriction_Mask, G.OCLC_Number, G.ALEPH_Number, MainThumbnailFile=ISNULL(I.MainThumbnail,''), MainJPEGFile=ISNULL(I.MainJPEG,'')
	from SobekCM_Item I, SobekCM_Item_Group G
	where ( I.GroupID = G.GroupID )
	  and ( G.BibID = @bibid )
	  and ( I.VID = @vid );  
	  
	-- Check to see if aggregation information should be returned
	if( @include_aggregations = 'true' )
	begin
  		-- Return the aggregation information linked to this item
		select A.Code, A.Name, A.ShortName, A.[Type], A.Map_Search, A.DisplayOptions, A.Items_Can_Be_Described, L.impliedLink, A.Hidden, A.isActive, ISNULL(A.External_Link,'') as External_Link
		from SobekCM_Item_Aggregation_Item_Link L, SobekCM_Item_Aggregation A, SobekCM_Item I, SobekCM_Item_Group G
		where ( L.ItemID = I.ItemID )
		  and ( A.AggregationID = L.AggregationID )
		  and ( I.GroupID = G.GroupID )
	      and ( G.BibID = @bibid )
	      and ( I.VID = @vid );
	end;
end;
GO


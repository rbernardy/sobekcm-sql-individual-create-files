USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Item_List_Brief2]    Script Date: 2/19/2022 8:51:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Returns the list of all items within the library with some very basic information.
-- This is primarily utilized by the builder to step through all items in the library
-- and build the marc files, or links for the sitemap
CREATE PROCEDURE [dbo].[SobekCM_Item_List_Brief2]
	@include_private bit
as
begin

	-- No need to perform any locks here
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	if ( @include_private = 'true' )
	begin
		-- Return the item group / item information in one large table
		select G.BibID, I.VID, G.GroupTitle, 
			isnull(I.Level1_Text, '') as Level1_Text, isnull( I.Level1_Index, 0 ) as Level1_Index, 
			isnull(I.Level2_Text, '') as Level2_Text, isnull( I.Level2_Index, 0 ) as Level2_Index, 
			isnull(I.Level3_Text, '') as Level3_Text, isnull( I.Level3_Index, 0 ) as Level3_Index, 
			PubDate=isnull(I.PubDate,''), SortDate=isnull( I.SortDate,-1), MainThumbnail=G.File_Location + '/' + VID + '/' + isnull( I.MainThumbnail,''), 
			I.Title, Author=isnull(I.Author,''), IP_Restriction_Mask, G.OCLC_Number, G.ALEPH_Number, I.LastSaved, I.AggregationCodes, G.Large_Format
		from SobekCM_Item I, SobekCM_Item_Group G
		where ( I.GroupID = G.GroupID )
		  and ( G.Deleted = CONVERT(bit,0) )
		  and ( I.Deleted = CONVERT(bit,0) );

		-- Get the items that are really multiple (having more than one volume)
		select G.BibID, G.GroupID, VID_COUNT = ItemCount, G.GroupTitle, G.[Type], G.File_Location, SortTitle=isnull(G.SortTitle, G.GroupTitle), G.OCLC_Number, G.ALEPH_Number
		from SobekCM_Item_Group G;
	end
	else
	begin
			-- Return the item group / item information in one large table
		select G.BibID, I.VID, G.GroupTitle, 
			isnull(I.Level1_Text, '') as Level1_Text, isnull( I.Level1_Index, 0 ) as Level1_Index, 
			isnull(I.Level2_Text, '') as Level2_Text, isnull( I.Level2_Index, 0 ) as Level2_Index, 
			isnull(I.Level3_Text, '') as Level3_Text, isnull( I.Level3_Index, 0 ) as Level3_Index, 
			PubDate=isnull(I.PubDate,''), SortDate=isnull( I.SortDate,-1), MainThumbnail=G.File_Location + '/' + VID + '/' + isnull( I.MainThumbnail,''), 
			I.Title, Author=isnull(I.Author,''), IP_Restriction_Mask, G.OCLC_Number, G.ALEPH_Number, I.LastSaved, I.AggregationCodes, G.Large_Format
		from SobekCM_Item I, SobekCM_Item_Group G
		where ( I.GroupID = G.GroupID )
		  and ( G.Deleted = CONVERT(bit,0) )
		  and ( I.Deleted = CONVERT(bit,0) )
		  and ( I.IP_Restriction_Mask >= 0 );
		  
		-- Get the list of groups which have at least one item non-private
		select distinct(GroupID) as GroupID
		into #TEMP1
		from SobekCM_Item I
		where ( I.Deleted = CONVERT(bit,0) )
		  and ( I.IP_Restriction_Mask >= 0 ); 
		  
		-- Get the items that are really multiple (having more than one volume)
		select G.BibID, G.GroupID, VID_COUNT = ItemCount, G.GroupTitle, G.[Type], G.File_Location, SortTitle=isnull(G.SortTitle, G.GroupTitle), G.OCLC_Number, G.ALEPH_Number
		from SobekCM_Item_Group G, #TEMP1 T
		where T.GroupID = G.GroupID and G.Deleted = CONVERT(bit,0);
		
		-- Drop the temporary table
		drop table #TEMP1;
		
		-- Get list of items / groups which are private
		select G.BibID, I.VID
		from SobekCM_Item I, SobekCM_Item_Group G
		where ( I.GroupID = G.GroupID )
		  and ( G.Deleted = CONVERT(bit,0) )
		  and ( I.Deleted = CONVERT(bit,0) )
		  and ( I.IP_Restriction_Mask < 0 );
	end;	
end;
GO


USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Get_MultiVolume_Title_Info]    Script Date: 2/16/2022 10:43:25 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Gets the information about all the multi-volume titles
CREATE PROCEDURE [dbo].[SobekCM_Get_MultiVolume_Title_Info] 
AS
begin

	-- No need to perform any locks here.  A slightly dirty read won't hurt much
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	-- Return the multiple volumes
	with volume_count as 
	(
		select BibID, count(*) as ItemCount
		from SobekCM_Item_Group G, SobekCM_Item I
		where G.GroupID = I.GroupID 
		  and G.Deleted='false'
		  and I.Deleted='false'
		group by BibID
	)
	select G.BibID, CustomThumbnail, FlagByte, LastFourInt, coalesce(GroupTitle,'') as GroupTitle
	from SobekCM_Item_Group G, volume_count C
	where ( C.BibID=G.BibID )
	  and (( C.ItemCount > 1 ) or ( G.HasGroupMetadata = 'true' ));

end;
GO


USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Get_Group_Titles_All]    Script Date: 2/12/2022 6:26:54 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SobekCM_Get_Group_Titles_All]
AS
BEGIN

	select G.BibID, coalesce(G.GroupTitle, '') as GroupTitle, coalesce(G.GroupThumbnail,'') as GroupThumbnail
	from SobekCM_Item_Group G
	where G.Deleted='false';

END;
GO


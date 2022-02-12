USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Get_Group_Titles]    Script Date: 2/12/2022 6:17:45 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[SobekCM_Get_Group_Titles]
	@BibID1 varchar(10),
	@BibID2 varchar(10),
	@BibID3 varchar(10),
	@BibID4 varchar(10),
	@BibID5 varchar(10),
	@BibID6 varchar(10),
	@BibID7 varchar(10),
	@BibID8 varchar(10),
	@BibID9 varchar(10),
	@BibID10 varchar(10),
	@BibID11 varchar(10),
	@BibID12 varchar(10),
	@BibID13 varchar(10),
	@BibID14 varchar(10),
	@BibID15 varchar(10),
	@BibID16 varchar(10),
	@BibID17 varchar(10),
	@BibID18 varchar(10),
	@BibID19 varchar(10),
	@BibID20 varchar(10)
AS
BEGIN

	select G.BibID, coalesce(G.GroupTitle, '') as GroupTitle, coalesce(G.GroupThumbnail,'') as GroupThumbnail
	from SobekCM_Item_Group G
	where ( G.Deleted='false' )
	  and (    ( G.BibID = @BibID1 )
	        or ( G.BibID = @BibID2 )
			or ( G.BibID = @BibID3 )
			or ( G.BibID = @BibID4 )
			or ( G.BibID = @BibID5 )
			or ( G.BibID = @BibID6 )
			or ( G.BibID = @BibID7 )
			or ( G.BibID = @BibID8 )
			or ( G.BibID = @BibID9 )
			or ( G.BibID = @BibID10 )
			or ( G.BibID = @BibID11 )
			or ( G.BibID = @BibID12 )
			or ( G.BibID = @BibID13 )
			or ( G.BibID = @BibID14 )
			or ( G.BibID = @BibID15 )
			or ( G.BibID = @BibID16 )
			or ( G.BibID = @BibID17 )
			or ( G.BibID = @BibID18 )
			or ( G.BibID = @BibID19 )
			or ( G.BibID = @BibID20 ));

END;
GO


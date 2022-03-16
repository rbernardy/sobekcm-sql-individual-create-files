USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Set_Main_Thumbnail]    Script Date: 3/15/2022 8:34:56 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Set the main thumbnail for an individual item 
CREATE PROCEDURE [dbo].[SobekCM_Set_Main_Thumbnail]
	@bibid varchar(10),
	@vid varchar(5),
	@mainthumb varchar(100)
AS
BEGIN

	-- Get the item id
	declare @itemid int;
	set @itemid = ISNULL(( select ItemID from SobekCM_Item I, SobekCM_Item_Group G where I.GroupID = G.GroupID and G.BibID=@bibid and I.VID=@vid ), -1 );
	
	-- Set the main thumb
	if ( @itemid > 0 )
	begin
		update SobekCM_Item set MainThumbnail=@mainthumb where ItemID=@itemid;
	end;
END;
GO


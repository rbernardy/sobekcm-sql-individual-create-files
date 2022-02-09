USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Delete_Thematic_Heading]    Script Date: 2/8/2022 10:14:23 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Delete a single thematic heading, and unlink any aggregations currently
-- appearing under this thematic heading on the main library home page
CREATE PROCEDURE [dbo].[SobekCM_Delete_Thematic_Heading]
	@ThematicHeadingID int
AS
BEGIN

	-- Remove anything linked to this one
	update SobekCM_Item_Aggregation
	set ThematicHeadingID = -1 where ThematicHeadingID=@ThematicHeadingID;
	
	--Remove this from the list of thematic headings
	delete from SobekCM_Thematic_Heading
	where ThematicHeadingID=@ThematicHeadingID;
END;
GO


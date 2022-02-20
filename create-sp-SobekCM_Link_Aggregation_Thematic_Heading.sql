USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Link_Aggregation_Thematic_Heading]    Script Date: 2/20/2022 6:31:49 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Link an existing item aggregation to an existing thematic heading, so the
-- item aggregation will appear on the home page under this thematic heading
CREATE PROCEDURE [dbo].[SobekCM_Link_Aggregation_Thematic_Heading]
	@ThematicHeadingID int,
	@Code nvarchar(20)
AS
BEGIN
	-- Update existing row
	update SobekCM_Item_Aggregation
	set ThematicHeadingID=@ThematicHeadingID
	where Code=@Code;
END;
GO


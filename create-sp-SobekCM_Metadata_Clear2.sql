USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Metadata_Clear2]    Script Date: 2/21/2022 8:40:17 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Clears all the metadata for a single resource, while possibly leaving some 
-- values which are non-mets values, such as tracking boxes, user descriptions, etc..
CREATE PROCEDURE [dbo].[SobekCM_Metadata_Clear2]
	@itemid int,
	@clear_non_mets_values bit
AS
BEGIN
	-- Should ALL be cleared, or just non-mets stuff?
	if ( @clear_non_mets_values = 'true' )
	begin
		-- Just delete EVERY link between the metadata and this item
		delete from SobekCM_Metadata_Unique_Link 
		where ItemID = @itemid;
	end
	else
	begin
		-- Delete only specific types of metadata, not tickler or user descriptions
		delete from SobekCM_Metadata_Unique_Link 
		where ( ItemID = @itemid )
		  and not exists ( select * from SobekCM_Metadata_Unique_Search_Table S where S.MetadataID = SobekCM_Metadata_Unique_Link.MetadataID and ( MetadataTypeID = 20 or MetadataTypeID = 32 ));
	end;
END;
GO


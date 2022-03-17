USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Update_Item_Group]    Script Date: 3/16/2022 8:04:52 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Procedure to change some basic information about an item group
CREATE PROCEDURE [dbo].[SobekCM_Update_Item_Group]
	@BibID varchar(10),
	@GroupTitle nvarchar(500),
	@SortTitle varchar(500),
	@GroupThumbnail varchar(500),
	@PrimaryIdentifierType nvarchar(50),
	@PrimaryIdentifier nvarchar(100)	
AS
begin

	update SobekCM_Item_Group
	set GroupTitle = @GroupTitle, SortTitle = @SortTitle, GroupThumbnail=@GroupThumbnail,
	    Primary_Identifier_Type=@PrimaryIdentifierType, Primary_Identifier=@PrimaryIdentifier
	where BibID = @BibID;

end;
GO


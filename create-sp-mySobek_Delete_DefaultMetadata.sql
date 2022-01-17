USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[mySobek_Delete_DefaultMetadata]    Script Date: 1/17/2022 6:13:01 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Procedure to delete a default metadata set
-- were linked to this web skin
CREATE PROCEDURE [dbo].[mySobek_Delete_DefaultMetadata]
	@MetadataCode varchar(20)
AS
BEGIN

	if ( @MetadataCode != 'NONE' )
	begin
		delete from mySobek_DefaultMetadata where MetadataCode=@MetadataCode;
	end;

END;
GO


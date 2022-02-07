USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Delete_Icon]    Script Date: 2/6/2022 8:50:36 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Delete an existing Wordmark, and output the number of links to that wordmark
-- If there are any items linked to that wordmark, the icon is not deleted
CREATE PROCEDURE [dbo].[SobekCM_Delete_Icon]
	@icon_code varchar(255),
	@links int output
AS
begin

	-- Get the number of links
	select @links = count(*) from SobekCM_Item_Icons L, SobekCM_Icon I where I.Icon_Name = @icon_code and I.IconID = L.IconID;

	-- If there are no links, delete this icon
	if ( @links = 0 )
	begin
		delete from SobekCM_Icon where Icon_Name = @icon_code;
	end;
end;
GO


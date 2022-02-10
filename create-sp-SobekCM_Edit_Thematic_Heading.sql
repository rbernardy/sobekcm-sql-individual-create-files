USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Edit_Thematic_Heading]    Script Date: 2/9/2022 8:36:55 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Edits the order and name for an existing themathic heading, or adds a new heading
-- if the provided thematic heading id is not valid
CREATE PROCEDURE [dbo].[SobekCM_Edit_Thematic_Heading]
	@ThematicHeadingID int,
	@ThemeOrder int,
	@ThemeName nvarchar(100),
	@NewID int output
AS
BEGIN

	-- Is this a new theme?  Does the thematic heading id exist?
	if ( @ThematicHeadingID in ( select ThematicHeadingID from SobekCM_Thematic_Heading ))
	begin	
		-- Yes, exists.. so update existing thematic heading
		update SobekCM_Thematic_Heading
		set ThemeOrder = @ThemeOrder, ThemeName = @ThemeName
		where ThematicHeadingID = @ThematicHeadingID
		
		-- Just return the same id
		set @NewID = @ThematicHeadingID;
	end
	else
	begin
		-- No, it doesn't exist, so insert a new thematic heading
		insert into SobekCM_Thematic_Heading ( ThemeOrder, ThemeName )
		values ( @ThemeOrder, @ThemeName );
		
		-- Save the new id
		set @NewID = @@Identity;
	end;
END;
GO


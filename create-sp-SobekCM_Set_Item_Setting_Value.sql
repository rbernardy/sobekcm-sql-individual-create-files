USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Set_Item_Setting_Value]    Script Date: 3/15/2022 8:04:07 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Sets a single item setting value, by key.  Adds a new one if this
-- is a new setting key, otherwise updates the existing value.
CREATE PROCEDURE [dbo].[SobekCM_Set_Item_Setting_Value]
	@ItemID int,
	@Setting_Key varchar(255),
	@Setting_Value varchar(max)
AS
BEGIN

	-- Does this setting exist?
	if ( ( select COUNT(*) from SobekCM_Item_Settings where Setting_Key=@Setting_Key and ItemID=@ItemID ) > 0 )
	begin
		-- Just update existing then
		update SobekCM_Item_Settings set Setting_Value=@Setting_Value where Setting_Key = @Setting_Key and ItemID=@ItemID;
	end
	else
	begin
		-- insert a new settting key/value pair
		insert into SobekCM_Item_Settings( ItemID, Setting_Key, Setting_Value )
		values ( @ItemID, @Setting_Key, @Setting_Value );
	end;	
END;
GO


USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Set_User_Setting_Value]    Script Date: 3/15/2022 8:46:12 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Sets a single user setting value, by key.  Adds a new one if this
-- is a new setting key, otherwise updates the existing value.
CREATE PROCEDURE [dbo].[SobekCM_Set_User_Setting_Value]
	@UserID int,
	@Setting_Key varchar(255),
	@Setting_Value varchar(max)
AS
BEGIN

	-- Does this setting exist?
	if ( ( select COUNT(*) from mySobek_User_Settings where Setting_Key=@Setting_Key and UserID=@UserID ) > 0 )
	begin
		-- Just update existing then
		update mySobek_User_Settings set Setting_Value=@Setting_Value where Setting_Key = @Setting_Key and UserID=@UserID;
	end
	else
	begin
		-- insert a new settting key/value pair
		insert into mySobek_User_Settings( UserID, Setting_Key, Setting_Value )
		values ( @UserID, @Setting_Key, @Setting_Value );
	end;	
END;
GO


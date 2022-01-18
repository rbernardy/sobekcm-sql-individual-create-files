USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[mySobek_Get_All_User_Settings_Like]    Script Date: 1/17/2022 8:07:53 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



-- Procedure gets settings across all the users that are like the key start
--
-- Since this uses like, you can pass in a string like 'TEI.%' and that will return
-- all the values that have a setting key that STARTS with 'TEI.'
--
-- If @value is NULL, then all settings that match are returned.  If a value is
-- provided for @value, then only the settings that match the key search and 
-- have the same value in the database as @value are returned.  This is particularly
-- useful for boolean settings, where you only want to the see the settings set to 'true'
CREATE PROCEDURE [dbo].[mySobek_Get_All_User_Settings_Like]
	@keyStart nvarchar(255),
	@value nvarchar(max)
AS
begin

	-- User can request settings that are only one value (useful for boolean settings really)
	if ( @value is null )
	begin
	
		-- Just return all that are like the setting key
		select U.UserName, U.UserID, coalesce(U.FirstName,'') as FirstName, coalesce(U.LastName,'') as LastName, S.Setting_Key, S.Setting_Value
		from mySobek_User U, mySobek_User_Settings S
		where ( U.UserID = S.UserID )
		  and ( Setting_Key like @keyStart )
		  and ( U.isActive = 'true' );

	end
	else
	begin
		
		-- Return information on settings like the setting key and set to @value then
		select U.UserName, U.UserID, coalesce(U.FirstName,'') as FirstName, coalesce(U.LastName,'') as LastName, S.Setting_Key, S.Setting_Value
		from mySobek_User U, mySobek_User_Settings S
		where ( U.UserID = S.UserID )
		  and ( Setting_Key like @keyStart )
		  and ( U.isActive = 'true' )
		  and ( Setting_Value = @value );
	end;

end;
GO


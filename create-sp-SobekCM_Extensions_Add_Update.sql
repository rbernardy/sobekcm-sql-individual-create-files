USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Extensions_Add_Update]    Script Date: 2/9/2022 8:54:31 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Add information about a new extension, or update an existing extension
CREATE PROCEDURE [dbo].[SobekCM_Extensions_Add_Update]
	@Code nvarchar(50),
	@Name nvarchar(255),
	@CurrentVersion varchar(50),
	@LicenseKey nvarchar(max),
	@UpgradeUrl nvarchar(255),
	@LatestVersion nvarchar(50)
AS
BEGIN
	-- Does this already exist?
	if ( exists ( select 1 from SobekCM_Extension where Code=@Code ))
	begin
		update SobekCM_Extension
		set Name=@Name,
			CurrentVersion=@CurrentVersion,
			LicenseKey=@LicenseKey,
			UpgradeUrl=@UpgradeUrl,
			LatestVersion=@LatestVersion
		where Code=@Code;    
	end
	else
	begin
		insert into SobekCM_Extension (Code, Name, CurrentVersion, IsEnabled, LicenseKey, UpgradeUrl, LatestVersion )
		values ( @Code, @Name, @CurrentVersion, 'false', @LicenseKey, @UpgradeUrl, @LatestVersion );
	end;
	
END;
GO


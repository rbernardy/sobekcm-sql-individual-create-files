USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Extensions_Get_All]    Script Date: 2/9/2022 9:01:28 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Get the list of extensions in the system
CREATE PROCEDURE [dbo].[SobekCM_Extensions_Get_All]
AS
BEGIN
	-- Return all the information about the extensions from the database
	select ExtensionID, Code, Name, CurrentVersion, IsEnabled, EnabledDate, LicenseKey, UpgradeUrl, LatestVersion 
	from SobekCM_Extension
	order by Code;
END;
GO


USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Delete_Setting]    Script Date: 2/8/2022 9:59:57 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Delete a system-wide setting
CREATE PROCEDURE [dbo].[SobekCM_Delete_Setting]
	@Setting_Key varchar(255)
AS
BEGIN
	delete from SobekCM_Settings where Setting_Key = @Setting_Key;
END;
GO


USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Extensions_Remove]    Script Date: 2/9/2022 9:06:47 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Remove an extension completely from the database
CREATE PROCEDURE [dbo].[SobekCM_Extensions_Remove]
	@Code nvarchar(50)
AS
BEGIN
	delete from SobekCM_Extension
	where Code=@Code;
END;
GO


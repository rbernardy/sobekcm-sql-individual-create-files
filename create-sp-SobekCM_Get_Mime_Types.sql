USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Get_Mime_Types]    Script Date: 2/16/2022 10:34:59 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SobekCM_Get_Mime_Types]
AS
BEGIN
	select Extension, MimeType, isBlocked, shouldForward, MimeTypeID
	from SobekCM_Mime_Types;
END;
GO


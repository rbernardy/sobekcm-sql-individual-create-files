USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Builder_Incoming_Folder_Delete]    Script Date: 1/23/2022 3:57:00 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Deletes an incoming folder from the builder settings 
CREATE PROCEDURE [dbo].[SobekCM_Builder_Incoming_Folder_Delete]
	@IncomingFolderId int
AS 
BEGIN
	delete from SobekCM_Builder_Incoming_Folders 
	where IncomingFolderId=@IncomingFolderId;
END;
GO


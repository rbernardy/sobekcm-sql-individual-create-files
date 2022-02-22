USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_QC_Delete_Error]    Script Date: 2/21/2022 10:16:11 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SobekCM_QC_Delete_Error]
	-- Add the parameters for the stored procedure here
	@itemID int,
	@filename nvarchar(MAX)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DELETE FROM SobekCM_QC_Errors WHERE ItemID=@itemID AND [FileName]=@filename;
    	
END
GO


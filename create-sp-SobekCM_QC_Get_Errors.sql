USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_QC_Get_Errors]    Script Date: 2/21/2022 10:27:12 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SobekCM_QC_Get_Errors]
	-- Add the parameters for the stored procedure here
	@itemID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT * FROM SobekCM_QC_Errors WHERE ItemID=@itemID; 
     	
END
GO


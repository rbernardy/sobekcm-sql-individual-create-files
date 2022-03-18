USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[Tracking_Get_Users_Scanning_Processing]    Script Date: 3/17/2022 11:01:45 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Tracking_Get_Users_Scanning_Processing]	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT UserName,EmailAddress,FirstName,LastName,ScanningTechnician, ProcessingTechnician 
	FROM mySobek_User
	WHERE ScanningTechnician=1 OR ProcessingTechnician=1
END
GO


USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[Tracking_Get_Scanners_List]    Script Date: 3/17/2022 10:53:45 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Tracking_Get_Scanners_List]	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT ScanningEquipment, Notes, Location,EquipmentType 
	FROM Tracking_ScanningEquipment
	WHERE isActive=1
END
GO


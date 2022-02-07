USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Delete_IP_Range]    Script Date: 2/6/2022 9:00:25 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SobekCM_Delete_IP_Range]
	@rangeid int
AS
BEGIN
	UPDATE SobekCM_IP_Restriction_Range set Deleted='TRUE' where IP_RangeID=@rangeid;
END;
GO


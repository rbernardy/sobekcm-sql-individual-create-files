USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Delete_Single_IP]    Script Date: 2/8/2022 10:08:14 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Delate a single IP, from a larger IP restriction range
CREATE PROCEDURE [dbo].[SobekCM_Delete_Single_IP]
	@ip_singleid int
AS
BEGIN
	
	delete from SobekCM_IP_Restriction_Single where IP_SingleID=@ip_singleid;

END;
GO


USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Get_IP_Restriction_Range]    Script Date: 2/12/2022 6:34:54 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Return details on an IP restriction range, including all of the individual IPs included
CREATE PROCEDURE [dbo].[SobekCM_Get_IP_Restriction_Range]
	@ip_rangeid int
AS
BEGIN
	
	-- No need to perform any locks here
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
	
	-- Get all information (includes notes this time)
	select *
	from SobekCM_IP_Restriction_Range
	where IP_RangeID = @ip_rangeid;

	-- Get all associated single ip ranges
	select IP_SingleID, StartIP, ISNULL(EndIP,'') as EndIP, ISNULL(Notes,'') as Notes
	from SobekCM_IP_Restriction_Single
	where IP_RangeID = @ip_rangeid
	order by StartIP ASC;

END;
GO


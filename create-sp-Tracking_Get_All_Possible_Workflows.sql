USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[Tracking_Get_All_Possible_Workflows]    Script Date: 3/17/2022 9:55:58 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Tracking_Get_All_Possible_Workflows]
AS
begin

	select * from Tracking_WorkFlow

end
GO


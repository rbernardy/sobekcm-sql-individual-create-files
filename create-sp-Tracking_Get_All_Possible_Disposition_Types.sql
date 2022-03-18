USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[Tracking_Get_All_Possible_Disposition_Types]    Script Date: 3/17/2022 9:48:51 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Tracking_Get_All_Possible_Disposition_Types]
AS
begin

	select * from Tracking_Disposition_Type

end
GO


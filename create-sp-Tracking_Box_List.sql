USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[Tracking_Box_List]    Script Date: 3/17/2022 9:10:53 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Tracking_Box_List]
AS
begin
	select distinct(Tracking_Box) 
	from SobekCM_Item
	order by Tracking_Box
end
GO


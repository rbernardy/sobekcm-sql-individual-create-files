USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[Tracking_Items_Pending_Online_Complete]    Script Date: 3/17/2022 11:22:49 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Tracking_Items_Pending_Online_Complete]
AS
begin

	select  G.BibID, I.VID, I.Milestone_QualityControl, I.Dark, I.IP_Restriction_Mask, I.[PageCount], I.Title, G.[Type], I.AggregationCodes
	from SobekCM_Item as I inner join
		 SobekCM_Item_Group as G on I.GroupID=G.GroupID 
	where Milestone_QualityControl is not null
	 and Milestone_OnlineComplete is null
	 and Dark = 'false'
	and Milestone_QualityControl > '1-1-2011'
	order by Milestone_QualityControl DESC
end
GO


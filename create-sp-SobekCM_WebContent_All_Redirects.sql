USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_WebContent_All_Redirects]    Script Date: 3/16/2022 8:44:41 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Return all the web content pages that are set as redirects
CREATE PROCEDURE [dbo].[SobekCM_WebContent_All_Redirects]
AS
BEGIN

	-- Get the pages, with the time last updated
	with webcontent_last_update as
	(
		select WebContentID, Max(WebContentMilestoneID) as MaxMilestoneID
		from SobekCM_WebContent_Milestones
		group by WebContentID
	)
	select W.WebContentID, W.Level1, W.Level2, W.Level3, W.Level4, W.Level5, W.Level6, W.Level7, W.Level8, W.Title, W.Summary, W.Deleted, W.Redirect, M.MilestoneDate, M.MilestoneUser
	from SobekCM_WebContent W left outer join
		 webcontent_last_update L on L.WebContentID=W.WebContentID left outer join
	     SobekCM_WebContent_Milestones M on M.WebContentMilestoneID=L.MaxMilestoneID
	where ( len(coalesce(W.Redirect,'')) > 0 ) and ( Deleted = 'false' )
	order by W.Level1, W.Level2, W.Level3, W.Level4, W.Level5, W.Level6, W.Level7, W.Level8;

	-- Get the distinct top level pages
	select distinct(W.Level1)
	from SobekCM_WebContent W
	where ( len(coalesce(W.Redirect,'')) > 0 ) and ( Deleted = 'false' )
	order by W.Level1;

	-- Get the distinct top TWO level pages
	select W.Level1, W.Level2
	from SobekCM_WebContent W
	where ( len(coalesce(W.Redirect,'')) > 0 )
	  and ( W.Level2 is not null )
	  and ( Deleted = 'false' )
	group by W.Level1, W.Level2
	order by W.Level1, W.Level2;

END;
GO


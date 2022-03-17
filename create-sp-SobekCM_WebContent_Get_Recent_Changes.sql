USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_WebContent_Get_Recent_Changes]    Script Date: 3/16/2022 9:03:30 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Get the list of recent changes to all web content pages
CREATE PROCEDURE [dbo].[SobekCM_WebContent_Get_Recent_Changes]
AS
BEGIN

	-- Get all milestones
	select W.WebContentID, W.Level1, W.Level2, W.Level3, W.Level4, W.Level5, W.Level6, W.Level7, W.Level8, MilestoneDate, MilestoneUser, Milestone, W.Title
	from SobekCM_WebContent_Milestones M, SobekCM_WebContent W
	where M.WebContentID=W.WebContentID
	order by MilestoneDate DESC;

	-- Get the distinct list of users that made changes
	select MilestoneUser
	from SobekCM_WebContent_Milestones
	group by MilestoneUser
	order by MilestoneUser;

	-- Return the distinct first level
	select Level1 
	from SobekCM_WebContent_Milestones M, SobekCM_WebContent W
	where M.WebContentID=W.WebContentID
	group by Level1
	order by Level1;
	
	-- Return the distinct first TWO level					
	select Level1, Level2
	from SobekCM_WebContent_Milestones M, SobekCM_WebContent W
	where M.WebContentID=W.WebContentID
	group by Level1, Level2
	order by Level1, Level2;


END;
GO


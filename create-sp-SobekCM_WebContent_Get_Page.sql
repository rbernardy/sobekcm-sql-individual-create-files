USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_WebContent_Get_Page]    Script Date: 3/16/2022 8:57:02 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Get basic details about an existing web content page
CREATE PROCEDURE [dbo].[SobekCM_WebContent_Get_Page]
	@Level1 varchar(100),
	@Level2 varchar(100),
	@Level3 varchar(100),
	@Level4 varchar(100),
	@Level5 varchar(100),
	@Level6 varchar(100),
	@Level7 varchar(100),
	@Level8 varchar(100)
AS
BEGIN	
	-- Return the couple of requested pieces of information
	select top 1 W.WebContentID, W.Title, W.Summary, W.Deleted, M.MilestoneDate, M.MilestoneUser, W.Redirect, W.Level1, W.Level2, W.Level3, W.Level4, W.Level5, W.Level6, W.Level7, W.Level8, W.Locked
	from SobekCM_WebContent W left outer join
	     SobekCM_WebContent_Milestones M on W.WebContentID=M.WebContentID
	where ( Level1=@Level1 )
	  and ((Level2 is null and @Level2 is null ) or ( Level2=@Level2)) 
	  and ((Level3 is null and @Level3 is null ) or ( Level3=@Level3))
	  and ((Level4 is null and @Level4 is null ) or ( Level4=@Level4))
	  and ((Level5 is null and @Level5 is null ) or ( Level5=@Level5))
	  and ((Level6 is null and @Level6 is null ) or ( Level6=@Level6))
	  and ((Level7 is null and @Level7 is null ) or ( Level7=@Level7))
	  and ((Level8 is null and @Level8 is null ) or ( Level8=@Level8))
	order by M.MilestoneDate DESC;
END;
GO


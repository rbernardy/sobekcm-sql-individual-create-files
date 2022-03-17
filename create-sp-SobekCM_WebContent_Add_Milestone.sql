USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_WebContent_Add_Milestone]    Script Date: 3/16/2022 8:32:23 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



-- Add a new milestone to an existing web content page
CREATE PROCEDURE [dbo].[SobekCM_WebContent_Add_Milestone]
	@WebContentID int,
	@Milestone nvarchar(max),
	@MilestoneUser nvarchar(100)
AS
BEGIN

	-- Insert milestone
	insert into SobekCM_WebContent_Milestones ( WebContentID, Milestone, MilestoneUser, MilestoneDate )
	values ( @WebContentID, @Milestone, @MilestoneUser, getdate());

END;
GO


USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_WebContent_Edit]    Script Date: 3/16/2022 8:50:39 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




-- Edit basic information on an existing web content page
CREATE PROCEDURE [dbo].[SobekCM_WebContent_Edit]
	@WebContentID int,
	@UserName nvarchar(100),
	@Title nvarchar(255),
	@Summary nvarchar(1000),
	@Redirect varchar(500),
	@MilestoneText varchar(max)
AS
BEGIN	
	-- Make the change
	update SobekCM_WebContent
	set Title=@Title, Summary=@Summary, Redirect=@Redirect
	where WebContentID=@WebContentID;

	-- Now, add a milestone
	if ( len(coalesce(@MilestoneText,'')) > 0 )
	begin
		insert into SobekCM_WebContent_Milestones (WebContentID, Milestone, MilestoneDate, MilestoneUser )
		values ( @WebContentID, @MilestoneText, getdate(), @UserName );
	end
	else
	begin
		insert into SobekCM_WebContent_Milestones (WebContentID, Milestone, MilestoneDate, MilestoneUser )
		values ( @WebContentID, 'Edited', getdate(), @UserName );
	end;

END;
GO


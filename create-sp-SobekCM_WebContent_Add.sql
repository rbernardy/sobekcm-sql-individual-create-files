USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_WebContent_Add]    Script Date: 3/16/2022 8:28:53 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Add a new web content page
CREATE PROCEDURE [dbo].[SobekCM_WebContent_Add]
	@Level1 varchar(100),
	@Level2 varchar(100),
	@Level3 varchar(100),
	@Level4 varchar(100),
	@Level5 varchar(100),
	@Level6 varchar(100),
	@Level7 varchar(100),
	@Level8 varchar(100),
	@UserName nvarchar(100),
	@Title nvarchar(255),
	@Summary nvarchar(1000),
	@Redirect nvarchar(500),
	@WebContentID int output
AS
BEGIN	
	-- Is there a match already for this?
	if ( EXISTS ( select 1 from SobekCM_WebContent 
	              where ( Level1=@Level1 )
	                and ((Level2 is null and @Level2 is null ) or ( Level2=@Level2)) 
					and ((Level3 is null and @Level3 is null ) or ( Level3=@Level3))
					and ((Level4 is null and @Level4 is null ) or ( Level4=@Level4))
					and ((Level5 is null and @Level5 is null ) or ( Level5=@Level5))
					and ((Level6 is null and @Level6 is null ) or ( Level6=@Level6))
					and ((Level7 is null and @Level7 is null ) or ( Level7=@Level7))
					and ((Level8 is null and @Level8 is null ) or ( Level8=@Level8))))
	begin
		-- Get the web content id
		set @WebContentID = (   select top 1 WebContentID 
								from SobekCM_WebContent 
								where ( Level1=@Level1 )
								  and ((Level2 is null and @Level2 is null ) or ( Level2=@Level2)) 
								  and ((Level3 is null and @Level3 is null ) or ( Level3=@Level3))
								  and ((Level4 is null and @Level4 is null ) or ( Level4=@Level4))
								  and ((Level5 is null and @Level5 is null ) or ( Level5=@Level5))
								  and ((Level6 is null and @Level6 is null ) or ( Level6=@Level6))
								  and ((Level7 is null and @Level7 is null ) or ( Level7=@Level7))
								  and ((Level8 is null and @Level8 is null ) or ( Level8=@Level8)));

		-- Ensure the title and summary are correct
		update SobekCM_WebContent set Title=@Title, Summary=@Summary, Redirect=@Redirect where WebContentID=@WebContentID;
		
		-- Was this previously deleted?
		if ( EXISTS ( select 1 from SobekCM_WebContent where Deleted='true' and WebContentID=@WebContentID ))
		begin
			-- Undelete this 
			update SobekCM_WebContent
			set Deleted='false'
			where WebContentID = @WebContentID;

			-- Mark this in the milestones then
			insert into SobekCM_WebContent_Milestones ( WebContentID, Milestone, MilestoneDate, MilestoneUser )
			values ( @WebContentID, 'Restored previously deleted page', getdate(), @UserName );
		end;
	end
	else
	begin
		-- Add the new web content then
		insert into SobekCM_WebContent ( Level1, Level2, Level3, Level4, Level5, Level6, Level7, Level8, Title, Summary, Deleted, Redirect )
		values ( @Level1, @Level2, @Level3, @Level4, @Level5, @Level6, @Level7, @Level8, @Title, @Summary, 'false', @Redirect );

		-- Get the new ID for this
		set @WebContentID = SCOPE_IDENTITY();

		-- Now, add this to the milestones table
		insert into SobekCM_WebContent_Milestones ( WebContentID, Milestone, MilestoneDate, MilestoneUser )
		values ( @WebContentID, 'Add new page', getdate(), @UserName );
	end;
END;
GO


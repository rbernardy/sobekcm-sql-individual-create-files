USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Add_Item_Aggregation_Milestone]    Script Date: 1/20/2022 9:46:03 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SobekCM_Add_Item_Aggregation_Milestone]
	@AggregationCode varchar(20),
	@Milestone nvarchar(150),
	@MilestoneUser nvarchar(max)
AS
begin transaction

	-- get the aggregation id
	declare @aggregationid int;
	set @aggregationid = coalesce( (select AggregationID from SobekCM_Item_Aggregation where Code=@AggregationCode), -1);
	
	if ( @aggregationid > 0 )
	begin
		
		-- only enter one of these per day
		if ( (select count(*) from [SobekCM_Item_Aggregation_Milestones] where ( AggregationID = @aggregationid ) and ( MilestoneUser=@MilestoneUser ) and ( Milestone=@Milestone) and ( CONVERT(VARCHAR(10), MilestoneDate, 102) = CONVERT(VARCHAR(10), getdate(), 102) )) = 0 )
		--if ( (select count(*) from [SobekCM_Item_Aggregation_Milestones] where ( AggregationID = @aggregationid ) and ( MilestoneUser=@MilestoneUser ) and ( Milestone=@Milestone) and ( MilestoneDate=getdate())) = 0 )
		begin
			-- Just add this new milestone then
			insert into [SobekCM_Item_Aggregation_Milestones] ( AggregationID, Milestone, MilestoneDate, MilestoneUser )
			values ( @aggregationid, @Milestone, getdate(), @MilestoneUser );
		end;	
	end;

commit transaction;
GO


USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Aggregation_Change_Log]    Script Date: 1/23/2022 1:06:44 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SobekCM_Aggregation_Change_Log]
	@Code varchar(20)
as
begin

	-- Get the aggregation id
	declare @aggrId int;
	set @aggrId=-1;
	if ( exists ( select 1 from SobekCM_Item_Aggregation where Code=@Code ))
	begin
		set @aggrId = ( select AggregationID from SobekCM_Item_Aggregation where Code=@Code );
	end;

	-- Get the history
	select Milestone, MilestoneDate, MilestoneUser
	from SobekCM_Item_Aggregation_Milestones 
	where AggregationID = @aggrId
	order by MilestoneDate ASC, AggregationMilestoneID ASC;
end;
GO


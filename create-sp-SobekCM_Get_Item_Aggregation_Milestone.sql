USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Get_Item_Aggregation_Milestone]    Script Date: 2/12/2022 8:11:14 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SobekCM_Get_Item_Aggregation_Milestone]
	@AggregationCode varchar(20)
AS
begin transaction

	-- get the aggregation id
	declare @aggregationid int;
	set @aggregationid = coalesce( (select AggregationID from SobekCM_Item_Aggregation where Code=@AggregationCode), -1);
	
	if ( @aggregationid > 0 )
	begin
		select Milestone, MilestoneDate, MilestoneUser
		from SobekCM_Item_Aggregation_Milestones
		order by MilestoneDate ASC;	
	end;

commit transaction;
GO


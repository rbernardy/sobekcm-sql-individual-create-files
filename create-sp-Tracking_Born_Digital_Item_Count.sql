USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[Tracking_Born_Digital_Item_Count]    Script Date: 3/17/2022 9:08:11 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Procedure returns the count of items added between two arbitraty months
-- and includes born digital numbers
CREATE PROCEDURE [dbo].[Tracking_Born_Digital_Item_Count]
	@startdate date,
	@enddate date
AS
BEGIN

	-- Create the table for the statistics
	create table #TEMP_RESULTS ( RowName varchar(20), Titles_Impacted int, Items_Completed int, Pages_Completed int, Files_Completed int )

	-- First collect the raw born digital
	select I.GroupID, I.ItemID, I.[PageCount], I.FileCount
	into #TEMP_BORNDIGITAL
	from SobekCM_Item I
	where ( I.Milestone_OnlineComplete >= @startdate ) 
	  and ( I.Milestone_OnlineComplete < @enddate )
	  and ( Born_Digital = 'true' )
	  
	-- Add the born digital stats into the table
	insert into #TEMP_RESULTS
	select 'BORN_DIGITAL', COUNT(distinct(GroupID)), COUNT(*), SUM([PageCount]), SUM([FileCount])
	from #TEMP_BORNDIGITAL

	-- Drop the born digital table
	drop table #TEMP_BORNDIGITAL

	-- Next collect the total information
	select I.GroupID, I.ItemID, I.[PageCount], I.FileCount
	into #TEMP_RAWDATA
	from SobekCM_Item I
	where ( I.Milestone_OnlineComplete >= @startdate ) and ( I.Milestone_OnlineComplete < @enddate )

	-- Add the born digital stats into the table
	insert into #TEMP_RESULTS
	select 'TOTAL', COUNT(distinct(GroupID)), COUNT(*), SUM([PageCount]), SUM([FileCount])
	from #TEMP_RAWDATA

	-- Return all results
	select * from #TEMP_RESULTS

	-- Drop the temporary tables
	drop table #TEMP_RAWDATA
	drop table #TEMP_RESULTS
END
GO


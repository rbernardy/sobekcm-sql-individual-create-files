USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Page_Item_Count_History]    Script Date: 2/21/2022 9:58:22 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Return the item and page count added each month
CREATE PROCEDURE [dbo].[SobekCM_Page_Item_Count_History]
as
begin

	select ItemID, YEAR(Milestone_OnlineComplete) as [Year], MONTH(Milestone_OnlineComplete) as [Month], [PageCount]
	into #TEMP1
	from SobekCM_Item I
	where I.Deleted = 'false'

	select [Year], [MONTH], Total = SUM( [PageCount] ), ItemCount = COUNT(*)
	from #TEMP1
	group by [Year], [Month]
	order by [Year], [Month]

	drop table #TEMP1

end
GO


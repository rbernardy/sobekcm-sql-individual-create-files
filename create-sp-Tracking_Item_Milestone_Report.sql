USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[Tracking_Item_Milestone_Report]    Script Date: 3/17/2022 11:14:42 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Tracking_Item_Milestone_Report]
	@aggregation_code varchar(20)
AS
BEGIN

	if ( LEN( ISNULL( @aggregation_code,'')) = 0 )
	begin
      select CASE Last_MileStone
                        WHEN 0 THEN 'NO WORK COMPLETED'
                        WHEN 1 THEN 'SCANNED'
                        WHEN 2 THEN 'PROCESSED'
                        WHEN 3 THEN 'QC PERFORMED'
                        WHEN 4 THEN 'ONLINE COMPLETE'
                        ELSE 'DATABASE ERROR'
                  END AS MileStone, title_count=count(distinct(GroupID)), item_count=count(*), page_count = SUM([PageCount]), file_count=SUM(FileCount), Last_MileStone
      from SobekCM_Item
      group by Last_MileStone
      union
      select 'TOTAL', title_count=count(distinct(GroupID)), item_count=count(*), page_count = SUM([PageCount]), file_count=SUM(FileCount), -1
      from SobekCM_Item
      order by Last_MileStone DESC
    end
    else
    begin
    
		declare @aggregationid int
		set @aggregationid = (select top 1 AggregationID from SobekCM_Item_Aggregation where Code=@aggregation_code)
		
		if ( ISNULL(@aggregationid,-1) > 0 )
		begin
		      select CASE Last_MileStone
                        WHEN 0 THEN 'NO WORK COMPLETED'
                        WHEN 1 THEN 'SCANNED'
                        WHEN 2 THEN 'PROCESSED'
                        WHEN 3 THEN 'QC PERFORMED'
                        WHEN 4 THEN 'ONLINE COMPLETE'
                        ELSE 'DATABASE ERROR'
                  END AS MileStone, title_count=count(distinct(GroupID)), item_count=count(*), page_count = SUM([PageCount]), file_count=SUM(FileCount), Last_MileStone
			  from SobekCM_Item I, SobekCM_Item_Aggregation_Item_Link L
			  where ( I.ItemID = L.ItemID ) and ( L.AggregationID = @aggregationid )
			  group by Last_MileStone
			  union
			  select 'TOTAL', title_count=count(distinct(GroupID)), item_count=count(*), page_count = SUM([PageCount]), file_count=SUM(FileCount), -1
			  from SobekCM_Item I, SobekCM_Item_Aggregation_Item_Link L
			  where ( I.ItemID = L.ItemID ) and ( L.AggregationID = @aggregationid )
			  order by Last_MileStone DESC
		end   
    end
END
GO


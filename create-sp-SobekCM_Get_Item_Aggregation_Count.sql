USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Get_Item_Aggregation_Count]    Script Date: 2/12/2022 8:00:28 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SobekCM_Get_Item_Aggregation_Count]
	@code varchar(20)
AS
BEGIN

	-- Return some counts as well
	select count(distinct(I.GroupID)) as Title_Count, count(*) as Item_Count, coalesce(SUM([PageCount]),0) as Page_Count
	from SobekCM_Item_Aggregation_Item_Link L, SobekCM_Item I, SobekCM_Item_Aggregation A
	where ( A.Code = @code )
	  and ( A.AggregationID = L.AggregationID )
	  and ( L.ItemID = I.ItemID );

END;
GO


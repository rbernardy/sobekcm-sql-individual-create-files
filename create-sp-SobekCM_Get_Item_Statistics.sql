USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Get_Item_Statistics]    Script Date: 2/15/2022 11:17:05 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Pull any additional item details before showing this item
CREATE PROCEDURE [dbo].[SobekCM_Get_Item_Statistics]
	@BibID varchar(10),
	@VID varchar(5)
AS
BEGIN

	-- No need to perform any locks here
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
	
	-- Get the item id
	declare @itemid int;
	set @itemid = coalesce( ( select I.ItemID from SobekCM_Item I, SobekCM_Item_Group G where I.GroupID=G.GroupID and I.VID=@vid and G.BibiD=@bibid ), -1 );

	-- Get the item id
	declare @groupid int;
	set @groupid = coalesce( ( select G.GroupID from SobekCM_Item_Group G where G.BibiD=@bibid ), -1 );

	with item_month_years ([Month], [Year]) as 
	(
		select [Month], [Year] from SobekCM_Item_Group_Statistics G where G.GroupID=@groupID
		union
		select [Month], [Year] from SobekCM_Item_Statistics I where I.ItemID=@itemid
	)
	select M.[Year], M.[Month], coalesce(G.Hits,0) as Title_Views, coalesce(G.[Sessions],0) as Title_Visitors, coalesce(I.Hits,0) as [Views], coalesce(I.[Sessions],0) as Visitors
	from item_month_years M left outer join
		 SobekCM_Item_Statistics as I on I.[Month]=M.[Month] and I.[Year]=M.[Year] and I.ItemID=@itemid left outer join
		 SobekCM_Item_Group_Statistics as G on M.[Month]=G.[Month] and M.[Year]=G.[Year] and G.GroupID=@groupid
	order by [Year] ASC, [Month] ASC;			  
END;
GO


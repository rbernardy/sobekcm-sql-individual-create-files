USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[Tracking_Get_Aggregation_Privates]    Script Date: 3/17/2022 9:35:46 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Return the browse of all PRIVATE or DARK items for a single aggregation
CREATE PROCEDURE [dbo].[Tracking_Get_Aggregation_Privates]
	@code varchar(20),
	@pagesize int, 
	@pagenumber int,
	@sort int,	
	@minpagelookahead int,
	@maxpagelookahead int,
	@lookahead_factor float,
	@total_items int output,
	@total_titles int output
AS
begin

	-- No need to perform any locks here
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	-- Create the temporary tables first
	-- Create the temporary table to hold all the item id's
	declare @TEMP_ITEMS table ( ItemID int, fk_TitleID int, LastActivityDate datetime, LastActivityType varchar(100), LastMilestone_Date datetime, LastMilestone int, EmbargoDate datetime );	
	declare @TEMP_TITLES table ( BibID varchar(10), fk_TitleID int, GroupTitle nvarchar(1000), LastActivityDate datetime, LastMilestone_Date datetime, RowNumber int);
	
	-- Do not need to maintain row counts
	Set NoCount ON
	
	-- Determine the start and end rows
	declare @rowstart int; 
	declare @rowend int; 
	set @rowstart = (@pagesize * ( @pagenumber - 1 )) + 1;
	set @rowend = @rowstart + @pagesize - 1; 
	
	-- Determine the aggregationid
	declare @aggregationid int;
	set @aggregationid = ( select ISNULL(AggregationID,-1) from SobekCM_Item_Aggregation where Code=@code );

	-- Get the maximum possible date
	declare @maxDate datetime;
	set @maxDate = cast('12/31/9999' as datetime);
	  
	-- Populate the entire temporary item list	
	insert into @TEMP_ITEMS ( ItemID, fk_TitleID, LastMilestone, LastMilestone_Date, EmbargoDate )
	select I.ItemID, I.GroupID, I.Last_MileStone, 
		CASE I.Last_MileStone 
			WHEN 1 THEN I.Milestone_DigitalAcquisition
			WHEN 2 THEN I.Milestone_ImageProcessing
			WHEN 3 THEN I.Milestone_QualityControl
			WHEN 4 THEN I.Milestone_OnlineComplete
			ELSE I.CreateDate
		END, coalesce(EmbargoEnd, @maxDate)					
	from SobekCM_Item as I inner join
		 SobekCM_Item_Aggregation_Item_Link as CL on ( CL.ItemID = I.ItemID ) left outer join
		 Tracking_Item as T on T.ItemID=I.ItemID
	where ( CL.AggregationID = @aggregationid )
	  and ( I.Deleted = 'false' )
	  and (( I.IP_Restriction_Mask < 0 ) or ( I.Dark = 'true' ));
		
	-- Using common table expressions, add the latest activity and activity type
	with CTE AS (
		select P.ItemID, DateCompleted, WorkFlowName,
		   Rnum=ROW_NUMBER() OVER ( PARTITION BY P.ItemID ORDER BY DateCompleted DESC )
		from Tracking_Progress P, @TEMP_ITEMS T, Tracking_WorkFlow W
		where P.ItemID=T.ItemID and P.WorkFlowID = W.WorkFlowID)
	update I
	set LastActivityDate=cte.DateCompleted, LastActivityType=cte.WorkFlowName
	from @TEMP_ITEMS I INNER JOIN CTE ON CTE.ItemID=I.ItemID and Rnum=1;
	
	-- Set the total counts
	select @total_items=COUNT(ItemID), @total_titles=COUNT(distinct fk_TitleID)
	from @TEMP_ITEMS;
		  
	-- Now, calculate the actual ending row, based on the ration, page information,
	-- and the lookahead factor		
	-- Compute equation to determine possible page value ( max - log(factor, (items/title)/2))
	if (( @total_items > 0 ) and ( @total_titles > 0 ))
	begin
		declare @computed_value int;
		select @computed_value = (@maxpagelookahead - CEILING( LOG10( ((cast(@total_items as float)) / (cast(@total_titles as float)))/@lookahead_factor)));
		
		-- Compute the minimum value.  This cannot be less than @minpagelookahead.
		declare @floored_value int;
		select @floored_value = 0.5 * ((@computed_value + @minpagelookahead) + ABS(@computed_value - @minpagelookahead));
		
		-- Compute the maximum value.  This cannot be more than @maxpagelookahead.
		declare @actual_pages int;
		select @actual_pages = 0.5 * ((@floored_value + @maxpagelookahead) - ABS(@floored_value - @maxpagelookahead));

		-- Set the final row again then
		set @rowend = @rowstart + ( @pagesize * @actual_pages ) - 1;  
	end;
	
	-- SORT ORDERS
	-- 0 = BibID/VID
	-- 1 = Title/VID
	-- 2 = Last Activity Date (most recent first)
	-- 3 = Last Milestone Date (most recent first)
	-- 4 = Last Activity Date (oldest first)
	-- 5 = Last Milestone Date (oldest forst)
	-- 6 = Embargo Date (ASC)
	if (( @sort != 4 ) and ( @sort != 5 ))
	begin
		-- Create saved select across titles for row numbers
		with TITLES_SELECT AS
		 (	select fk_TitleID, MAX(I.LastActivityDate) as MaxActivityDate, MAX(I.LastMilestone_Date) as MaxMilestoneDate,
				ROW_NUMBER() OVER (order by case when @sort=0 THEN G.BibID end,
											case when @sort=1 THEN G.SortTitle end,
											case when @sort=2 THEN MAX(I.LastActivityDate) end DESC,
											case when @sort=3 THEN MAX(I.LastMilestone_Date) end DESC,
											case when @sort=6 THEN MIN(I.EmbargoDate) end ASC) as RowNumber
				from @TEMP_ITEMS I, SobekCM_Item_Group G
				where ( I.fk_TitleID = G.GroupID )
				group by fk_TitleID, G.BibID, G.SortTitle )
			  
		-- Insert the correct rows into the temp title table	
		insert into @TEMP_TITLES ( BibID, fk_TitleID, GroupTitle, LastActivityDate, LastMilestone_Date, RowNumber )
		select G.BibID, S.fk_TitleID, G.GroupTitle, S.MaxActivityDate, S.MaxMilestoneDate, RowNumber
		from TITLES_SELECT S, SobekCM_Item_Group G
		where S.fk_TitleID = G.GroupID
		  and RowNumber >= @rowstart
		  and RowNumber <= @rowend;
	end
	else
	begin
		-- Create saved select across titles for row numbers
		with TITLES_SELECT AS
		 (	select fk_TitleID, MIN(I.LastActivityDate) as MaxActivityDate, MIN(I.LastMilestone_Date) as MaxMilestoneDate,
				ROW_NUMBER() OVER (order by case when @sort=4 THEN MIN(I.LastActivityDate) end ASC,
											case when @sort=5 THEN MIN(I.LastMilestone_Date) end ASC ) as RowNumber
				from @TEMP_ITEMS I, SobekCM_Item_Group G
				where ( I.fk_TitleID = G.GroupID )
				group by fk_TitleID, G.BibID, G.SortTitle )
			  
		-- Insert the correct rows into the temp title table	
		insert into @TEMP_TITLES ( BibID, fk_TitleID, GroupTitle, LastActivityDate, LastMilestone_Date, RowNumber )
		select G.BibID, S.fk_TitleID, G.GroupTitle, S.MaxActivityDate, S.MaxMilestoneDate, RowNumber
		from TITLES_SELECT S, SobekCM_Item_Group G
		where S.fk_TitleID = G.GroupID
		  and RowNumber >= @rowstart
		  and RowNumber <= @rowend;
	end;
	
	-- Return the title information
	select RowNumber, G.BibID, G.GroupTitle, G.[Type], G.ALEPH_Number, G.OCLC_Number, T.LastActivityDate, T.LastMilestone_Date, G.ItemCount, isnull(G.Primary_Identifier_Type, '') as Primary_Identifier_Type, isnull(G.Primary_Identifier,'') as Primary_Identifier
	from @TEMP_TITLES T, SobekCM_Item_Group G
	where T.fk_TitleID = G.GroupID
	order by RowNumber;
	
	-- Return the item informaiton
	select T.RowNumber, VID, I2.Title, isnull(Internal_Comments,'') as Internal_Comments, isnull(PubDate,'') as PubDate, Locally_Archived, Remotely_Archived, AggregationCodes, I.LastActivityDate, I.LastActivityType, I.LastMilestone, I.LastMilestone_Date, Born_Digital, Material_Received_Date, isnull(DAT.DispositionFuture,'') AS Disposition_Advice, Disposition_Date, isnull(DT.DispositionPast,'') AS Disposition_Type, I2.Tracking_Box, I.EmbargoDate, coalesce(M.Creator,'') as Creator
	from @TEMP_ITEMS AS I inner join
		 @TEMP_TITLES AS T ON I.fk_TitleID=T.fk_TitleID inner join
		 SobekCM_Item AS I2 ON I.ItemID = I2.ItemID left outer join
		 Tracking_Disposition_Type AS DAT ON I2.Disposition_Advice=DAT.DispositionID left outer join
		 Tracking_Disposition_Type AS DT ON I2.Disposition_Type=DT.DispositionID left outer join
		 SobekCM_Metadata_Basic_Search_Table as M ON M.ItemID=I.ItemID
	order by T.RowNumber ASC, case when @sort=0 THEN VID end,
							case when @sort=1 THEN VID end,
							case when @sort=2 THEN I.LastActivityDate end DESC,
							case when @sort=3 THEN I.LastMilestone_Date end DESC,
							case when @sort=4 THEN I.LastActivityDate end ASC,
							case when @sort=5 THEN I.LastMilestone_Date end ASC,
							case when @sort=6 THEN I2.SortTitle end ASC;		 
			
    Set NoCount OFF;

end;
GO


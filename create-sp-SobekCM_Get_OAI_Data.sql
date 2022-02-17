USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Get_OAI_Data]    Script Date: 2/16/2022 10:52:36 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Return a list of the OAI data to server through the OAI-PMH server
CREATE PROCEDURE [dbo].[SobekCM_Get_OAI_Data]
	@aggregationcode varchar(20),
	@data_code varchar(20),
	@from date,
	@until date,
	@pagesize int, 
	@pagenumber int,
	@include_data bit
AS
begin

	-- No need to perform any locks here
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	-- Do not need to maintain row counts
	SET NoCount ON;

	-- Create the temporary tables first
	-- Create the temporary table to hold all the item id's
		
	-- Determine the start and end rows
	declare @rowstart int;
	declare @rowend int; 
	set @rowstart = (@pagesize * ( @pagenumber - 1 )) + 1;
	
	-- Rowend is calculated normally, but then an additional item is
	-- added at the end which will be used to determine if a resumption
	-- token should be issued
	set @rowend = (@rowstart + @pagesize - 1) + 1; 
	
	-- Ensure there are date values
	if ( @from is null )
		set @from = CONVERT(date,'19000101');
	if ( @until is null )
		set @until = GETDATE();
	
	-- Is this for a single aggregation
	if (( @aggregationcode is not null ) and ( LEN(@aggregationcode) > 0 ) and ( @aggregationcode != 'all' ))
	begin	
		-- Determine the aggregationid
		declare @aggregationid int;
		set @aggregationid = ( select ISNULL(AggregationID,-1) from SobekCM_Item_Aggregation where Code=@aggregationcode );
			  
		-- Should the actual data be returned, or just the identifiers?
		if ( @include_data='true')
		begin
			-- Create saved select across items/title for row numbers
			with ITEMS_SELECT AS
			(	select BibID, I.ItemID, VID,
				ROW_NUMBER() OVER (order by O.OAI_Date ASC ) as RowNumber
				from SobekCM_Item I, SobekCM_Item_Aggregation_Item_Link CL, SobekCM_Item_Group G, SobekCM_Item_OAI O
				where ( CL.ItemID = I.ItemID )
				  and ( CL.AggregationID = @aggregationid )
				  and ( I.GroupID = G.GroupID )
				  and ( I.ItemID = O.ItemID )
				  and ( G.Suppress_OAI = 'false' )
				  and ( O.OAI_Date >= @from )
				  and ( O.OAI_Date <= @until )
				  and ( O.Data_Code = @data_code )
				  and ( I.Dark = 'false' )
				  and ( I.IP_Restriction_Mask = 0 )
			)
			-- Select the matching rows
			select BibID, T.VID, O.OAI_Data, O.OAI_Date
			from ITEMS_SELECT T, SobekCM_Item_OAI O
			where RowNumber >= @rowstart
			  and RowNumber <= @rowend
			  and T.ItemID = O.ItemID			  
			  and O.Data_Code = @data_code;		 
		end
		else
		begin
			-- Create saved select across titles for row numbers
			with ITEMS_SELECT AS
			(	select BibID, I.ItemID, VID,
				ROW_NUMBER() OVER (order by O.OAI_Date ASC ) as RowNumber
				from SobekCM_Item I, SobekCM_Item_Aggregation_Item_Link CL, SobekCM_Item_Group G, SobekCM_Item_OAI O
				where ( CL.ItemID = I.ItemID )
				  and ( CL.AggregationID = @aggregationid )
				  and ( I.GroupID = G.GroupID )
				  and ( I.ItemID = O.ItemID )
				  and ( G.Suppress_OAI = 'false' )
				  and ( O.OAI_Date >= @from )
				  and ( O.OAI_Date <= @until )
				  and ( O.Data_Code = @data_code )
				  and ( I.Dark = 'false' )				  
				  and ( I.IP_Restriction_Mask = 0 )
			)				
			-- Select the matching rows
			select BibID, T.VID, O.OAI_Date
			from ITEMS_SELECT T, SobekCM_Item_OAI O
			where RowNumber >= @rowstart
			  and RowNumber <= @rowend
			  and T.ItemID = O.ItemID
			  and O.Data_Code = @data_code;	
		end;		  
	end
	else
	begin
				  
		-- Should the actual data be returned, or just the identifiers?
		if ( @include_data='true')
		begin
			-- Create saved select across titles for row numbers
			with ITEMS_SELECT AS
			(	select BibID, I.ItemID, VID,
				ROW_NUMBER() OVER (order by O.OAI_Date ASC) as RowNumber
				from SobekCM_Item_Group G, SobekCM_Item I, SobekCM_Item_OAI O
				where ( G.GroupID = I.GroupID )
				  and ( I.ItemID = O.ItemID )
				  and ( G.Suppress_OAI = 'false' )
				  and ( O.OAI_Date >= @from )
				  and ( O.OAI_Date <= @until )
				  and ( O.Data_Code = @data_code )
				  and ( I.Dark = 'false' )				  
				  and ( I.IP_Restriction_Mask = 0 )
			)												
			-- Select the matching rows
			select BibID, T.VID, O.OAI_Data, O.OAI_Date
			from ITEMS_SELECT T, SobekCM_Item_OAI O
			where RowNumber >= @rowstart
			  and RowNumber <= @rowend
			  and T.ItemID = O.ItemID
			  and O.Data_Code = @data_code;				 
		end
		else
		begin
			-- Create saved select across titles for row numbers
			with ITEMS_SELECT AS
			(	select BibID, I.ItemID, VID,
				ROW_NUMBER() OVER (order by O.OAI_Date ASC) as RowNumber
				from SobekCM_Item_Group G, SobekCM_Item I, SobekCM_Item_OAI O
				where ( G.GroupID = I.GroupID )
				  and ( I.ItemID = O.ItemID )
				  and ( G.Suppress_OAI = 'false' )
				  and ( O.OAI_Date >= @from )
				  and ( O.OAI_Date <= @until )
				  and ( O.Data_Code = @data_code )
				  and ( I.Dark = 'false' )				  
				  and ( I.IP_Restriction_Mask = 0 )
			)										
			-- Select the matching rows
			select BibID, T.VID, O.OAI_Date
			from ITEMS_SELECT T, SobekCM_Item_OAI O
			where RowNumber >= @rowstart
			  and RowNumber <= @rowend
			  and T.ItemID = O.ItemID
			  and O.Data_Code = @data_code;	
		end;
	end;
end;
GO


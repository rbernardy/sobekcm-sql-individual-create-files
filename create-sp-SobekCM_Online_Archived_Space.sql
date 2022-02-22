USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Online_Archived_Space]    Script Date: 2/21/2022 9:51:00 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



-- Determine the size of the online and archived spaces for the whole
-- system, a single item aggregation, or the intersection between two
-- aggregations.
-- Both include_online and include_archive args function as follows:
--   1 = provide complete sum
--   2 = break into year/month (can take a good bit of server cpu)
-- For the TIVOLI data to be up to date, you may need to run the
-- Tivoli_Admin_Update stored procedure first
CREATE PROCEDURE [dbo].[SobekCM_Online_Archived_Space]
	@code1 varchar(20),
	@code2 varchar(20),
	@include_online smallint,
	@include_archive smallint
AS
begin

	-- No need to perform any locks here, especially given the possible
	-- length of this query
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	-- If there are two provided codes, show the union of the two codes
	if ( LEN( ISNULL ( @code2, '' )) > 0 )
	begin
	
		-- Get the amount online by year/month/item for the intersect between these two aggregations
		select I.CreateYear, I.CreateMonth, I.DiskSize_KB AS DiskSize, I.ItemID, TivoliSize_MB
		into #TEMP_ITEMS_ONLINE
		from SobekCM_Item I, SobekCM_Item_Aggregation_Item_Link L, SobekCM_Item_Aggregation A
		where ( I.ItemID = L.ItemID )
		  and ( L.AggregationID = A.AggregationID )
		  and ( A.Code = @code1 )
		  and ( CreateYear > 0 )
		  and ( CreateMonth > 0 )
		intersect
		select I2.CreateYear, I2.CreateMonth, I2.DiskSize_KB AS DiskSize, I2.ItemID, TivoliSize_MB
		from SobekCM_Item I2, SobekCM_Item_Aggregation_Item_Link L2, SobekCM_Item_Aggregation A2
		where ( I2.ItemID = L2.ItemID )
		  and ( L2.AggregationID = A2.AggregationID )
		  and ( A2.Code = @code2 )
		  and ( CreateYear > 0 )
		  and ( CreateMonth > 0 );
		  
	
						 
		-- If the online flag is ONE, just return total size
		if ( @include_online = 1 )
		begin
			-- Get the total online 
			select CAST((SUM(DiskSize))/(1024*1024) as varchar(15)) + ' GB'
			from #TEMP_ITEMS_ONLINE;
		end;
			 
		-- If the online flag is TWO, return by month/year		 
		if ( @include_online = 2 )
		begin
			-- Get the total online by year/month
			select CreateYear, CreateMonth, SUM(DiskSize)
			from #TEMP_ITEMS_ONLINE
			group by CreateYear, CreateMonth
			order by CreateYear, CreateMonth;
		end;
		
		-- If the archive flag is ONE, just return total size
		if ( @include_archive = 1 )
		begin
			-- Get the total tivolid
			select CAST((SUM(TivoliSize_MB))/(1024*1024) as varchar(15)) + ' GB'
			from #TEMP_ITEMS_ONLINE;
		end;
		
		-- If the archive flag is TWO, return by month/year
		if ( @include_archive = 2 )
		begin
			-- Get the archived amount by year/month/item for this aggregation
			select ArchiveYear, ArchiveMonth, SUM(Size)/(1024*1024) AS DiskSize
			from #TEMP_ITEMS_ONLINE T, Tivoli_File_Log A
			where ( A.ItemID=T.ItemID )
			group by ArchiveYear, ArchiveMonth;
		end;
		
		-- drop the temporary tables
		drop table #TEMP_ITEMS_ONLINE;
	
	end
	else
	begin	
	
		-- Is this for ALL items?
		if (( LEN(@code1 ) > 0 ) and ( @code1 != 'all' ))
		begin
			-- If the online flag is ONE, just return total size
			if ( @include_online = 1 )
			begin
				-- Get the total online 
				select CAST((SUM(DiskSize_KB))/(1024*1024) as varchar(15)) + ' GB'
				from SobekCM_Item I, SobekCM_Item_Aggregation_Item_Link L, SobekCM_Item_Aggregation A
				where ( I.ItemID = L.ItemID )
				  and ( L.AggregationID = A.AggregationID )
				  and ( A.Code = @code1 );
			end;
				 
			-- If the online flag is TWO, return by month/year		 
			if ( @include_online = 2 )
			begin
				-- Get the total online by year/month
				select I.CreateYear, I.CreateMonth, SUM(I.DiskSize_KB) AS DiskSize
				from SobekCM_Item I, SobekCM_Item_Aggregation_Item_Link L, SobekCM_Item_Aggregation A
				where ( I.ItemID = L.ItemID )
				  and ( L.AggregationID = A.AggregationID )
				  and ( A.Code = @code1 )
				  and ( CreateYear > 0 )
				  and ( CreateMonth > 0 )
				group by I.CreateYear, I.CreateMonth
				order by I.CreateYear, I.CreateMonth;
			end;
			
			-- If the archive flag is ONE, just return total size
			if ( @include_archive = 1 )
			begin
				-- Get the TOTAL archived amount for this aggregation
				select CAST((SUM(TivoliSize_MB))/(1024*1024) as varchar(15)) + ' GB'
				from SobekCM_Item I, SobekCM_Item_Aggregation_Item_Link L, SobekCM_Item_Aggregation A
				where ( I.ItemID = L.ItemID )
				  and ( L.AggregationID = A.AggregationID )
				  and ( A.Code = @code1 );
			end;

			-- If the archive flag is TWO, return by month/year
			if ( @include_archive = 2 )
			begin
				-- Get the total archived by year/month for this aggregation
				select T.ArchiveYear, T.ArchiveMonth, SUM(T.Size)/(1024*1024) AS DiskSize
				from SobekCM_Item_Aggregation_Item_Link L, SobekCM_Item_Aggregation A, Tivoli_File_Log T
				where ( T.ItemID = L.ItemID )
				  and ( L.AggregationID = A.AggregationID )
				  and ( A.Code = @code1 )
				group by T.ArchiveYear, T.ArchiveMonth
				order by T.ArchiveYear, T.ArchiveMonth;
			end;
		end
		else
		begin -- Just return the COMPLETE sums
			
			-- If the online flag is ONE, just return total size
			if ( @include_online = 1 )
			begin
				-- Get the total online 
				select CAST((SUM(DiskSize_KB))/(1024*1024) as varchar(15)) + ' GB'
				from SobekCM_Item I
			end;
				 
			-- If the online flag is TWO, return by month/year		 
			if ( @include_online = 2 )
			begin
				-- Get the total online by year/month
				select I.CreateYear, I.CreateMonth, SUM(I.DiskSize_KB) AS DiskSize
				from SobekCM_Item I
				where ( CreateYear > 0 )
				  and ( CreateMonth > 0 )
				group by I.CreateYear, I.CreateMonth
				order by I.CreateYear, I.CreateMonth;
			end;
				  
			-- Get the TOTAL archived amount for this system
			select CAST((SUM(TivoliSize_MB))/(1024*1024) as varchar(15)) + ' GB'
			from SobekCM_Item I
		end;
	end;
end;
GO


USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[Tivoli_Admin_Update]    Script Date: 3/16/2022 9:24:16 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Procedure can be run weekly or monthly and performs some basic cleanup functions
-- on the Tivoli information.  First, it ensures that any files that were backed up
-- by BibID/VID before being in the system are now correctly linked to the SobekCM_Item
-- table.  Second, it updates the Tivoli size for each item that has had files backed
-- up to Tivoli since the last time this was run.
CREATE PROCEDURE [dbo].[Tivoli_Admin_Update]
AS
BEGIN

	-- First, ensure all tivoli file logs are linked to bibid/vid
	update Tivoli_File_Log
	set ItemID=( select ItemID from SobekCM_Item_Group G, SobekCM_Item I where I.GroupID=G.GroupID and I.VID=Tivoli_File_Log.VID and G.BibID=Tivoli_File_Log.BibID )
	where exists ( select ItemID from SobekCM_Item_Group G, SobekCM_Item I where I.GroupID=G.GroupID and I.VID=Tivoli_File_Log.VID and G.BibID=Tivoli_File_Log.BibID )
	  and ItemID <= 0;
	  
	-- Determine the most recent date that Tivoli was performed
	declare @lastrun datetime;
	select @lastrun = MAX(TivoliSize_Calculated) from SobekCM_Item;
	
	-- Get the itemids that have been affected in Tivoli since then
	select distinct(ItemID)
	into #TEMP_ITEMS
	from Tivoli_File_Log 
	where ArchiveDate >= @lastrun
	  and ItemID > 0;
	  
	-- Using the same update date should make it easier in the future
	declare @today datetime;
	set @today=GETDATE();
  
	-- Now, update the size tivoli'd for the items
	update SobekCM_Item 
	set TivoliSize_MB=isnull((select SUM(Size/1024) from Tivoli_File_Log L where L.ItemID=SobekCM_Item.ItemID ), 0 ),
	    TivoliSize_Calculated = @today
	where ItemID in ( select * from #TEMP_ITEMS );

end;
GO


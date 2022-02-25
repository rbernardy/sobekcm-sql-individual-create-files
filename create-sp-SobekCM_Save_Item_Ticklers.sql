USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Save_Item_Ticklers]    Script Date: 2/24/2022 10:42:17 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Saves the ticklers for a single digital resource (item)
-- Written by Mark Sullivan 
CREATE PROCEDURE [dbo].[SobekCM_Save_Item_Ticklers]
	@ItemID int,
	@Tickler1 varchar(50),
	@Tickler2 varchar(50),
	@Tickler3 varchar(50),
	@Tickler4 varchar(50),
	@Tickler5 varchar(50)
AS
begin transaction

	-- Delete all links to ticklers for this item
	select L.MetadataID 
	into #TEMP_TICKLERS
	from SobekCM_Metadata_Unique_Link L, SobekCM_Metadata_Unique_Search_Table S
	where ( L.ItemID = @ItemID ) 
	  and ( L.MetadataID = S.MetadataID )
	  and ( S.MetadataTypeID = 20 );
	  
	delete from SobekCM_Metadata_Unique_Link
	where ItemID=@ItemID
	  and MetadataID in ( select * from #TEMP_TICKLERS );
	  
	drop table #TEMP_TICKLERS;
	
	-- Build the tickler to insert into the basic search table as well
	declare @tickler nvarchar(max);
	set @tickler='';
		
	-- Add the first tickler to this item
	if ( len( coalesce( @Tickler1, '' )) > 0 ) 
	begin
		set @tickler=@tickler + ' | ' + @Tickler1;
		exec SobekCM_Metadata_Save_Single @ItemID, 'Tickler', @Tickler1;
	end

	-- Add the second tickler to this item
	if ( len( coalesce( @Tickler2, '' )) > 0 ) 
	begin
		set @tickler=@tickler + ' | ' + @Tickler2;
		exec SobekCM_Metadata_Save_Single @ItemID, 'Tickler', @Tickler2;
	end
	
	-- Add the third tickler to this item
	if ( len( coalesce( @Tickler3, '' )) > 0 ) 
	begin
		set @tickler=@tickler + ' | ' + @Tickler3;
		exec SobekCM_Metadata_Save_Single @ItemID, 'Tickler', @Tickler3;
	end
	
	-- Add the fourth tickler to this item
	if ( len( coalesce( @Tickler4, '' )) > 0 ) 
	begin
		set @tickler=@tickler + ' | ' + @Tickler4;
		exec SobekCM_Metadata_Save_Single @ItemID, 'Tickler', @Tickler4;
	end
	
	-- Add the fifth tickler to this item
	if ( len( coalesce( @Tickler5, '' )) > 0 ) 
	begin
		set @tickler=@tickler + ' | ' + @Tickler5;
		exec SobekCM_Metadata_Save_Single @ItemID, 'Tickler', @Tickler5;
	end
	
	-- Set the tickler value for this item in the basic search table
	update SobekCM_Metadata_Basic_Search_Table
	set Tickler=@tickler
	where ItemID=@ItemID;

commit transaction
GO


USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Add_Item_Error_Log]    Script Date: 1/23/2022 10:24:19 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Add an error into the item error log (usually added by the builder during processing
CREATE PROCEDURE [dbo].[SobekCM_Add_Item_Error_Log]
	@BibID varchar(10),
	@VID varchar(5),
	@METS_Type varchar(20),
	@ErrorDescription varchar(1000)
AS
BEGIN
	-- This is it's own unlinked table since the error may have involved not being able to
	-- save the item to the database, in which case there will be no item to link
	-- the error to.
	insert into SobekCM_Item_Error_Log ( BibID, VID, ErrorDescription, METS_Type, Date )
	values ( @BibID, @VID, @ErrorDescription, @METS_Type, getdate());
	
END;
GO


USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Clear_Item_Error_Log]    Script Date: 2/6/2022 7:36:17 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


/****** Object:  StoredProcedure [dbo].[SobekCM_Clear_Item_Error_Log]    Script Date: 12/20/2013 05:43:36 ******/
-- Marks items from the item error log as cleared, by date.  This does not actually
-- clear the item error completely, just marks the error as cleared so the history 
-- of the error log is maintained
CREATE PROCEDURE [dbo].[SobekCM_Clear_Item_Error_Log]
	@BibID varchar(10),
	@VID varchar(5),
	@ClearedBy varchar(100)
AS
BEGIN

	update SobekCM_Item_Error_Log
	set ClearedBy = @ClearedBy, ClearedDate=getdate()
	where BibID=@BibID and VID=@VID;
	
END;
GO


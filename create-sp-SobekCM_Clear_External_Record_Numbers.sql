USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Clear_External_Record_Numbers]    Script Date: 2/6/2022 7:31:03 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


/****** Object:  StoredProcedure [dbo].[SobekCM_Clear_External_Record_Numbers]    Script Date: 12/20/2013 05:43:36 ******/
-- This procedure clears all external record numbers from an existing item
CREATE PROCEDURE [dbo].[SobekCM_Clear_External_Record_Numbers]
	@groupID int
AS
begin

	-- Remove any links
	delete from SobekCM_Item_Group_External_Record where GroupID = @groupid;
	
end;
GO


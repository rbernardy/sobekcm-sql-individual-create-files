USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Update_Additional_Work_Needed_Flag]    Script Date: 3/16/2022 7:58:36 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Updates the 'additional work needed' flag for an item, which tells
-- the builder that it should be post-processed.
CREATE procedure [dbo].[SobekCM_Update_Additional_Work_Needed_Flag] 
	@itemid int,
	@newflag bit
as
begin
	update SobekCM_Item set AdditionalWorkNeeded=@newflag where ItemID=@itemid;
end;
GO


USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Save_Item_Aggregation_Hierarchy_Link]    Script Date: 2/23/2022 8:25:27 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Stored procedure to link between item aggregations
-- Written by Ying, modified by Mark ( 2/2007 )
-- This stored procedure is used by the Customization Manager
CREATE PROCEDURE [dbo].[SobekCM_Save_Item_Aggregation_Hierarchy_Link]
	@collectionid int,
	@groupid int
AS
begin transaction

   -- Verify there is not already a link here
   declare  @thiscount int
   select @thiscount = count(*)
   from SobekCM_Item_Aggregation_Hierarchy
   where (ParentID = @groupid) and (ChildID = @collectionid)

   -- if there was no link, add one
   if (@thiscount  <= 0)
   begin 
       insert into SobekCM_Item_Aggregation_Hierarchy(ParentID, ChildID)
       values(@groupid, @collectionid)
   end
  
commit transaction
GO


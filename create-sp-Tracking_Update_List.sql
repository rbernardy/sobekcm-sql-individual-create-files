USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[Tracking_Update_List]    Script Date: 3/22/2022 10:09:41 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Procedure pulls the bibs and vids updated on SobekCM since the provided date. 
CREATE PROCEDURE [dbo].[Tracking_Update_List]
      @sinceDate varchar(10)
as
begin
      select BibID, VID, DateCompleted, WorkFlowName, WorkPerformedBy
      from Tracking_WorkFlow W, Tracking_Progress P, SobekCM_Item_Group G, SobekCM_Item I
      where ( W.WorkFlowID = P.WorkFlowID )
        and ( P.ItemID = I.ItemID ) 
        and ( I.GroupID = G.GroupID )
        and (( W.WorkFlowID = 29 ) or ( W.WorkFlowID = 30 ) or ( W.WorkFlowID = 34 ) or ( W.WorkFlowID = 35 ) or ( W.WorkFlowID = 36 ) or ( W.WorkFlowID=40 ) or (W.WorkFlowID=44))
        and ( DateCompleted > @sinceDate )
      order by DateCompleted DESC
end
GO


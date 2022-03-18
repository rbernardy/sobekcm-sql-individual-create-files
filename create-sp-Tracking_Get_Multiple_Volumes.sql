USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[Tracking_Get_Multiple_Volumes]    Script Date: 3/17/2022 10:49:20 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Stored procedure returns the information about all the items within a single 
-- title or item/group
-- Written by Mark Sullivan ( November 2006 )
CREATE PROCEDURE [dbo].[Tracking_Get_Multiple_Volumes] 
	@bibid varchar(10)
AS
begin transaction

		-- Return the individual volumes
		select I.ItemID, Title, Level1_Text=isnull(Level1_Text,''), Level1_Index=isnull(Level1_Index,-1), Level2_Text=isnull(Level2_Text, ''), Level2_Index=isnull(Level2_Index, -1), Level3_Text=isnull(Level3_Text, ''), Level3_Index=isnull(Level3_Index, -1), Level4_Text=isnull(Level4_Text, ''), Level4_Index=isnull(Level4_Index, -1), Level5_Text=isnull(Level5_Text, ''), Level5_Index=isnull(Level5_Index,-1), I.MainThumbnail, I.VID, I.IP_Restriction_Mask, I.Author, I.Publisher, I.AggregationCodes, I.Tracking_Box, I.Born_Digital, I.Material_Received_Date, I.Material_Recd_Date_Estimated, I.Disposition_Advice, I.Disposition_Advice_Notes, I.Disposition_Type, I.Disposition_Date, I.Disposition_Notes, PubDate, SortDate, I.SortTitle, I.Last_MileStone, I.Remotely_Archived, I.Locally_Archived
		from SobekCM_Item I, SobekCM_Item_Group G
		where ( G.GroupID = I.GroupID )
		  and ( G.BibID = @bibid )
		  and ( I.Deleted = 'false' )
		  and ( G.Deleted = 'false' )
		order by Level1_Index ASC, Level2_Index ASC, Level3_Index ASC, Level4_Index ASC, Level5_Index ASC, I.SortTitle ASC;

commit transaction
GO


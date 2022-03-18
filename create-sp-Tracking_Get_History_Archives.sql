USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[Tracking_Get_History_Archives]    Script Date: 3/17/2022 9:58:58 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Tracking_Get_History_Archives]
	@itemid int
AS
BEGIN	
		-- The first return table is the CD information for this volume
		select CD_Number = ArchiveNumber, File_Range = FileRangeOnCD, Images,  [Size]= ltrim(rtrim(convert(varchar(20),imagesize_kb)))+'KB',  Date_Burned = convert(varchar(10),DateSorted,101) 
		from Tracking_Archive_Item_Link L, Tracking_ArchiveMedia M
		where (L.ItemID = @itemid )
		  and (L.ArchiveMediaID = M.ArchiveMediaID )
		order by ArchiveNumber ASC

		-- The second return table is the progress information for this volume
		select P.WorkFlowID, [Workflow Name]=WorkFlowName, [Completed Date]=isnull(CONVERT(CHAR(10), DateCompleted, 102),''), WorkPerformedBy=isnull(WorkPerformedBy, ''), WorkingFilePath=isnull(WorkingFilePath,''), Note=isnull(ProgressNote,'')
		from Tracking_Progress P, Tracking_Workflow W
		where (P.workflowid = W.workflowid)
		  and (P.ItemID = @itemid )
		order by DateCompleted ASC		
		
		-- The third return table is all the files from TIVOLI
		select BibID, VID, Folder, [FileName], Size, LastWriteDate, ArchiveDate
		from Tivoli_File_Log
		where ItemID = @itemid	
		
		-- The fourth return table has the item information (used by SMaRT app)
		select * from SobekCM_Item where ItemID=@itemid
		
		-- The fifth return table has the aggregations this item is linked to
		select A.Code, A.Name, A.ShortName, A.[Type], L.impliedLink, A.Hidden, A.isActive
		from SobekCM_Item_Aggregation_Item_Link L, SobekCM_Item_Aggregation A
		where ( L.ItemID = @ItemID )
		  and ( A.AggregationID = L.AggregationID )
			
END
GO


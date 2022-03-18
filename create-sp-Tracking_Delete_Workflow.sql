USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[Tracking_Delete_Workflow]    Script Date: 3/17/2022 9:13:41 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


/* Stored procedure to delete a workflow entry */
CREATE PROCEDURE [dbo].[Tracking_Delete_Workflow]
	@workflow_entry_id int 
AS	
	begin	
	 
		-- Delete this workflow entry 
		delete from Tracking_Progress
		where ProgressID=@workflow_entry_id;	 

	end;
GO


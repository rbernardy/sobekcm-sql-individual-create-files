USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[FDA_Get_Report_By_ID]    Script Date: 1/13/2022 10:06:04 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- ==========================================================
-- Author:		Sullivan, Mark
-- Create date: October 1, 2007
-- Description:	Get all the information about a single report
-- ==========================================================
CREATE PROCEDURE [dbo].[FDA_Get_Report_By_ID]
	@FdaReportID int
AS
BEGIN
	
	-- Get the report data first
	select Package=isnull(Package,''), IEID=isnull(IEID,''), FdaReportType, Report_Date, Account=isnull(Account,''), 
		Project = isnull(Project,''), Warnings=isnull(Warnings,0), [Message]=isnull([Message],''), Database_Date 
	from FDA_Report R, FDA_Report_Type T
	where ( R.FdaReportID = @FdaReportID )
	  and ( T.FdaReportTypeID = R.FdaReportTypeID )

END
GO


USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[FDA_All_Reports]    Script Date: 1/13/2022 9:51:00 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- ==========================================================
-- Author:		Sullivan, Mark
-- Create date: October 3, 2007
-- Description:	Retrieve all the FDA reports from the database
-- ==========================================================
CREATE PROCEDURE [dbo].[FDA_All_Reports]
AS
BEGIN
	
	-- Return all the reports
	select R.FdaReportID, Data_Index = -1, R.Package, IEID, FdaReportType, CONVERT(VARCHAR(10), Report_Date, 102) as ReportDate, Warnings, 
		[Message], FTP_Date = isnull( CONVERT(VARCHAR(10), L.FtpDate, 102), '')
	from FDA_Report R inner join
		FDA_Report_Type AS T on ( R.FdaReportTypeID = T.FdaReportTypeID ) left outer join
		FDA_FTP_Log AS L on ( R.Package = L.Package )
	order by R.Package

END
GO


USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[FDA_Get_Reports_By_Package]    Script Date: 1/13/2022 10:19:50 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- ==========================================================
-- Author:		Sullivan, Mark
-- Create date: October 1, 2007
-- Description:	Get all the information about a single report
-- ==========================================================
CREATE PROCEDURE [dbo].[FDA_Get_Reports_By_Package]
	@Package varchar(50),
	@IEID varchar(50)
AS
BEGIN

	-- If the IEID is given, use that
	if ( len( @IEID ) > 0 )
	begin

		-- Get the report data first
		select FdaReportID, Package=isnull(Package,''), IEID=isnull(IEID,''), FdaReportType, CONVERT(CHAR(10), Report_Date, 102) as Report_Date, Account=isnull(Account,''), 
			Project = isnull(Project,''), Warnings=isnull(Warnings,0), [Message]=isnull([Message],''), Database_Date 
		from FDA_Report R, FDA_Report_Type T
		where ( R.IEID = @IEID )
		  and ( T.FdaReportTypeID = R.FdaReportTypeID )

	end
	else -- Use Package ID
	begin
	
		-- Get the report data first
		select R.FdaReportID, Package=isnull(Package,''), IEID=isnull(IEID,''), FdaReportType, CONVERT(CHAR(10), Report_Date, 102) as Report_Date, Account=isnull(Account,''), 
			Project = isnull(Project,''), Warnings=isnull(Warnings,0), [Message]=isnull([Message],''), Database_Date 
		from FDA_Report R, FDA_Report_Type T
		where ( R.Package = @Package )
		  and ( T.FdaReportTypeID = R.FdaReportTypeID )

	end
END
GO


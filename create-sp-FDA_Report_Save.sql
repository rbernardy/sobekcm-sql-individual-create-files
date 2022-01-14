USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[FDA_Report_Save]    Script Date: 1/13/2022 10:27:03 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- ==========================================================
-- Author:		Sullivan, Mark
-- Create date: October 1, 2007
-- Description:	Save information about a single FDA Report 
-- ==========================================================
CREATE PROCEDURE [dbo].[FDA_Report_Save]
	@Package varchar(50),
	@IEID varchar(50),
	@FdaReportType varchar(50),
	@Report_Date datetime,
	@Account varchar(50),
	@Project varchar(50),
	@Warnings int,
	@Message varchar(1000),
	@BibID varchar(10),
	@VID varchar(5),
	@FdaReportID int output
AS
begin transaction

	-- Find the volume id
	declare @itemid int
	set @itemid = -1

	-- Add as a progress as well
	if ( ( select count(*) from SobekCM_Item I, SobekCM_Item_Group G where ( I.VID = @VID ) and ( I.GroupID = G.GroupID ) and ( G.BibID= @BibID)) > 0 )
	begin
		-- Select the volume id
		select @itemid = ItemID from SobekCM_Item I, SobekCM_Item_Group G where ( I.VID = @VID ) and ( I.GroupID = G.GroupID ) and ( G.BibID= @BibID)

		-- Mark as complete if report type is ''INGEST''
		if ( @FdaReportType = 'INGEST' )
		begin
			-- Add this new progress then
			insert into Tracking_Progress ( ItemID, WorkFlowID, DateCompleted, ProgressNote )
			values ( @itemID, 23, isnull(@Report_Date, getdate()), @IEID )
			
			-- Update the FDA remote archive flag
			update SobekCM_Item set Remotely_Archived = 'true' where ItemID=@itemid
		end

		-- Mark as complete if report type is ''INGEST''
		if ( @FdaReportType = 'ERROR' )
		begin
			-- Add this new progress then
			insert into Tracking_Progress ( ItemID, WorkFlowID, DateCompleted, ProgressNote )
			values ( @itemID, 22, isnull(@Report_Date, getdate()), @Message )
		end
	end
	
	-- Find the FDA Report Type ID, or insert it
	declare @reporttypeid int

	-- Does this type already exists
	if ( ( select count(*) from FDA_Report_Type where FdaReportType=@FdaReportType ) = 1 )
	begin
		-- Get the existing primary key
		select @reporttypeid = FdaReportTypeID
		from FDA_Report_Type
		where FdaReportType = @FdaReportType
	end
	else
	begin

		-- Insert a new row
		insert into FDA_Report_Type ( FdaReportType )
		values ( @FdaReportType )

		-- Get the new primary key
		set @reporttypeid = @@identity
	end

	-- Does this report already exist?
	if ( ( select count(*) from FDA_Report where (Package = @Package) and ( FdaReportTypeID = @reporttypeid ) and ( Report_Date = @Report_Date )) > 0 )
	begin

		-- Get the existing fda report id
		select @FdaReportID = FdaReportID 
		from FDA_Report 
		where (Package = @Package) 
		  and ( FdaReportTypeID = @reporttypeid ) 
		  and ( Report_Date = @Report_Date )

	end
	else
	begin

		-- Insert this report information (new report)
		insert into FDA_Report ( Package, IEID, FdaReportTypeID, Report_Date, Account, Project, Warnings, [Message], Database_Date, ItemID )
		values ( @Package, @IEID, @reporttypeid, @Report_Date, @Account, @Project, @Warnings, @Message, getDate(), @itemid )
	
		-- Return the new primary key
		set @FdaReportID = @@identity

	end
commit transaction
GO


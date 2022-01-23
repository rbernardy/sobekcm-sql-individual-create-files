USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Builder_Log_Search]    Script Date: 1/23/2022 4:13:39 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



-- Procedure returns builder logs, by date range and/or by bibid_vid
CREATE PROCEDURE [dbo].[SobekCM_Builder_Log_Search]
	@startdate datetime,
	@enddate datetime,
	@bibid_vid varchar(20),
	@include_no_work_entries bit
AS
BEGIN

	-- Set the start date and end date if they are null
	if ( @startdate is null ) set @startdate = '1/1/2000';
	if ( @enddate is null ) set @enddate = dateadd(day, 1, getdate());

	-- If the @bibid_vid is NULL or empty, than this is only a date search
	if ( len(coalesce(@bibid_vid,'')) = 0 )
	begin
		-- Date search only needs to pay attention to the 'include no work' flag
		if ( @include_no_work_entries = 'true' )
		begin
			-- Just return all the date ranged rows
			select BuilderLogID, RelatedBuilderLogID, LogDate, coalesce(BibID_VID,'') as BibID_VID, coalesce(LogType,'') as LogType, coalesce(LogMessage,'') as LogMessage, SuccessMessage, METS_Type
			from SobekCM_Builder_Log
			where ( LogDate >= @startdate )
			  and ( LogDate <= @enddate )
			order by LogDate DESC;
		end
		else
		begin
			-- Only include the rows that are NOT 'No Work'
			select BuilderLogID, RelatedBuilderLogID, LogDate, coalesce(BibID_VID,'') as BibID_VID, coalesce(LogType,'') as LogType, coalesce(LogMessage,'') as LogMessage, SuccessMessage, METS_Type
			from SobekCM_Builder_Log
			where ( LogDate >= @startdate )
			  and ( LogDate <= @enddate )
			  and ( LogType != 'No Work' )
			order by LogDate DESC;
		end;
		return;
	end;

	-- Is this a LIKE search, or an exact search?
	if ( charindex('%', @bibid_vid ) > 0 )
	begin
		-- This is a LIKE expression
		select BuilderLogID, RelatedBuilderLogID, LogDate, coalesce(BibID_VID,'') as BibID_VID, coalesce(LogType,'') as LogType, coalesce(LogMessage,'') as LogMessage, SuccessMessage, METS_Type
		from SobekCM_Builder_Log
		where ( LogDate >= @startdate )
		  and ( LogDate <= @enddate )
		  and ( BibID_VID like @bibid_vid )
		order by LogDate DESC;
	end
	else
	begin
		-- This is an EXACT match
		select BuilderLogID, RelatedBuilderLogID, LogDate, coalesce(BibID_VID,'') as BibID_VID, coalesce(LogType,'') as LogType, coalesce(LogMessage,'') as LogMessage, SuccessMessage, METS_Type
		from SobekCM_Builder_Log
		where ( LogDate >= @startdate )
		  and ( LogDate <= @enddate )
		  and ( BibID_VID = @bibid_vid )
		order by LogDate DESC;
	end;
END;
GO


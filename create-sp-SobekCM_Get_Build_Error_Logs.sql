USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Get_Build_Error_Logs]    Script Date: 2/12/2022 4:29:53 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Get the build errors between two dates.  Due to the date comparison, the
-- second date should really be midnight on the NEXT day.  So, if you want all
-- the build errors between 1/1/2000 and 1/2/2000, the datetimes you should use
-- would be '1/1/2000' and '1/3/2000'.
CREATE PROCEDURE [dbo].[SobekCM_Get_Build_Error_Logs]
	@firstdate datetime,
	@seconddate datetime
AS
BEGIN

	-- No need to perform any locks here
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
	
	-- Return the errors within the range, which were not cleared
	select BibID, VID, METS_Type=isnull(METS_Type,''), ErrorDescription=isnull(ErrorDescription,''), [Date]
	from SobekCM_Item_Error_Log
	where ( len(isnull(ClearedBy,'')) = 0 ) 
	  and ( ClearedDate is null )
      and ( [DATE] >= @firstdate )
	  and ( [Date] < @seconddate )
	order by [Date] DESC;
END;
GO


USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Builder_Expire_Log_Entries]    Script Date: 1/23/2022 2:04:12 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



-- Procedure to remove expired log files
CREATE PROCEDURE [dbo].[SobekCM_Builder_Expire_Log_Entries]
	@Retain_For_Days int
AS 
BEGIN
	-- Calculate the expiration date time
	declare @expiredate datetime;
	set @expiredate = dateadd(day, (-1 * @Retain_For_Days), getdate());
	set @expiredate = dateadd(hour, -1 * datepart(hour,@expiredate), @expiredate);
	
	-- Delete all logs from before this time
	delete from SobekCM_Builder_Log
	where ( LogDate <= @expiredate )
	  and ( LogType = 'No Work' );

END;
GO


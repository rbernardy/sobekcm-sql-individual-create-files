USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[Tivoli_Complete_File_Request]    Script Date: 3/17/2022 7:37:37 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Procedure completes a tivoli file retrieval request
CREATE PROCEDURE [dbo].[Tivoli_Complete_File_Request]
	@tivolirequestid int,
	@email_body nvarchar(max),
	@email_subject nvarchar(250),
	@isFailure bit
AS
begin

	-- Update this request to reflect completed
	update Tivoli_File_Request
	set Completed = 'true', CompleteDate = GETDATE(), ReplyEmailSubject=@email_subject, RequestFailed=@isFailure
	where TivoliRequestID = @tivolirequestid;
	
	-- Get the email address
	declare @email varchar(100);
	select @email = EmailAddress from Tivoli_File_Request where TivoliRequestId=@tivolirequestid;
	
	-- Send the email
	EXEC msdb.dbo.sp_send_dbmail
		@profile_name= 'ufdc noreply profile',
		@recipients = @email,
		@body = @email_body,
		@subject = @email_subject; 

end
GO


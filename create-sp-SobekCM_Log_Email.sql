USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Log_Email]    Script Date: 2/20/2022 6:54:15 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Log an email which was sent through a different method.  This does not
-- cause a database mail to be sent, just logs an email which was sent
CREATE PROCEDURE [dbo].[SobekCM_Log_Email] 
	@sender varchar(250),
	@recipients_list varchar(500),
	@subject_line varchar(240),
	@email_body nvarchar(max),
	@html_format bit,
	@contact_us bit,
	@replytoemailid int
AS
begin

	-- Log this email
	insert into SobekCM_Email_Log( Sender, Receipt_List, Subject_Line, Email_Body, Sent_Date, HTML_Format, Contact_Us, ReplyToEmailID )
	values ( @sender, @recipients_list, @subject_line + '( log only )', @email_body, GETDATE(), @html_format, @contact_us, @replytoemailid );
	
end;
GO


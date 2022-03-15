USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Send_Email]    Script Date: 3/14/2022 10:41:50 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Sends an email via database mail and additionally logs that the email was sent
CREATE PROCEDURE [dbo].[SobekCM_Send_Email] 
	@recipients_list varchar(250),
	@subject_line varchar(500),
	@email_body nvarchar(max),
	@from_address nvarchar(250),
	@reply_to nvarchar(250), 
	@html_format bit,
	@contact_us bit,
	@replytoemailid int,
	@userid int
AS
begin transaction

	if (( @userid < 0 ) or (( select count(*) from SobekCM_Email_Log where UserID = @userid and Sent_Date > DateAdd( DAY, -1, GETDATE())) < 20 ))
	begin

		-- Look for an exact match for the recipients_list.  One recipient list should AT MOST get 250 emails over a 24 hours period
		if ( ( select count(*) from SobekCM_Email_Log where Receipt_List=@recipients_list and Sent_Date > DateAdd( DAY, -1, GETDATE())) > 250 )
		begin
			-- Just add this to the email log, but indicate not sent
			insert into SobekCM_Email_Log( Sender, Receipt_List, Subject_Line, Email_Body, Sent_Date, HTML_Format, Contact_Us, ReplyToEmailId, UserID )
			values ( 'sobekcm noreply profile', @recipients_list, @subject_line + '(not delivered)', 'Too many emails to this recipient list in last 24 hours.  Governer kicked in and this email was not sent.   ' + @email_body, GETDATE(), @html_format, @contact_us, @replytoemailid, @userid );

		end
		else
		begin

			-- Log this email
			insert into SobekCM_Email_Log( Sender, Receipt_List, Subject_Line, Email_Body, Sent_Date, HTML_Format, Contact_Us, ReplyToEmailId, UserID )
			values ( 'sobekcm noreply profile', @recipients_list, @subject_line, @email_body, GETDATE(), @html_format, @contact_us, @replytoemailid, @userid );
		
			-- Send the email
			if ( @html_format = 'true' )
			begin
				if ( len(coalesce(@from_address,'')) > 0 )
				begin
					if ( len(coalesce(@reply_to,'')) > 0 )
					begin
						EXEC msdb.dbo.sp_send_dbmail
							@profile_name= 'sobekcm noreply profile',
							@recipients = @recipients_list,
							@body = @email_body,
							@subject = @subject_line,
							@body_format = 'html',
							@from_address = @from_address,
							@reply_to = @reply_to;
					end
					else
					begin
						EXEC msdb.dbo.sp_send_dbmail
							@profile_name= 'sobekcm noreply profile',
							@recipients = @recipients_list,
							@body = @email_body,
							@subject = @subject_line,
							@body_format = 'html',
							@from_address = @from_address;
					end;
				end
				else
				begin
					if ( len(coalesce(@reply_to,'')) > 0 )
					begin
						EXEC msdb.dbo.sp_send_dbmail
							@profile_name= 'sobekcm noreply profile',
							@recipients = @recipients_list,
							@body = @email_body,
							@subject = @subject_line,
							@body_format = 'html',
							@reply_to = @reply_to;
					end
					else
					begin
						EXEC msdb.dbo.sp_send_dbmail
							@profile_name= 'sobekcm noreply profile',
							@recipients = @recipients_list,
							@body = @email_body,
							@subject = @subject_line,
							@body_format = 'html';
					end;
				end;
			end
			else
			begin
				if ( len(coalesce(@from_address,'')) > 0 )
				begin
					if ( len(coalesce(@reply_to,'')) > 0 )
					begin
						EXEC msdb.dbo.sp_send_dbmail
							@profile_name= 'sobekcm noreply profile',
							@recipients = @recipients_list,
							@body = @email_body,
							@subject = @subject_line,
							@from_address = @from_address,
							@reply_to = @reply_to;
					end
					else
					begin
						EXEC msdb.dbo.sp_send_dbmail
							@profile_name= 'sobekcm noreply profile',
							@recipients = @recipients_list,
							@body = @email_body,
							@subject = @subject_line,
							@from_address = @from_address;
					end;
				end
				else
				begin
					if ( len(coalesce(@reply_to,'')) > 0 )
					begin
						EXEC msdb.dbo.sp_send_dbmail
							@profile_name= 'sobekcm noreply profile',
							@recipients = @recipients_list,
							@body = @email_body,
							@subject = @subject_line,
							@reply_to = @reply_to;
					end
					else
					begin
						EXEC msdb.dbo.sp_send_dbmail
							@profile_name= 'sobekcm noreply profile',
							@recipients = @recipients_list,
							@body = @email_body,
							@subject = @subject_line;
					end;
				end;
			end;
		end;
	end;
	
commit transaction;
GO


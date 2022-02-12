USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Get_Email_List]    Script Date: 2/12/2022 6:02:34 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Returns the list of emails from the email logging system.  
-- @Include_All_Types - if TRUE, all emails returned, otherwise just the 'Contact Us' emails
CREATE PROCEDURE [dbo].[SobekCM_Get_Email_List]
	@Include_All_Types bit,
	@Top100_Only bit
AS
begin

	-- No need to perform any locks here
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
	
	-- Should ALL types of emails be returned, or just the 'Contact Us' emails?
	if ( @Include_All_Types = 'true' )
	begin
		-- Should only the top 100 be returned?
		if ( @Top100_Only = 'true' )
		begin
			-- Return the top 100 emails of any type
			select top 100 EmailID, Sender, Receipt_List, Subject_Line, Sent_Date, SUBSTRING(Email_Body,0,500) as Preview, HTML_Format, Contact_Us, isnull(ReplyToEmailID, -1) as ReplyToEmailID 
			from SobekCM_Email_Log
			order by Sent_Date DESC;
		end
		else
		begin
			-- Return all emails of any type
			select EmailID, Sender, Receipt_List, Subject_Line, Sent_Date, SUBSTRING(Email_Body,0,500) as Preview, HTML_Format, Contact_Us, isnull(ReplyToEmailID, -1) as ReplyToEmailID 
			from SobekCM_Email_Log
			order by Sent_Date DESC;
		end;
	end
	else
	begin
		-- Should only the top 100 be returned?
		if ( @Top100_Only = 'true' )
		begin
			-- Return the top 100 'contact us' emails
			select top 100 EmailID, Sender, Receipt_List, Subject_Line, Sent_Date, SUBSTRING(Email_Body,0,500) as Preview, HTML_Format, Contact_Us, isnull(ReplyToEmailID, -1) as ReplyToEmailID 
			from SobekCM_Email_Log
			where Contact_Us = 'true'
			order by Sent_Date DESC;
		end
		else
		begin
			-- Return all 'contact us' emails
			select EmailID, Sender, Receipt_List, Subject_Line, Sent_Date, SUBSTRING(Email_Body,0,500) as Preview, HTML_Format, Contact_Us, isnull(ReplyToEmailID, -1) as ReplyToEmailID 
			from SobekCM_Email_Log
			where Contact_Us = 'true'
			order by Sent_Date DESC;
		end;
	end;
end;
GO


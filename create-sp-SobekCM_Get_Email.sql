USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Get_Email]    Script Date: 2/12/2022 5:54:35 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Gets an email from the email logging system, by the primary key for the Email.
-- This also includes any responses to this original email
CREATE PROCEDURE [dbo].[SobekCM_Get_Email]
	@EmailID int
AS
begin
	-- No need to perform any locks here
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
	
	-- Get the original email
	select * from SobekCM_Email_Log where EmailID=@EmailID;
	
	-- Get any responses to this email	
	select * from SobekCM_Email_Log where ReplyToEmailID=@EmailID;
end;
GO


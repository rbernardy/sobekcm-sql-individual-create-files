USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[mySobek_Delete_Template]    Script Date: 1/17/2022 6:52:56 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


/****** Object:  StoredProcedure [dbo].[mySobek_Delete_Template]    Script Date: 12/20/2013 05:43:35 ******/
-- Procedure to delete a project completely.
-- Added in Version 3.05
CREATE PROCEDURE [dbo].[mySobek_Delete_Template]
	@template_code varchar(20)
AS
BEGIN

	-- Only continue if the template code exists
	if (( select count(*) from mySobek_Template where TemplateCode = @template_code ) > 0 )
	begin		
		-- Get the project id
		declare @templateid int;
		select @templateid=TemplateID from mySobek_Template where TemplateCode = @template_code;
		
		-- Remove links to user groups
		delete from mySobek_User_Group_Template_Link
		where TemplateID = @templateid;
		
		-- Remove links to users
		delete from mySobek_User_Template_Link
		where TemplateID = @templateid;
		
		-- Delete this template
		delete from mySobek_Template
		where TemplateID=@templateid;

	end;
END;
GO


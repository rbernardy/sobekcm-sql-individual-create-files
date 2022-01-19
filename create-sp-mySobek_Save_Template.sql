USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[mySobek_Save_Template]    Script Date: 1/19/2022 6:29:47 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Add a new template to this database
CREATE PROCEDURE [dbo].[mySobek_Save_Template]
	@template_code varchar(20),
	@template_name varchar(100),
	@description varchar(255)
AS
BEGIN
	
	-- Does this template already exist?
	if (( select count(*) from mySobek_Template where TemplateCode=@template_code ) > 0 )
	begin
		-- Update the existing template
		update mySobek_Template
		set TemplateName = @template_name, [Description]=@description
		where TemplateCode = @template_code
	end
	else
	begin
		-- Add a new template
		insert into mySobek_Template ( TemplateName, TemplateCode, [Description] )
		values ( @template_name, @template_code, @description )
	end
END
GO


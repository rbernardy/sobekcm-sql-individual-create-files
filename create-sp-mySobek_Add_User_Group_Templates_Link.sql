USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[mySobek_Add_User_Group_Templates_Link]    Script Date: 1/17/2022 5:46:47 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Add a link between a user and a template 
CREATE PROCEDURE [dbo].[mySobek_Add_User_Group_Templates_Link]
	@usergroupid int,
	@template1 varchar(20),
	@template2 varchar(20),
	@template3 varchar(20),
	@template4 varchar(20),
	@template5 varchar(20)
AS
begin

	-- Add the default template
	if (( len(@template1) > 0 ) and ( (select count(*) from mySobek_Template where TemplateCode = @template1 ) = 1 ))
	begin
		-- Get the id for this one
		declare @template1_id int
		select @template1_id = TemplateID from mySobek_Template where TemplateCode=@template1

		-- Add this one as a default
		insert into mySobek_User_Group_Template_Link ( UserGroupID, TemplateID )
		values ( @usergroupid, @template1_id )
	end

	-- Add the second template
	if (( len(@template2) > 0 ) and ((select count(*) from mySobek_Template where TemplateCode = @template2 ) = 1 ))
	begin
		-- Get the id for this one
		declare @template2_id int
		select @template2_id = TemplateID from mySobek_Template where TemplateCode=@template2

		-- Add this one
		insert into mySobek_User_Group_Template_Link ( UserGroupID, TemplateID )
		values ( @usergroupid, @template2_id )
	end

	-- Add the third template
	if (( len(@template3) > 0 ) and ((select count(*) from mySobek_Template where TemplateCode = @template3 ) = 1 ))
	begin
		-- Get the id for this one
		declare @template3_id int
		select @template3_id = TemplateID from mySobek_Template where TemplateCode=@template3

		-- Add this one
		insert into mySobek_User_Group_Template_Link ( UserGroupID, TemplateID )
		values ( @usergroupid, @template3_id )
	end

	-- Add the fourth template
	if (( len(@template4) > 0 ) and ((select count(*) from mySobek_Template where TemplateCode = @template4 ) = 1 ))
	begin
		-- Get the id for this one
		declare @template4_id int
		select @template4_id = TemplateID from mySobek_Template where TemplateCode=@template4

		-- Add this one
		insert into mySobek_User_Group_Template_Link ( UserGroupID, TemplateID )
		values ( @usergroupid, @template4_id )
	end

	-- Add the fifth template
	if (( len(@template5) > 0 ) and ((select count(*) from mySobek_Template where TemplateCode = @template5 ) = 1 ))
	begin
		-- Get the id for this one
		declare @template5_id int
		select @template5_id = TemplateID from mySobek_Template where TemplateCode=@template5

		-- Add this one
		insert into mySobek_User_Group_Template_Link ( UserGroupID, TemplateID )
		values ( @usergroupid, @template5_id )
	end
end
GO


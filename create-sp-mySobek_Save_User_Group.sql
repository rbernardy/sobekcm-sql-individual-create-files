USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[mySobek_Save_User_Group]    Script Date: 1/19/2022 7:04:18 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Saves information about a single user group
CREATE PROCEDURE [dbo].[mySobek_Save_User_Group]
	@usergroupid int,
	@groupname nvarchar(150),
	@groupdescription nvarchar(1000),
	@can_submit_items bit,
	@is_internal bit,
	@can_edit_all bit,
	@is_system_admin bit,
	@is_portal_admin bit,
	@include_tracking_standard_forms bit,
	@clear_metadata_templates bit,
	@clear_aggregation_links bit,
	@clear_editable_links bit,
	@is_sobek_default bit,
	@is_shibboleth_default bit,
	@is_ldap_default bit,
	@new_usergroupid int output
AS 
begin
	
	-- Is there a user group id provided
	if ( @usergroupid < 0 )
	begin
		-- Insert as a new user group
		insert into mySobek_User_Group ( GroupName, GroupDescription, Can_Submit_Items, Internal_User, IsSystemAdmin, IsPortalAdmin, Include_Tracking_Standard_Forms, IsSobekDefault, IsShibbolethDefault, IsLdapDefault  )
		values ( @groupname, @groupdescription, @can_submit_items, @is_internal, @is_system_admin, @is_portal_admin, @include_tracking_standard_forms, @is_sobek_default, @is_shibboleth_default, @is_ldap_default );
		
		-- Return the new primary key
		set @new_usergroupid = @@IDENTITY;	
	end
	else
	begin
		-- Update, if it exists
		update mySobek_User_Group
		set GroupName = @groupname, GroupDescription = @groupdescription, Can_Submit_Items = @can_submit_items, Internal_User=@is_internal, IsSystemAdmin=@is_system_admin, IsPortalAdmin=@is_portal_admin, Include_Tracking_Standard_Forms=@include_tracking_standard_forms, 
			IsSobekDefault=@is_sobek_default, IsShibbolethDefault=@is_shibboleth_default, IsLdapDefault=@is_ldap_default
		where UserGroupID = @usergroupid;
	
	end;
	
	-- Check the flag to edit all items
	if ( @can_edit_all = 'true' )
	begin	
		if ( ( select count(*) from mySobek_User_Group_Editable_Link where EditableID=1 and UserGroupID=@usergroupid ) = 0 )
		begin
			-- Add the link to the ALL EDITABLE
			insert into mySobek_User_Group_Editable_Link ( UserGroupID, EditableID )
			values ( @usergroupid, 1 );
		end
	end
	else
	begin
		-- Delete the link to all
		delete from mySobek_User_Group_Editable_Link where EditableID = 1 and UserGroupID=@usergroupid;
	end;
	
		-- Clear the projects/templates
	if ( @clear_metadata_templates = 'true' )
	begin
		delete from mySobek_User_Group_DefaultMetadata_Link where UserGroupID=@usergroupid;
		delete from mySobek_User_Group_Template_Link where UserGroupID=@usergroupid;
	end;

	-- Clear the aggregations link
	if ( @clear_aggregation_links = 'true' )
	begin
		delete from mySobek_User_Group_Edit_Aggregation where UserGroupID=@usergroupid;
	end;
	
	-- Clear the editable link
	if ( @clear_editable_links = 'true' )
	begin
		delete from mySobek_User_Group_Editable_Link where UserGroupID=@usergroupid;
	end;

end;
GO


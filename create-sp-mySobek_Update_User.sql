USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[mySobek_Update_User]    Script Date: 1/19/2022 8:45:50 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



-- Procedure allows an admin to edit permissions flags for this user
CREATE PROCEDURE [dbo].[mySobek_Update_User]
      @userid int,
      @can_submit bit,
      @is_internal bit,
      @can_edit_all bit,
      @can_delete_all bit,
	  @is_user_admin bit,
      @is_portal_admin bit,
      @is_system_admin bit,
	  @is_host_admin bit,
      @include_tracking_standard_forms bit,
      @edit_template varchar(20),
      @edit_template_marc varchar(20),
      @clear_projects_templates bit,
      @clear_aggregation_links bit,
      @clear_user_groups bit
AS
begin transaction

      -- Update the simple table values
      update mySobek_User
      set Can_Submit_Items=@can_submit, Internal_User=@is_internal, 
            IsPortalAdmin=@is_portal_admin, IsSystemAdmin=@is_system_admin, 
            Include_Tracking_Standard_Forms=@include_tracking_standard_forms, 
            EditTemplate=@edit_template, Can_Delete_All_Items = @can_delete_all,
            EditTemplateMarc=@edit_template_marc, IsHostAdmin=@is_host_admin,
			IsUserAdmin=@is_user_admin
      where UserID=@userid;

      -- Check the flag to edit all items
      if ( @can_edit_all = 'true' )
      begin 
            if ( ( select count(*) from mySobek_User_Editable_Link where EditableID=1 and UserID=@userid ) = 0 )
            begin
                  -- Add the link to the ALL EDITABLE
                  insert into mySobek_User_Editable_Link ( UserID, EditableID )
                  values ( @userid, 1 );
            end;
      end
      else
      begin
            -- Delete the link to all
            delete from mySobek_User_Editable_Link where EditableID = 1 and UserID=@userid;
      end;

      -- Clear the projects/templates
      if ( @clear_projects_templates = 'true' )
      begin
            delete from mySobek_User_DefaultMetadata_Link where UserID=@userid;
            delete from mySobek_User_Template_Link where UserID=@userid;
      end;

      -- Clear the projects/templates
      if ( @clear_aggregation_links = 'true' )
      begin
            delete from mySobek_User_Edit_Aggregation where UserID=@userid;
      end;
      
      -- Clear the user groups
      if ( @clear_user_groups = 'true' )
      begin
            delete from mySobek_User_Group_Link where UserID=@userid;
      end;

commit transaction;

GO


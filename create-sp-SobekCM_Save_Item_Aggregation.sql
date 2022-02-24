USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Save_Item_Aggregation]    Script Date: 2/23/2022 8:05:27 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



-- Stored procedure to save the basic item aggregation information
CREATE PROCEDURE [dbo].[SobekCM_Save_Item_Aggregation]
	@aggregationid int,
	@code varchar(20),
	@name nvarchar(255),
	@shortname nvarchar(100),
	@description nvarchar(1000),
	@thematicHeadingId int,
	@type varchar(50),
	@isactive bit,
	@hidden bit,
	@display_options varchar(10),
	@map_search tinyint,
	@map_display tinyint,
	@oai_flag bit,
	@oai_metadata nvarchar(2000),
	@contactemail varchar(255),
	@defaultinterface varchar(10),
	@externallink nvarchar(255),
	@parentid int,
	@username varchar(100),
	@languageVariants varchar(500),
	@groupResults bit,
	@newaggregationid int output
AS
begin transaction

	-- Set flag to see if this was basically just created (either new or undeleted)
	declare @newly_added bit;
	set @newly_added = 'false';

   -- If the aggregation id is less than 1 then this is for a new aggregation
   if ((@aggregationid  < 1 ) and (( select COUNT(*) from SobekCM_Item_Aggregation where Code=@code ) = 0 ))
   begin

		-- Insert a new row
		insert into SobekCM_Item_Aggregation(Code, [Name], Shortname, Description, ThematicHeadingID, [Type], isActive, Hidden, DisplayOptions, Map_Search, Map_Display, OAI_Flag, OAI_Metadata, ContactEmail, HasNewItems, DefaultInterface, External_Link, DateAdded, LanguageVariants, GroupResults )
		values(@code, @name, @shortname, @description, @thematicHeadingId, @type, @isActive, @hidden, @display_options, @map_search, @map_display, @oai_flag, @oai_metadata, @contactemail, 'false', @defaultinterface, @externallink, GETDATE(), @languageVariants, @groupResults );

		-- Get the primary key
		set @newaggregationid = @@identity;
       
		-- insert the CREATED milestone
		insert into [SobekCM_Item_Aggregation_Milestones] ( AggregationID, Milestone, MilestoneDate, MilestoneUser )
		values ( @newaggregationid, 'Created', getdate(), @username );

		-- Since this was a brand new, set flag
		set @newly_added='true';
   end
   else
   begin

	  -- Add special code to indicate if this aggregation was undeleted
	  if ( exists ( select 1 from SobekCM_Item_Aggregation where Code=@Code and Deleted='true'))
	  begin
		declare @deletedid int;
		set @deletedid = ( select aggregationid from SobekCM_Item_Aggregation where Code=@Code );

		-- insert the UNDELETED milestone
		insert into [SobekCM_Item_Aggregation_Milestones] ( AggregationID, Milestone, MilestoneDate, MilestoneUser )
		values ( @deletedid, 'Created (undeleted as previously existed)', getdate(), @username );

		-- Since this was undeleted, let's make sure this collection isn't linked 
		-- to any parent collections
		delete from SobekCM_Item_Aggregation_Hierarchy
		where ChildID=@deletedid;

		-- Since this was UNDELETED, set flag
		set @newly_added='true';
	  end;

      -- Update the existing row
      update SobekCM_Item_Aggregation
      set  
		Code = @code,
		[Name] = @name,
		ShortName = @shortname,
		[Description] = @description,
		ThematicHeadingID = @thematicHeadingID,
		[Type] = @type,
		isActive = @isactive,
		Hidden = @hidden,
		DisplayOptions = @display_options,
		Map_Search = @map_search,
		Map_Display = @map_display,
		OAI_Flag = @oai_flag,
		OAI_Metadata = @oai_metadata,
		ContactEmail = @contactemail,
		DefaultInterface = @defaultinterface,
		External_Link = @externallink,
		Deleted = 'false',
		DeleteDate = null,
		LanguageVariants = @languageVariants,
		GroupResults = @groupResults
      where AggregationID = @aggregationid or Code = @code;

      -- Set the return value to the existing id
      set @newaggregationid = ( select aggregationid from SobekCM_Item_Aggregation where Code=@Code );

   end;



	-- Was a parent id provided
	if ( isnull(@parentid, -1 ) > 0 )
	begin
		-- Now, see if the link to the parent exists
		if (( select count(*) from SobekCM_Item_Aggregation_Hierarchy H where H.ParentID = @parentid and H.ChildID = @newaggregationid ) < 1 )
		begin			
			insert into SobekCM_Item_Aggregation_Hierarchy ( ParentID, ChildID )
			values ( @parentid, @newaggregationid );
		end;
	end;

	-- If this was newly added (new or undeleted), ensure permissions and other things copied over from parent
	if ( @newly_added = 'true' )
	begin
		-- There should ALWAYS be a parent for new collections, even if it is the ALL collection
		if ( isnull(@parentid, -1 ) < 0 )
		begin
			set @parentid = ( select AggregationID from SobekCM_Item_Aggregation where Code='ALL' );
		end;

		-- Since this is NEW, set the group results based on the parent
		update SobekCM_Item_Aggregation
		set GroupResults = ( select GroupResults from SobekCM_Item_Aggregation where AggregationID=@parentid )
		where AggregationID=@newaggregationid;

			-- Add individual user permissions first
			insert into mySobek_User_Edit_Aggregation ( UserID, AggregationID, CanSelect, CanEditItems, 
				IsCurator, IsAdmin, CanEditMetadata, CanEditBehaviors, CanPerformQc, 
				CanUploadFiles, CanChangeVisibility, CanDelete )
			select UserID, @newaggregationid, CanSelect, CanEditItems, 
				IsCurator, IsAdmin, CanEditMetadata, CanEditBehaviors, CanPerformQc, 
				CanUploadFiles, CanChangeVisibility, CanDelete
			from mySobek_User_Edit_Aggregation A
			where ( AggregationID = @parentid )
			  and ( not exists ( select * from mySobek_User_Edit_Aggregation L where L.UserID=A.UserID and L.AggregationID=@newaggregationid ))
			  and (    ( CanEditMetadata='true' ) 
	                or ( CanEditBehaviors='true' )
	                or ( CanPerformQc='true' )
	                or ( CanUploadFiles='true' )
	                or ( CanChangeVisibility='true' )
	                or ( IsCurator='true' )
	                or ( IsAdmin='true' ));

			-- Add user group permissions next 
			insert into mySobek_User_Group_Edit_Aggregation ( UserGroupID, AggregationID, CanSelect, CanEditItems, 
				IsCurator, IsAdmin, CanEditMetadata, CanEditBehaviors, CanPerformQc, 
				CanUploadFiles, CanChangeVisibility, CanDelete )
			select UserGroupID, @newaggregationid, CanSelect, CanEditItems, 
				IsCurator, IsAdmin, CanEditMetadata, CanEditBehaviors, CanPerformQc, 
				CanUploadFiles, CanChangeVisibility, CanDelete
			from mySobek_User_Group_Edit_Aggregation A
			where ( AggregationID = @parentid )
			  and ( not exists ( select * from mySobek_User_Group_Edit_Aggregation L where L.UserGroupID=A.UserGroupID and L.AggregationID=@newaggregationid ))
			  and (    ( CanEditMetadata='true' ) 
	                or ( CanEditBehaviors='true' )
	                or ( CanPerformQc='true' )
	                or ( CanUploadFiles='true' )
	                or ( CanChangeVisibility='true' )
	                or ( IsCurator='true' )
	                or ( IsAdmin='true' ));

			-- Copy over the facet fields
			insert into SobekCM_Item_Aggregation_Facets ( AggregationID, MetadataTypeID, OverrideFacetTerm, FacetOrder, FacetOptions )
			select @newaggregationid, MetadataTypeID, OverrideFacetTerm, FacetOrder, FacetOptions
			from SobekCM_Item_Aggregation_Facets
			where AggregationID=@parentid;

			-- Copy over the results views from the parent
			insert into SobekCM_Item_Aggregation_Result_Views ( AggregationID, ItemAggregationResultTypeID, DefaultView )
			select @newaggregationid, ItemAggregationResultTypeID, DefaultView
			from SobekCM_Item_Aggregation_Result_Views
			where AggregationID=@parentid;

			-- Now, add the result view fields from the parent
			insert into SobekCM_Item_Aggregation_Result_Fields ( ItemAggregationResultID, MetadataTypeID, OverrideDisplayTerm, DisplayOrder, DisplayOptions )
			select V2.ItemAggregationResultID, F1.MetadataTypeID, F1.OverrideDisplayTerm, F1.DisplayOrder, F1.DisplayOptions
			from SobekCM_Item_Aggregation_Result_Views V1, SobekCM_Item_Aggregation_Result_Fields F1, SobekCM_Item_Aggregation_Result_Views V2
			where V1.ItemAggregationResultID=F1.ItemAggregationResultID
			  and V1.AggregationID=@parentid
			  and V2.ItemAggregationResultTypeID=V1.ItemAggregationResultTypeID
			  and V2.AggregationID=@newaggregationid;
		end;

commit transaction;
GO


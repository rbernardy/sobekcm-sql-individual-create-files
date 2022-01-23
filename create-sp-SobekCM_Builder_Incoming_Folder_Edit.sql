USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Builder_Incoming_Folder_Edit]    Script Date: 1/23/2022 4:05:36 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



-- Add a new incoming folder for the builder/bulk loader, or edit
-- an existing incoming folder (by incoming folder id)
CREATE PROCEDURE [dbo].[SobekCM_Builder_Incoming_Folder_Edit]
	@IncomingFolderId int,
	@NetworkFolder varchar(255),
	@ErrorFolder varchar(255),
	@ProcessingFolder varchar(255),
	@Perform_Checksum_Validation bit,
	@Archive_TIFF bit,
	@Archive_All_Files bit,
	@Allow_Deletes bit,
	@Allow_Folders_No_Metadata bit,
	@FolderName nvarchar(150),
	@BibID_Roots_Restrictions varchar(255),
	@ModuleSetID int
AS 
BEGIN

	-- Keep the last network folder value
	declare @lastFolder varchar(255);
	set @lastFolder = '';

	-- Is this a new incoming folder?
	if (( select COUNT(*) from SobekCM_Builder_Incoming_Folders where IncomingFolderId=@IncomingFolderId ) = 0 )
	begin	
		-- Insert new incoming folder
		insert into SobekCM_Builder_Incoming_Folders ( NetworkFolder, ErrorFolder, ProcessingFolder, Perform_Checksum_Validation, Archive_TIFF, Archive_All_Files, Allow_Deletes, Allow_Folders_No_Metadata, FolderName, Allow_Metadata_Updates, BibID_Roots_Restrictions, ModuleSetID )
		values ( @NetworkFolder, @ErrorFolder, @ProcessingFolder, @Perform_Checksum_Validation, @Archive_TIFF, @Archive_All_Files, @Allow_Deletes, @Allow_Folders_No_Metadata, @FolderName, 'true', @BibID_Roots_Restrictions, @ModuleSetID );
	end
	else
	begin

		-- Since it exists, get the old network folder
		set @lastFolder = ( select NetworkFolder from SobekCM_Builder_Incoming_Folders where IncomingFolderId=@IncomingFolderId );

		-- update existing incoming folder
		update SobekCM_Builder_Incoming_Folders
		set NetworkFolder=@NetworkFolder, ErrorFolder=@ErrorFolder, ProcessingFolder=@ProcessingFolder, 
			Perform_Checksum_Validation=@Perform_Checksum_Validation, Archive_TIFF=@Archive_TIFF, 
			Archive_All_Files=@Archive_All_Files, Allow_Deletes=@Allow_Deletes, 
			Allow_Folders_No_Metadata=@Allow_Folders_No_Metadata, FolderName=@FolderName,
			BibID_Roots_Restrictions=@BibID_Roots_Restrictions, ModuleSetID=@ModuleSetID
		where IncomingFolderId = @IncomingFolderId;
	end;
		
	-- If this is the only folder, and there is no main builder folder, set that one
	if ( ( select count(*) from SObekCM_Builder_Incoming_Folders ) = 1 )
	begin
		-- Is there a valid Main Builder Folder setting?
		if ( not exists ( select 1 from SobekCM_Settings where Setting_Key = 'Main Builder Input Folder' ))
		begin
			-- There was no match
			insert into SobekCM_Settings ( Setting_Key, Setting_Value, TabPage, Heading, Hidden, Reserved, Help  )
			values ( 'Main Builder Input Folder', @NetworkFolder, 'Builder', 'Builder Settings', 0, 0, 'This is the network location to the SobekCM Builder''s main incoming folder.\n\nThis is used by the SMaRT tool when doing bulk imports from spreadsheet or MARC records.' );
		end
		else if ( not exists ( select 1 from SobekCM_Settings where Setting_Key = 'Main Builder Input Folder' and len(coalesce(Setting_Value,'')) > 0 ))
		begin
			-- One existed, but apparently it had no value
			update SobekCM_Settings
			set Setting_Value = @NetworkFolder
			where Setting_Key = 'Main Builder Input Folder';
		end
		else if ( exists ( select 1 from SobekCM_Settings where Setting_Key = 'Main Builder Input Folder' and Setting_Value=@lastFolder ))
		begin
			-- One existed, pointed at the OLD network folder, so change it
			update SobekCM_Settings
			set Setting_Value = @NetworkFolder
			where Setting_Key = 'Main Builder Input Folder';
		end;
	end;
END;
GO


USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Builder_Get_Incoming_Folder]    Script Date: 1/23/2022 2:44:24 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Get the information about a single incoming folder
CREATE PROCEDURE [dbo].[SobekCM_Builder_Get_Incoming_Folder] 
	@FolderId int
AS
BEGIN

	-- Return all the data about it 
	select IncomingFolderId, NetworkFolder, ErrorFolder, ProcessingFolder, Perform_Checksum_Validation, Archive_TIFF, Archive_All_Files,
		   Allow_Deletes, Allow_Folders_No_Metadata, Allow_Metadata_Updates, FolderName, BibID_Roots_Restrictions,
		   F.ModuleSetID, S.SetName
	from SobekCM_Builder_Incoming_Folders F left outer join 
	     SobekCM_Builder_Module_Set S on F.ModuleSetID=S.ModuleSetID
	where F.IncomingFolderId=@FolderId;

	-- Also return the modules linked to each (enabled) folder module set
	select S.ModuleSetID, S.SetName, M.[Assembly], M.Class, M.[Enabled], M.Argument1, M.Argument2, M.Argument3, M.ModuleDesc, M.[Order], S.[Enabled]
	from SobekCM_Builder_Incoming_Folders F inner join
		 SobekCM_Builder_Module_Set S on S.ModuleSetID=F.ModuleSetID inner join 
		 SobekCM_Builder_Module M on M.ModuleSetID=S.ModuleSetID 	 
	where F.IncomingFolderId=@FolderId
	order by M.[Order];

END;
GO


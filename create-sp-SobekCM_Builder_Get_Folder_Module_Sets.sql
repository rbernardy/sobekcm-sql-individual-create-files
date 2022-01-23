USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Builder_Get_Folder_Module_Sets]    Script Date: 1/23/2022 2:23:14 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Procedure returns the names (and details) of all the module sets used for folders
CREATE PROCEDURE [dbo].[SobekCM_Builder_Get_Folder_Module_Sets]
as
begin

	-- Get the count of used folder modules
	with folder_modules_used ( ModuleSetID, UsedCount ) as
	( 
		select ModuleSetID, count(*) as UsedCount
		from SobekCM_Builder_Incoming_Folders 
		group by ModuleSetID
	) 
	select S.ModuleSetID, S.SetName, coalesce(U.UsedCount, 0) as UsedCount
	from SobekCM_Builder_Module_Set S inner join 
		 SobekCM_Builder_Module_Type T on S.ModuleTypeID=T.ModuleTypeID left outer join
		 folder_modules_used U on U.ModuleSetID=S.ModuleSetID
	where ( T.TypeAbbrev = 'FOLD' )
	  and ( S.[Enabled] = 1 )
	order by UsedCount DESC;

	-- Also return the modules linked to each (enabled) folder module set
	select S.ModuleSetID, S.SetName, M.[Assembly], M.Class, M.[Enabled], M.Argument1, M.Argument2, M.Argument3, M.ModuleDesc, M.[Order]
	from SobekCM_Builder_Module_Set S inner join 
		 SobekCM_Builder_Module_Type T on S.ModuleTypeID=T.ModuleTypeID inner join
		 SobekCM_Builder_Module M on M.ModuleSetID=S.ModuleSetID
	where ( T.TypeAbbrev = 'FOLD' )
	  and ( S.[Enabled] = 1 )
	order by S.ModuleSetID, M.[Order];

end;
GO


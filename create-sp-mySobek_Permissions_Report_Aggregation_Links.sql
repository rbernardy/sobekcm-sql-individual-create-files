USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[mySobek_Permissions_Report_Aggregation_Links]    Script Date: 1/18/2022 10:23:20 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



-- Get the list of users and for each user the list of aggregations they
-- have special rights over (wither by user or through user group )
CREATE PROCEDURE [dbo].[mySobek_Permissions_Report_Aggregation_Links] as
begin
	-- Create a temporary table to hold all the user-aggregations links
	create table #tmpAggrPermissions (
		UserID int primary key,
		UserPermissioned varchar(2000),
		GroupPermissioned varchar(2000)
	);


	-- Return the aggregation-specific permissions (at user level unioned with group level)
	insert into #tmpAggrPermissions (UserID)
	select UserID
	from mySobek_User_Edit_Aggregation as P inner join
		 SobekCM_Item_Aggregation A on A.AggregationID=P.AggregationID
	where ( P.CanEditMetadata='true' ) 
	   or ( P.CanEditBehaviors='true' )
	   or ( P.CanPerformQc='true' )
	   or ( P.CanUploadFiles='true' )
	   or ( P.CanChangeVisibility='true' )
	   or ( P.IsCurator='true' )
	   or ( P.IsAdmin='true' )
	group by UserID
	union
	select UserID
	from mySobek_User_Group_Link as L inner join
		 mySobek_User_Group as G on G.UserGroupID = L.UserGroupID inner join
		 mySobek_User_Group_Edit_Aggregation as P on P.UserGroupID = P.UserGroupID inner join
		 SobekCM_Item_Aggregation A on A.AggregationID=P.AggregationID
	where ( P.CanEditMetadata='true' ) 
	   or ( P.CanEditBehaviors='true' )
	   or ( P.CanPerformQc='true' )
	   or ( P.CanUploadFiles='true' )
	   or ( P.CanChangeVisibility='true' )
	   or ( P.IsCurator='true' )
	   or ( P.IsAdmin='true' )
	group by UserID;

	-- Create the cursor to go through the users
	declare UserCursor CURSOR
	LOCAL STATIC FORWARD_ONLY READ_ONLY
	for select UserID from #tmpAggrPermissions;

	-- Open the user cursor
	open UserCursor;

	-- Variable for the cursor loops
	declare @UserID int;
	declare @Code varchar(20);
	declare @UserPermissions varchar(2000);
	declare @GroupPermissions varchar(2000);

	-- Fetch first userid
	fetch next from UserCursor into @UserId;

	-- Step through all users
	While ( @@FETCH_STATUS = 0 )
	begin
		-- Clear the permissions variables
		set @UserPermissions = '';
		set @GroupPermissions = '';

		-- Create the cursor aggregation permissions at the user level	
		declare UserPermissionedCursor CURSOR
		LOCAL STATIC FORWARD_ONLY READ_ONLY
		FOR
		select A.Code
		from mySobek_User_Edit_Aggregation as P inner join
			 SobekCM_Item_Aggregation A on A.AggregationID=P.AggregationID
		where ( P.UserID=@UserID )
		  and (    ( P.CanEditMetadata='true' ) 
		        or ( P.CanEditBehaviors='true' )
		        or ( P.CanPerformQc='true' )
		        or ( P.CanUploadFiles='true' )
		        or ( P.CanChangeVisibility='true' )
		        or ( P.IsCurator='true' )
		        or ( P.IsAdmin='true' ))
		order by A.Code;
	    
		-- Open the user-level aggregation permissions cursor
		open UserPermissionedCursor;

		-- Fetch first user-level aggregation permissions
		fetch next from UserPermissionedCursor into @Code;

		-- Step through each aggregation-level permissioned
		while ( @@FETCH_STATUS = 0 )
		begin
			set @UserPermissions = @UserPermissions + @Code + ', ';

			-- Fetch next user-level aggregation permissions
			fetch next from UserPermissionedCursor into @Code;
		end;

		CLOSE UserPermissionedCursor;
		DEALLOCATE UserPermissionedCursor;

		-- Create the cursor aggregation permissions at the group level	
		declare GroupPermissionedCursor CURSOR
		LOCAL STATIC FORWARD_ONLY READ_ONLY
		FOR
		select A.Code
		from mySobek_User_Group_Link as L inner join
			 mySobek_User_Group as G on G.UserGroupID = L.UserGroupID inner join
			 mySobek_User_Group_Edit_Aggregation as P on P.UserGroupID = P.UserGroupID inner join
			 SobekCM_Item_Aggregation A on A.AggregationID=P.AggregationID
		where ( L.UserID=@UserID )
		  and (    ( P.CanEditMetadata='true' ) 
		        or ( P.CanEditBehaviors='true' )
		        or ( P.CanPerformQc='true' )
		        or ( P.CanUploadFiles='true' )
		        or ( P.CanChangeVisibility='true' )
		        or ( P.IsCurator='true' )
		        or ( P.IsAdmin='true' ))
		group by A.Code
		order by A.Code;
	    
		-- Open the group-level aggregation permissions cursor
		open GroupPermissionedCursor;

		-- Fetch first group-level aggregation permissions
		fetch next from GroupPermissionedCursor into @Code;

		-- Step through each aggregation-level permissioned
		while ( @@FETCH_STATUS = 0 )
		begin
			set @GroupPermissions = @GroupPermissions + @Code + ', ';

			-- Fetch next group-level aggregation permissions
			fetch next from GroupPermissionedCursor into @Code;
		end;

		CLOSE GroupPermissionedCursor;
		DEALLOCATE GroupPermissionedCursor;

		-- Now, update this row
		update #tmpAggrPermissions
		set UserPermissioned=@UserPermissions, GroupPermissioned=@GroupPermissions
		where UserID=@UserId;

		-- Fetch next userid
		fetch next from UserCursor into @UserId;
	end;

	CLOSE UserCursor;
	DEALLOCATE UserCursor;

	-- Return the list of users linked to aggregations, either by group or individually
	select U.UserID, UserName, EmailAddress, FirstName, LastName, Nickname, DateCreated, LastActivity, isActive, T.UserPermissioned, T.GroupPermissioned
	from #tmpAggrPermissions T, mySobek_User U
	where T.UserID=U.UserID
	order by LastName ASC, FirstName ASC;
end;
GO


USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[mySobek_Permissions_Report_Submission_Rights]    Script Date: 1/18/2022 10:58:32 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



-- Get the list of users, with informaiton about the templates and default metadata
CREATE PROCEDURE [dbo].[mySobek_Permissions_Report_Submission_Rights] as
BEGIN

	-- Create a temporary table to hold all the user-aggregations links
	create table #tmpSubmitPermissions (
		UserID int primary key,
		Templates varchar(2000),
		DefaultMetadatas varchar(2000)
	);

	-- Get the list of all users that can submit materials
	insert into #tmpSubmitPermissions (UserID)
	select U.UserID
	from mySobek_User as U 
	where  ( Can_Submit_Items = 'true' )
	union
	select U.UserID
	from mySobek_User as U inner join
		 mySobek_User_Group_Link as L on U.UserID = L.UserID inner join
		 mySobek_User_Group as G on G.UserGroupID = L.UserGroupID 
	where ( G.Can_Submit_Items = 'true' );

	-- Create the cursor to go through the users
	declare UserCursor CURSOR
	LOCAL STATIC FORWARD_ONLY READ_ONLY
	for select UserID from #tmpSubmitPermissions;

	-- Open the user cursor
	open UserCursor;

	-- Variable for the cursor loops
	declare @UserID int;
	declare @Code varchar(20);
	declare @Templates varchar(2000);
	declare @DefaultMetadata varchar(2000);

	-- Fetch first userid
	fetch next from UserCursor into @UserId;

	-- Step through all users
	While ( @@FETCH_STATUS = 0 )
	begin
		-- Clear the permissions variables
		set @Templates = '';
		set @DefaultMetadata = '';

		-- Create the cursor for the templates	
		declare UserTemplateCursor CURSOR
		LOCAL STATIC FORWARD_ONLY READ_ONLY
		FOR
		select T.TemplateCode
		from mySobek_User_Template_Link L,
		     mySobek_Template T
		where L.UserID = @UserID 
		  and L.TemplateID = T.TemplateID
		order by TemplateCode;
	    
		-- Open the templates cursor
		open UserTemplateCursor;

		-- Fetch first template code
		fetch next from UserTemplateCursor into @Code;

		-- Step through each template
		while ( @@FETCH_STATUS = 0 )
		begin
			set @Templates = @Templates + @Code + ', ';

			-- Fetch next template
			fetch next from UserTemplateCursor into @Code;
		end;

		CLOSE UserTemplateCursor;
		DEALLOCATE UserTemplateCursor;

		-- Create the cursor for the default metadata sets (previously Projects)
		declare DefaultMetadataCursor CURSOR
		LOCAL STATIC FORWARD_ONLY READ_ONLY
		FOR
		select M.MetadataCode
		from mySobek_User_DefaultMetadata_Link L,
		     mySobek_DefaultMetadata M
		where L.UserID = @UserID 
		  and L.DefaultMetadataID = M.DefaultMetadataID
		order by MetadataCode;
	    
		-- Open the default metadata cursor
		open DefaultMetadataCursor;

		-- Fetch first default metadata set linked to this user
		fetch next from DefaultMetadataCursor into @Code;

		-- Step through each default metadata set linked to this user
		while ( @@FETCH_STATUS = 0 )
		begin
			set @DefaultMetadata = @DefaultMetadata + @Code + ', ';

			-- Fetch next default metadata set linked to this user
			fetch next from DefaultMetadataCursor into @Code;
		end;

		CLOSE DefaultMetadataCursor;
		DEALLOCATE DefaultMetadataCursor;

		-- Now, update this row
		update #tmpSubmitPermissions
		set Templates=@Templates, DefaultMetadatas=@DefaultMetadata
		where UserID=@UserId;

		-- Fetch next userid
		fetch next from UserCursor into @UserId;
	end;

	CLOSE UserCursor;
	DEALLOCATE UserCursor;


	-- Return the list
	select U.UserID, UserName, EmailAddress, FirstName, LastName, Nickname, DateCreated, LastActivity, isActive, 
	       coalesce(T.Templates,'') as Templates, coalesce(T.DefaultMetadatas,'') as DefaultMetadatas
	from #tmpSubmitPermissions T, mySobek_User U
	where T.UserID=U.UserID
	order by LastName ASC, FirstName ASC;

	-- Drop the temporary table
	drop table #tmpSubmitPermissions;

END;
GO


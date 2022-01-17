USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[mySobek_Add_User_Group_Metadata_Link]    Script Date: 1/17/2022 5:41:09 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Add a link between a user and a set of default metadata 
CREATE PROCEDURE [dbo].[mySobek_Add_User_Group_Metadata_Link]
	@usergroupid int,
	@metadata1 varchar(20),
	@metadata2 varchar(20),
	@metadata3 varchar(20),
	@metadata4 varchar(20),
	@metadata5 varchar(20)
AS
begin

	-- Add the first default metadata
	if (( len(@metadata1) > 0 ) and ( (select count(*) from mySobek_DefaultMetadata where MetadataCode = @metadata1 ) = 1 ))
	begin
		-- Get the id for this one
		declare @metadata1_id int;
		select @metadata1_id = DefaultMetadataID from mySobek_DefaultMetadata where MetadataCode=@metadata1;

		-- Add this one as a default
		insert into mySobek_User_Group_DefaultMetadata_Link ( UserGroupID, DefaultMetadataID )
		values ( @usergroupid, @metadata1_id );
	end;

	-- Add the second default metadata
	if (( len(@metadata2) > 0 ) and ( (select count(*) from mySobek_DefaultMetadata where MetadataCode = @metadata2 ) = 1 ))
	begin
		-- Get the id for this one
		declare @metadata2_id int;
		select @metadata2_id = DefaultMetadataID from mySobek_DefaultMetadata where MetadataCode=@metadata2;

		-- Add this one as a default
		insert into mySobek_User_Group_DefaultMetadata_Link ( UserGroupID, DefaultMetadataID )
		values ( @usergroupid, @metadata2_id );
	end;

	-- Add the third detault metadata
	if (( len(@metadata3) > 0 ) and ( (select count(*) from mySobek_DefaultMetadata where MetadataCode = @metadata3 ) = 1 ))
	begin
		-- Get the id for this one
		declare @metadata3_id int;
		select @metadata3_id = DefaultMetadataID from mySobek_DefaultMetadata where MetadataCode=@metadata3;

		-- Add this one as a default
		insert into mySobek_User_Group_DefaultMetadata_Link ( UserGroupID, DefaultMetadataID )
		values ( @usergroupid, @metadata3_id );
	end;

	-- Add the fourth default metadata
	if (( len(@metadata4) > 0 ) and ( (select count(*) from mySobek_DefaultMetadata where MetadataCode = @metadata4 ) = 1 ))
	begin
		-- Get the id for this one
		declare @metadata4_id int;
		select @metadata4_id = DefaultMetadataID from mySobek_DefaultMetadata where MetadataCode=@metadata4;

		-- Add this one as a default
		insert into mySobek_User_Group_DefaultMetadata_Link ( UserGroupID, DefaultMetadataID )
		values ( @usergroupid, @metadata4_id );
	end;

	-- Add the fifth default metadata
	if (( len(@metadata5) > 0 ) and ( (select count(*) from mySobek_DefaultMetadata where MetadataCode = @metadata5 ) = 1 ))
	begin
		-- Get the id for this one
		declare @metadata5_id int;
		select @metadata5_id = DefaultMetadataID from mySobek_DefaultMetadata where MetadataCode=@metadata5;

		-- Add this one as a default
		insert into mySobek_User_Group_DefaultMetadata_Link ( UserGroupID, DefaultMetadataID )
		values ( @usergroupid, @metadata5_id );
	end;
end;
GO


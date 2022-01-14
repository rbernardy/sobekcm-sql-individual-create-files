USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[mySobek_Add_User_DefaultMetadata_Link]    Script Date: 1/13/2022 11:06:23 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


/****** Object:  StoredProcedure [dbo].[[mySobek_Add_User_DefaultMetadata_Link]]    Script Date: 12/20/2013 05:43:35 ******/
-- Add a link between a user and default metadata 
CREATE PROCEDURE [dbo].[mySobek_Add_User_DefaultMetadata_Link]
	@userid int,
	@metadata_default varchar(20),
	@metadata2 varchar(20),
	@metadata3 varchar(20),
	@metadata4 varchar(20),
	@metadata5 varchar(20)
AS
begin

	-- Add the default default metadata
	if (( len(@metadata_default) > 0 ) and ( (select count(*) from mySobek_DefaultMetadata where MetadataCode = @metadata_default ) = 1 ))
	begin
		-- Clear any previous default
		update mySobek_User_DefaultMetadata_Link set CurrentlySelected='false' where UserID = @userid;

		-- Get the id for this one
		declare @metadata_default_id int;
		select @metadata_default_id = DefaultMetadataID from mySobek_DefaultMetadata where MetadataCode=@metadata_default;

		-- Add this one as a default
		insert into mySobek_User_DefaultMetadata_Link ( UserID, DefaultMetadataID, CurrentlySelected )
		values ( @userid, @metadata_default_id, 'true' );
	end;

	-- Add the second default metadata
	if (( len(@metadata2) > 0 ) and ((select count(*) from mySobek_DefaultMetadata where MetadataCode = @metadata2 ) = 1 ))
	begin
		-- Get the id for this one
		declare @metadata2_id int;
		select @metadata2_id = DefaultMetadataID from mySobek_DefaultMetadata where MetadataCode=@metadata2;

		-- Add this one
		insert into mySobek_User_DefaultMetadata_Link ( UserID, DefaultMetadataID, CurrentlySelected )
		values ( @userid, @metadata2_id, 'false' );
	end;

	-- Add the third default metadata
	if (( len(@metadata3) > 0 ) and ((select count(*) from mySobek_DefaultMetadata where MetadataCode = @metadata3 ) = 1 ))
	begin
		-- Get the id for this one
		declare @metadata3_id int;
		select @metadata3_id = DefaultMetadataID from mySobek_DefaultMetadata where MetadataCode=@metadata3;

		-- Add this one
		insert into mySobek_User_DefaultMetadata_Link ( UserID, DefaultMetadataID, CurrentlySelected )
		values ( @userid, @metadata3_id, 'false' );
	end;

	-- Add the fourth default metadata
	if (( len(@metadata4) > 0 ) and ((select count(*) from mySobek_DefaultMetadata where MetadataCode = @metadata4 ) = 1 ))
	begin
		-- Get the id for this one
		declare @metadata4_id int;
		select @metadata4_id = DefaultMetadataID from mySobek_DefaultMetadata where MetadataCode=@metadata4;

		-- Add this one
		insert into mySobek_User_DefaultMetadata_Link ( UserID, DefaultMetadataID, CurrentlySelected )
		values ( @userid, @metadata4_id, 'false' );
	end;

	-- Add the fifth default metadata
	if (( len(@metadata5) > 0 ) and ((select count(*) from mySobek_DefaultMetadata where MetadataCode = @metadata5 ) = 1 ))
	begin
		-- Get the id for this one
		declare @metadata5_id int;
		select @metadata5_id = DefaultMetadataID from mySobek_DefaultMetadata where MetadataCode=@metadata5;

		-- Add this one
		insert into mySobek_User_DefaultMetadata_Link ( UserID, DefaultMetadataID, CurrentlySelected )
		values ( @userid, @metadata5_id, 'false' );
	end;
end;
GO


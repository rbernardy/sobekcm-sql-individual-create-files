USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[mySobek_Add_User_Aggregations_Link]    Script Date: 1/13/2022 10:59:57 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Procedure to add links between a user and item aggregations
CREATE PROCEDURE [dbo].[mySobek_Add_User_Aggregations_Link]
	@UserID int,
	@AggregationCode1 varchar(20),
	@canSelect1 bit,
	@canEditMetadata1 bit,
	@canEditBehaviors1 bit,
	@canPerformQc1 bit,
	@canUploadFiles1 bit,
	@canChangeVisibility1 bit,
	@canDelete1 bit,
	@isCurator1 bit,
	@onHomePage1 bit,
	@isAdmin1 bit,
	@AggregationCode2 varchar(20),
	@canSelect2 bit,
	@canEditMetadata2 bit,
	@canEditBehaviors2 bit,
	@canPerformQc2 bit,
	@canUploadFiles2 bit,
	@canChangeVisibility2 bit,
	@canDelete2 bit,
	@isCurator2 bit,
	@onHomePage2 bit,
	@isAdmin2 bit,
	@AggregationCode3 varchar(20),
	@canSelect3 bit,
	@canEditMetadata3 bit,
	@canEditBehaviors3 bit,
	@canPerformQc3 bit,
	@canUploadFiles3 bit,
	@canChangeVisibility3 bit,
	@canDelete3 bit,
	@isCurator3 bit,
	@onHomePage3 bit,
	@isAdmin3 bit
AS
BEGIN
	
	-- Add the first aggregation
	if (( len(@AggregationCode1) > 0 ) and ((select count(*) from SobekCM_Item_Aggregation where Code=@AggregationCode1 ) = 1 ))
	begin
		-- Get the id for this one
		declare @Aggregation1_Id int;
		select @Aggregation1_Id = AggregationID from SobekCM_Item_Aggregation where Code=@AggregationCode1;

		-- Is this user already linked to the aggreagtion?
		if (( select count(*) from mySobek_User_Edit_Aggregation where UserID=@UserID and AggregationID=@Aggregation1_Id ) = 0 )
		begin
			-- Add this one
			insert into mySobek_User_Edit_Aggregation ( UserID, AggregationID, CanSelect, CanEditMetadata, CanEditBehaviors, CanPerformQc, CanUploadFiles, CanChangeVisibility, CanDelete, IsCurator, OnHomePage, IsAdmin, CanEditItems )
			values ( @UserID, @Aggregation1_Id, @canSelect1, @canEditMetadata1, @canEditBehaviors1, @canPerformQc1, @canUploadFiles1, @canChangeVisibility1, @canDelete1, @isCurator1, @onHomePage1, @isAdmin1, @canEditMetadata1 );
		end
		else
		begin
			-- Update the existing link
			update mySobek_User_Edit_Aggregation
			set CanSelect=@canSelect1, CanEditMetadata=@canEditMetadata1, CanEditBehaviors=@canEditBehaviors1, CanPerformQc=@canPerformQc1, CanUploadFiles=@canUploadFiles1, CanChangeVisibility=@canChangeVisibility1, CanDelete=@canDelete1, IsCurator=@isCurator1, OnHomePage=@onHomePage1, IsAdmin=@isAdmin1, CanEditItems=@canEditMetadata1
			where UserID=@UserID and AggregationID=@Aggregation1_Id;
		end;		
	end;
	
	-- Add the second aggregation
	if (( len(@AggregationCode2) > 0 ) and ((select count(*) from SobekCM_Item_Aggregation where Code=@AggregationCode2 ) = 1 ))
	begin
		-- Get the id for this one
		declare @Aggregation2_Id int;
		select @Aggregation2_Id = AggregationID from SobekCM_Item_Aggregation where Code=@AggregationCode2;

		-- Is this user already linked to the aggreagtion?
		if (( select count(*) from mySobek_User_Edit_Aggregation where UserID=@UserID and AggregationID=@Aggregation2_Id ) = 0 )
		begin
			-- Add this one
			insert into mySobek_User_Edit_Aggregation ( UserID, AggregationID, CanSelect, CanEditMetadata, CanEditBehaviors, CanPerformQc, CanUploadFiles, CanChangeVisibility, CanDelete, IsCurator, OnHomePage, IsAdmin, CanEditItems )
			values ( @UserID, @Aggregation2_Id, @canSelect2, @canEditMetadata2, @canEditBehaviors2, @canPerformQc2, @canUploadFiles2, @canChangeVisibility2, @canDelete2, @isCurator2, @onHomePage2, @isAdmin2, @canEditMetadata2 );
		end
		else
		begin
			-- Update the existing link
			update mySobek_User_Edit_Aggregation
			set CanSelect=@canSelect2, CanEditMetadata=@canEditMetadata2, CanEditBehaviors=@canEditBehaviors2, CanPerformQc=@canPerformQc2, CanUploadFiles=@canUploadFiles2, CanChangeVisibility=@canChangeVisibility2, CanDelete=@canDelete2, IsCurator=@isCurator2, OnHomePage=@onHomePage2, IsAdmin=@isAdmin2, CanEditItems=@canEditMetadata2
			where UserID=@UserID and AggregationID=@Aggregation2_Id;
		end;	
	end;

	-- Add the third aggregation
	if (( len(@AggregationCode3) > 0 ) and ((select count(*) from SobekCM_Item_Aggregation where Code=@AggregationCode3 ) = 1 ))
	begin
		-- Get the id for this one
		declare @Aggregation3_Id int;
		select @Aggregation3_Id = AggregationID from SobekCM_Item_Aggregation where Code=@AggregationCode3;

		-- Is this user already linked to the aggreagtion?
		if (( select count(*) from mySobek_User_Edit_Aggregation where UserID=@UserID and AggregationID=@Aggregation3_Id ) = 0 )
		begin
			-- Add this one
			insert into mySobek_User_Edit_Aggregation ( UserID, AggregationID, CanSelect, CanEditMetadata, CanEditBehaviors, CanPerformQc, CanUploadFiles, CanChangeVisibility, CanDelete, IsCurator, OnHomePage, IsAdmin, CanEditItems )
			values ( @UserID, @Aggregation3_Id, @canSelect3, @canEditMetadata3, @canEditBehaviors3, @canPerformQc3, @canUploadFiles3, @canChangeVisibility3, @canDelete3, @isCurator3, @onHomePage3, @isAdmin3, @canEditMetadata3 );
		end
		else
		begin
			-- Update the existing link
			update mySobek_User_Edit_Aggregation
			set CanSelect=@canSelect3, CanEditMetadata=@canEditMetadata3, CanEditBehaviors=@canEditBehaviors3, CanPerformQc=@canPerformQc3, CanUploadFiles=@canUploadFiles3, CanChangeVisibility=@canChangeVisibility3, CanDelete=@canDelete3, IsCurator=@isCurator3, OnHomePage=@onHomePage3, IsAdmin=@isAdmin3, CanEditItems=@canEditMetadata3
			where UserID=@UserID and AggregationID=@Aggregation3_Id;
		end;	
	end;
END;
GO


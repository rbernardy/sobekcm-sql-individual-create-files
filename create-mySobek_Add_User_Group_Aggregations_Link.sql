USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[mySobek_Add_User_Group_Aggregations_Link]    Script Date: 1/17/2022 5:31:53 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Procedure to add links between a user group and item aggregations
-- NOTE: The OnHomePage values are NOT used, but are included to keep this
--       signature the same as the single user aggregation link procedure
--       reducing overhead for maintenance
CREATE PROCEDURE [dbo].[mySobek_Add_User_Group_Aggregations_Link]
	@UserGroupID int,
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

		-- Add this one
		insert into mySobek_User_Group_Edit_Aggregation ( UserGroupID, AggregationID, CanSelect, CanEditMetadata, CanEditBehaviors, CanPerformQc, CanUploadFiles, CanChangeVisibility, CanDelete, IsCurator, CanEditItems, IsAdmin )
		values ( @UserGroupID, @Aggregation1_Id, @canSelect1, @canEditMetadata1, @canEditBehaviors1, @canPerformQc1, @canUploadFiles1, @canChangeVisibility1, @canDelete1, @isCurator1, @canEditMetadata1, @isAdmin1 );
	end;
	
	-- Add the second aggregation
	if (( len(@AggregationCode2) > 0 ) and ((select count(*) from SobekCM_Item_Aggregation where Code=@AggregationCode2 ) = 1 ))
	begin
		-- Get the id for this one
		declare @Aggregation2_Id int;
		select @Aggregation2_Id = AggregationID from SobekCM_Item_Aggregation where Code=@AggregationCode2;

		-- Add this one
		insert into mySobek_User_Group_Edit_Aggregation ( UserGroupID, AggregationID, CanSelect, CanEditMetadata, CanEditBehaviors, CanPerformQc, CanUploadFiles, CanChangeVisibility, CanDelete, IsCurator, CanEditItems, IsAdmin )
		values ( @UserGroupID, @Aggregation2_Id, @canSelect2, @canEditMetadata2, @canEditBehaviors2, @canPerformQc2, @canUploadFiles2, @canChangeVisibility2, @canDelete2, @isCurator2, @canEditMetadata2, @isAdmin2 );
	end;
	
	-- Add the third aggregation
	if (( len(@AggregationCode3) > 0 ) and ((select count(*) from SobekCM_Item_Aggregation where Code=@AggregationCode3 ) = 1 ))
	begin
		-- Get the id for this one
		declare @Aggregation3_Id int;
		select @Aggregation3_Id = AggregationID from SobekCM_Item_Aggregation where Code=@AggregationCode3;

		-- Add this one
		insert into mySobek_User_Group_Edit_Aggregation ( UserGroupID, AggregationID, CanSelect, CanEditMetadata, CanEditBehaviors, CanPerformQc, CanUploadFiles, CanChangeVisibility, CanDelete, IsCurator, CanEditItems, IsAdmin )
		values ( @UserGroupID, @Aggregation3_Id, @canSelect3, @canEditMetadata3, @canEditBehaviors3, @canPerformQc3, @canUploadFiles3, @canChangeVisibility3, @canDelete3, @isCurator3, @canEditMetadata3, @isAdmin3 );
	end;
END;
GO


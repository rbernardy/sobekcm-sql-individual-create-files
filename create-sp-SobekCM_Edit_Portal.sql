USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Edit_Portal]    Script Date: 2/9/2022 7:53:35 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Procedure to edit an existing URL portal or saving a new URL portal
CREATE PROCEDURE [dbo].[SobekCM_Edit_Portal]
	@PortalID int,
	@Base_URL nvarchar(150),
	@isActive bit,
	@isDefault bit,
	@Abbreviation nvarchar(10),
	@Name nvarchar(250),
	@Default_Aggregation nvarchar(20),
	@Base_PURL nvarchar(150),
	@Default_Web_Skin nvarchar(20),
	@NewID int output
AS
BEGIN TRANSACTION

	-- Is this a new portal?
	if (( select COUNT(*) from SobekCM_Portal_URL where PortalID=@PortalID ) = 0 )
	begin	
		-- Insert new portal
		insert into SobekCM_Portal_URL ( Abbreviation, isActive, isDefault, Name, Base_URL, Base_PURL )
		values ( @Abbreviation, @isActive, @isDefault, @Name, @Base_URL, @Base_PURL );
		
		-- Save the new id
		set @NewID = @@Identity;	
	end
	else
	begin
		-- update existing portal
		update SobekCM_Portal_URL
		set Abbreviation=@Abbreviation, isActive=@isActive, isDefault=@isDefault, Name=@Name, Base_URL=@Base_URL, Base_PURL=@Base_PURL
		where PortalID = @PortalID;
		
		-- Just return the same id
		set @NewID = @PortalID;	
	end;
	
	-- Clear any default aggregations and web skins
	delete from SobekCM_Portal_Item_Aggregation_Link where PortalID=@NewID;
	delete from SobekCM_Portal_Web_Skin_Link where PortalID=@NewID;

	-- Add the default aggregation, if one is chosen
	if ( LEN(isnull(@Default_Aggregation, '')) > 0 )
	begin
		-- Does this aggregation exists
		if (( select COUNT(*) from SobekCM_Item_Aggregation where Code=@Default_Aggregation ) = 1 )
		begin
			declare @aggrid int;
			select @aggrid=AggregationID from SobekCM_Item_Aggregation where Code=@Default_Aggregation;
			
			insert into SobekCM_Portal_Item_Aggregation_Link ( PortalID, AggregationID, isDefault )
			values ( @NewID, @aggrid, 'true' );		
		end;	
	end;	
	
	-- Add the web skin, if one is chosen
	if ( LEN(isnull(@Default_Web_Skin, '')) > 0 )
	begin
		-- Does this aggregation exists
		if (( select COUNT(*) from SobekCM_Web_Skin where WebSkinCode=@Default_Web_Skin ) = 1 )
		begin
			declare @skinid int;
			select @skinid=WebSkinID from SobekCM_Web_Skin where WebSkinCode=@Default_Web_Skin;
			
			insert into SobekCM_Portal_Web_Skin_Link ( PortalID, WebSkinID, isDefault )
			values ( @NewID, @skinid, 'true' );		
		end;	
	end;	
COMMIT TRANSACTION;
GO


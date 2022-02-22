USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Metadata_Save]    Script Date: 2/21/2022 9:14:43 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



-- Save multiple pieces of metadata to the database for a single item
-- This calls SobekCM_Metadata_Save_Single which includes the mapping
-- from the textual type of metadata to the correct type id
CREATE PROCEDURE [dbo].[SobekCM_Metadata_Save]
	@itemid int,
	@metadata_type1 varchar(100),
	@metadata_value1 nvarchar(max),
	@metadata_type2 varchar(100),
	@metadata_value2 nvarchar(max),
	@metadata_type3 varchar(100),
	@metadata_value3 nvarchar(max),
	@metadata_type4 varchar(100),
	@metadata_value4 nvarchar(max),
	@metadata_type5 varchar(100),
	@metadata_value5 nvarchar(max),
	@metadata_type6 varchar(100),
	@metadata_value6 nvarchar(max),
	@metadata_type7 varchar(100),
	@metadata_value7 nvarchar(max),
	@metadata_type8 varchar(100),
	@metadata_value8 nvarchar(max),
	@metadata_type9 varchar(100),
	@metadata_value9 nvarchar(max),
	@metadata_type10 varchar(100),
	@metadata_value10 nvarchar(max)
AS
BEGIN

	-- Try to add the each piece of metadata
	if ( len( isnull(@metadata_value1,'')) > 0 )
		exec SobekCM_Metadata_Save_Single @itemid, @metadata_type1, @metadata_value1;
	if ( len( isnull(@metadata_value2,'')) > 0 )
		exec SobekCM_Metadata_Save_Single @itemid, @metadata_type2, @metadata_value2;
	if ( len( isnull(@metadata_value3,'')) > 0 )
		exec SobekCM_Metadata_Save_Single @itemid, @metadata_type3, @metadata_value3;
	if ( len( isnull(@metadata_value4,'')) > 0 )
		exec SobekCM_Metadata_Save_Single @itemid, @metadata_type4, @metadata_value4;
	if ( len( isnull(@metadata_value5,'')) > 0 )
		exec SobekCM_Metadata_Save_Single @itemid, @metadata_type5, @metadata_value5;
	if ( len( isnull(@metadata_value6,'')) > 0 )
		exec SobekCM_Metadata_Save_Single @itemid, @metadata_type6, @metadata_value6;
	if ( len( isnull(@metadata_value7,'')) > 0 )
		exec SobekCM_Metadata_Save_Single @itemid, @metadata_type7, @metadata_value7;
	if ( len( isnull(@metadata_value8,'')) > 0 )
		exec SobekCM_Metadata_Save_Single @itemid, @metadata_type8, @metadata_value8;
	if ( len( isnull(@metadata_value9,'')) > 0 )
		exec SobekCM_Metadata_Save_Single @itemid, @metadata_type9, @metadata_value9;
	if ( len( isnull(@metadata_value10,'')) > 0 )
		exec SobekCM_Metadata_Save_Single @itemid, @metadata_type10, @metadata_value10;

END;
GO


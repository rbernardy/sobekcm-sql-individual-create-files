USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Save_Item_Aggregation_Facets]    Script Date: 2/23/2022 8:19:25 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



-- Stored procedure to save the item aggregation facet information
CREATE PROCEDURE [dbo].[SobekCM_Save_Item_Aggregation_Facets]
	@code varchar(20),
	@facet1_type varchar(100),
	@facet1_display varchar(100),
	@facet2_type varchar(100),
	@facet2_display varchar(100),
	@facet3_type varchar(100),
	@facet3_display varchar(100),
	@facet4_type varchar(100),
	@facet4_display varchar(100),
	@facet5_type varchar(100),
	@facet5_display varchar(100),
	@facet6_type varchar(100),
	@facet6_display varchar(100),
	@facet7_type varchar(100),
	@facet7_display varchar(100),
	@facet8_type varchar(100),
	@facet8_display varchar(100)
AS
begin transaction

	-- Only continue if there is a match on the aggregation code
	if ( exists ( select 1 from SobekCM_Item_Aggregation where Code = @code ))
	begin
		declare @id int;
		set @id = ( select AggregationID from SobekCM_Item_Aggregation where Code = @code );

		-- Keep list of any existing facets
		declare @existing_facets table(MetadataTypeID int primary key, ExTerm varchar(100), ExOrder int, ExOptions varchar(2000), StillExists bit );
		insert into @existing_facets 
		select MetadataTypeID, OverrideFacetTerm, FacetOrder, FacetOptions, 'false'
		from SobekCM_Item_Aggregation_Facets V
		where ( V.AggregationID=@id );

		-- Add the FIRST facet
		if (( len(@facet1_type) > 0 ) and ( exists ( select 1 from SobekCM_Metadata_Types where MetadataName=@facet1_type or SobekCode=@facet1_type)))
		begin
			declare @facet1_id int;
			set @facet1_id = ( select MetadataTypeID from SobekCM_Metadata_Types where MetadataName=@facet1_type or SobekCode=@facet1_type );

			-- If the standard facet term is the same as what came in, just clear it
			declare @facet1_standard_display varchar(100);
			set @facet1_standard_display = ( select FacetTerm from SobekCM_Metadata_Types where MetadataTypeID=@facet1_id);
			if ( @facet1_standard_display = @facet1_display ) set @facet1_display = null;

			-- Does this facet already exist?
			if ( not exists ( select 1 from @existing_facets where MetadataTypeID=@facet1_id ))
			begin
				-- Doesn't exist, so add it
				insert into SobekCM_Item_Aggregation_Facets( AggregationID, MetadataTypeID, OverrideFacetTerm, FacetOrder, FacetOptions )
				values ( @id, @facet1_id, @facet1_display, 1, '' );
			end
			else
			begin
				-- It did exist, so mark it in the temp table
				update @existing_facets	
				set StillExists='true'
				where MetadataTypeID=@facet1_id;

				-- Order and display term may have changed though
				update SobekCM_Item_Aggregation_Facets 
				set FacetOrder=1, OverrideFacetTerm=@facet1_display
				where ( MetadataTypeID = @facet1_id )
				  and ( AggregationID = @id );
			end;
		end;

		-- Add the SECOND facet
		if (( len(@facet2_type) > 0 ) and ( exists ( select 1 from SobekCM_Metadata_Types where MetadataName=@facet2_type or SobekCode=@facet2_type)))
		begin
			declare @facet2_id int;
			set @facet2_id = ( select MetadataTypeID from SobekCM_Metadata_Types where MetadataName=@facet2_type or SobekCode=@facet2_type );

			-- If the standard facet term is the same as what came in, just clear it
			declare @facet2_standard_display varchar(100);
			set @facet2_standard_display = ( select FacetTerm from SobekCM_Metadata_Types where MetadataTypeID=@facet2_id);
			if ( @facet2_standard_display = @facet2_display ) set @facet2_display = null;

			-- Does this facet already exist?
			if ( not exists ( select 1 from @existing_facets where MetadataTypeID=@facet2_id ))
			begin
				-- Doesn't exist, so add it
				insert into SobekCM_Item_Aggregation_Facets( AggregationID, MetadataTypeID, OverrideFacetTerm, FacetOrder, FacetOptions )
				values ( @id, @facet2_id, @facet2_display, 2, '' );
			end
			else
			begin
				-- It did exist, so mark it in the temp table
				update @existing_facets	
				set StillExists='true'
				where MetadataTypeID=@facet2_id;

				-- Order and display term may have changed though
				update SobekCM_Item_Aggregation_Facets 
				set FacetOrder=2, OverrideFacetTerm=@facet2_display
				where ( MetadataTypeID = @facet2_id )
				  and ( AggregationID = @id );
			end;
		end;

		-- Add the THIRD facet
		if (( len(@facet3_type ) > 0 ) and ( exists ( select 1 from SobekCM_Metadata_Types where MetadataName=@facet3_type or SobekCode=@facet3_type)))
		begin
			declare @facet3_id int;
			set @facet3_id = ( select MetadataTypeID from SobekCM_Metadata_Types where MetadataName=@facet3_type or SobekCode=@facet3_type );

			-- If the standard facet term is the same as what came in, just clear it
			declare @facet3_standard_display varchar(100);
			set @facet3_standard_display = ( select FacetTerm from SobekCM_Metadata_Types where MetadataTypeID=@facet3_id);
			if ( @facet3_standard_display = @facet3_display ) set @facet3_display = null;

			-- Does this facet already exist?
			if ( not exists ( select 1 from @existing_facets where MetadataTypeID=@facet3_id ))
			begin
				-- Doesn't exist, so add it
				insert into SobekCM_Item_Aggregation_Facets( AggregationID, MetadataTypeID, OverrideFacetTerm, FacetOrder, FacetOptions )
				values ( @id, @facet3_id, @facet3_display, 3, '' );
			end
			else
			begin
				-- It did exist, so mark it in the temp table
				update @existing_facets	
				set StillExists='true'
				where MetadataTypeID=@facet3_id;

				-- Order and display term may have changed though
				update SobekCM_Item_Aggregation_Facets 
				set FacetOrder=3, OverrideFacetTerm=@facet3_display
				where ( MetadataTypeID = @facet3_id )
				  and ( AggregationID = @id );
			end;
		end;
		
		-- Add the FOURTH facet
		if (( len(@facet1_type) > 0 ) and ( exists ( select 1 from SobekCM_Metadata_Types where MetadataName=@facet4_type or SobekCode=@facet4_type)))
		begin
			declare @facet4_id int;
			set @facet4_id = ( select MetadataTypeID from SobekCM_Metadata_Types where MetadataName=@facet4_type or SobekCode=@facet4_type );

			-- If the standard facet term is the same as what came in, just clear it
			declare @facet4_standard_display varchar(100);
			set @facet4_standard_display = ( select FacetTerm from SobekCM_Metadata_Types where MetadataTypeID=@facet4_id);
			if ( @facet4_standard_display = @facet4_display ) set @facet4_display = null;

			-- Does this facet already exist?
			if ( not exists ( select 1 from @existing_facets where MetadataTypeID=@facet4_id ))
			begin
				-- Doesn't exist, so add it
				insert into SobekCM_Item_Aggregation_Facets( AggregationID, MetadataTypeID, OverrideFacetTerm, FacetOrder, FacetOptions )
				values ( @id, @facet4_id, @facet4_display, 4, '' );
			end
			else
			begin
				-- It did exist, so mark it in the temp table
				update @existing_facets	
				set StillExists='true'
				where MetadataTypeID=@facet4_id;

				-- Order and display term may have changed though
				update SobekCM_Item_Aggregation_Facets 
				set FacetOrder=4, OverrideFacetTerm=@facet4_display
				where ( MetadataTypeID = @facet4_id )
				  and ( AggregationID = @id );
			end;
		end;

		-- Add the FIFTH facet
		if (( len(@facet5_type) > 0 ) and ( exists ( select 1 from SobekCM_Metadata_Types where MetadataName=@facet5_type or SobekCode=@facet5_type)))
		begin
			declare @facet5_id int;
			set @facet5_id = ( select MetadataTypeID from SobekCM_Metadata_Types where MetadataName=@facet5_type or SobekCode=@facet5_type );

			-- If the standard facet term is the same as what came in, just clear it
			declare @facet5_standard_display varchar(100);
			set @facet5_standard_display = ( select FacetTerm from SobekCM_Metadata_Types where MetadataTypeID=@facet5_id);
			if ( @facet5_standard_display = @facet5_display ) set @facet5_display = null;

			-- Does this facet already exist?
			if ( not exists ( select 1 from @existing_facets where MetadataTypeID=@facet5_id ))
			begin
				-- Doesn't exist, so add it
				insert into SobekCM_Item_Aggregation_Facets( AggregationID, MetadataTypeID, OverrideFacetTerm, FacetOrder, FacetOptions )
				values ( @id, @facet5_id, @facet5_display, 5, '' );
			end
			else
			begin
				-- It did exist, so mark it in the temp table
				update @existing_facets	
				set StillExists='true'
				where MetadataTypeID=@facet5_id;

				-- Order and display term may have changed though
				update SobekCM_Item_Aggregation_Facets 
				set FacetOrder=5, OverrideFacetTerm=@facet5_display
				where ( MetadataTypeID = @facet5_id )
				  and ( AggregationID = @id );
			end;
		end;

		-- Add the SIXTH facet
		if (( len(@facet6_type) > 0 ) and ( exists ( select 1 from SobekCM_Metadata_Types where MetadataName=@facet6_type or SobekCode=@facet6_type)))
		begin
			declare @facet6_id int;
			set @facet6_id = ( select MetadataTypeID from SobekCM_Metadata_Types where MetadataName=@facet6_type or SobekCode=@facet6_type );

			-- If the standard facet term is the same as what came in, just clear it
			declare @facet6_standard_display varchar(100);
			set @facet6_standard_display = ( select FacetTerm from SobekCM_Metadata_Types where MetadataTypeID=@facet6_id);
			if ( @facet6_standard_display = @facet6_display ) set @facet6_display = null;

			-- Does this facet already exist?
			if ( not exists ( select 1 from @existing_facets where MetadataTypeID=@facet6_id ))
			begin
				-- Doesn't exist, so add it
				insert into SobekCM_Item_Aggregation_Facets( AggregationID, MetadataTypeID, OverrideFacetTerm, FacetOrder, FacetOptions )
				values ( @id, @facet6_id, @facet6_display, 6, '' );
			end
			else
			begin
				-- It did exist, so mark it in the temp table
				update @existing_facets	
				set StillExists='true'
				where MetadataTypeID=@facet1_id;

				-- Order and display term may have changed though
				update SobekCM_Item_Aggregation_Facets 
				set FacetOrder=6, OverrideFacetTerm=@facet6_display
				where ( MetadataTypeID = @facet6_id )
				  and ( AggregationID = @id );
			end;
		end;

		-- Add the SEVENTH facet
		if (( len(@facet7_type) > 0 ) and ( exists ( select 1 from SobekCM_Metadata_Types where MetadataName=@facet7_type or SobekCode=@facet7_type)))
		begin
			declare @facet7_id int;
			set @facet7_id = ( select MetadataTypeID from SobekCM_Metadata_Types where MetadataName=@facet7_type or SobekCode=@facet7_type );

			-- If the standard facet term is the same as what came in, just clear it
			declare @facet7_standard_display varchar(100);
			set @facet7_standard_display = ( select FacetTerm from SobekCM_Metadata_Types where MetadataTypeID=@facet7_id);
			if ( @facet7_standard_display = @facet7_display ) set @facet7_display = null;

			-- Does this facet already exist?
			if ( not exists ( select 1 from @existing_facets where MetadataTypeID=@facet7_id ))
			begin
				-- Doesn't exist, so add it
				insert into SobekCM_Item_Aggregation_Facets( AggregationID, MetadataTypeID, OverrideFacetTerm, FacetOrder, FacetOptions )
				values ( @id, @facet7_id, @facet7_display, 7, '' );
			end
			else
			begin
				-- It did exist, so mark it in the temp table
				update @existing_facets	
				set StillExists='true'
				where MetadataTypeID=@facet7_id;

				-- Order and display term may have changed though
				update SobekCM_Item_Aggregation_Facets 
				set FacetOrder=1, OverrideFacetTerm=@facet7_display
				where ( MetadataTypeID = @facet7_id )
				  and ( AggregationID = @id );
			end;
		end;

		-- Add the EIGHTH facet
		if (( len(@facet8_type) > 0 ) and ( exists ( select 1 from SobekCM_Metadata_Types where MetadataName=@facet8_type or SobekCode=@facet8_type)))
		begin
			declare @facet8_id int;
			set @facet8_id = ( select MetadataTypeID from SobekCM_Metadata_Types where MetadataName=@facet8_type or SobekCode=@facet8_type);

			-- If the standard facet term is the same as what came in, just clear it
			declare @facet8_standard_display varchar(100);
			set @facet8_standard_display = ( select FacetTerm from SobekCM_Metadata_Types where MetadataTypeID=@facet8_id);
			if ( @facet8_standard_display = @facet8_display ) set @facet8_display = null;

			-- Does this facet already exist?
			if ( not exists ( select 1 from @existing_facets where MetadataTypeID=@facet8_id ))
			begin
				-- Doesn't exist, so add it
				insert into SobekCM_Item_Aggregation_Facets( AggregationID, MetadataTypeID, OverrideFacetTerm, FacetOrder, FacetOptions )
				values ( @id, @facet8_id, @facet8_display, 8, '' );
			end
			else
			begin
				-- It did exist, so mark it in the temp table
				update @existing_facets	
				set StillExists='true'
				where MetadataTypeID=@facet8_id;

				-- Order and display term may have changed though
				update SobekCM_Item_Aggregation_Facets 
				set FacetOrder=8, OverrideFacetTerm=@facet8_display
				where ( MetadataTypeID = @facet8_id )
				  and ( AggregationID = @id );
			end;
		end;

		-- Now, remove any 
		if (( select count(*) from @existing_facets ) > 0 )
		begin
			-- First delete the fields
			delete from SobekCM_Item_Aggregation_Facets
			where MetadataTypeID in ( select MetadataTypeID from @existing_facets V where V.StillExists='false')
			  and AggregationID = @id;
		end;
	end;

commit transaction;
GO


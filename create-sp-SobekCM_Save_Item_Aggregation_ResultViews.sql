USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Save_Item_Aggregation_ResultViews]    Script Date: 2/23/2022 8:33:43 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Stored procedure to save the basic item aggregation information
CREATE PROCEDURE [dbo].[SobekCM_Save_Item_Aggregation_ResultViews]
	@code varchar(20),
	@results1 varchar(50),
	@results2 varchar(50),
	@results3 varchar(50),
	@results4 varchar(50),
	@results5 varchar(50),
	@results6 varchar(50),
	@results7 varchar(50),
	@results8 varchar(50),
	@results9 varchar(50),
	@results10 varchar(50),
	@default varchar(50)
AS
begin transaction

	-- Only continue if there is a match on the aggregation code
	if ( exists ( select 1 from SobekCM_Item_Aggregation where Code = @code ))
	begin
		declare @id int;
		set @id = ( select AggregationID from SobekCM_Item_Aggregation where Code = @code );

		-- Keep list of any existing view
		declare @existing_views table(ResultTypeId int primary key, AggrSpecificId int, StillExisting bit );
		insert into @existing_views 
		select ItemAggregationResultTypeID, ItemAggregationResultID, 'false'
		from SobekCM_Item_Aggregation_Result_Views V
		where ( V.AggregationID=@id );

		-- Add the FIRST results view
		if (( len(@results1) > 0 ) and ( exists ( select 1 from SobekCM_Item_Aggregation_Result_Types where ResultType=@results1)))
		begin
			declare @results1_id int;
			set @results1_id = ( select ItemAggregationResultTypeID from SobekCM_Item_Aggregation_Result_Types where ResultType=@results1 );

			-- Does this result view already exist?
			if ( not exists ( select 1 from SobekCM_Item_Aggregation_Result_Views where AggregationID=@id and ItemAggregationResultTypeID=@results1_id ))
			begin
				-- Doesn't exist, so add it
				insert into SobekCM_Item_Aggregation_Result_Views ( AggregationID, ItemAggregationResultTypeID, DefaultView )
				values ( @id, @results1_id, 'false' );
			end
			else
			begin
				-- It did exist, so mark it in the temp table
				update @existing_views
				set StillExisting='true'
				where ResultTypeId=@results1_id;
			end;
		end;

		-- Add the SECOND results view
		if (( len(@results2) > 0 ) and ( exists ( select 1 from SobekCM_Item_Aggregation_Result_Types where ResultType=@results2)))
		begin
			declare @results2_id int;
			set @results2_id = ( select ItemAggregationResultTypeID from SobekCM_Item_Aggregation_Result_Types where ResultType=@results2 );

			-- Does this result view already exist?
			if ( not exists ( select 1 from SobekCM_Item_Aggregation_Result_Views where AggregationID=@id and ItemAggregationResultTypeID=@results2_id ))
			begin
				-- Doesn't exist, so add it
				insert into SobekCM_Item_Aggregation_Result_Views ( AggregationID, ItemAggregationResultTypeID, DefaultView )
				values ( @id, @results2_id, 'false' );
			end
			else
			begin
				-- It did exist, so mark it in the temp table
				update @existing_views
				set StillExisting='true'
				where ResultTypeId=@results2_id;
			end;
		end;

		-- Add the THIRD results view
		if (( len(@results3) > 0 ) and ( exists ( select 1 from SobekCM_Item_Aggregation_Result_Types where ResultType=@results3)))
		begin
			declare @results3_id int;
			set @results3_id = ( select ItemAggregationResultTypeID from SobekCM_Item_Aggregation_Result_Types where ResultType=@results3 );

			-- Does this result view already exist?
			if ( not exists ( select 1 from SobekCM_Item_Aggregation_Result_Views where AggregationID=@id and ItemAggregationResultTypeID=@results3_id ))
			begin
				-- Doesn't exist, so add it
				insert into SobekCM_Item_Aggregation_Result_Views ( AggregationID, ItemAggregationResultTypeID, DefaultView )
				values ( @id, @results3_id, 'false' );
			end
			else
			begin
				-- It did exist, so mark it in the temp table
				update @existing_views
				set StillExisting='true'
				where ResultTypeId=@results3_id;
			end;
		end;

		-- Add the FOURTH results view
		if (( len(@results4) > 0 ) and ( exists ( select 1 from SobekCM_Item_Aggregation_Result_Types where ResultType=@results4)))
		begin
			declare @results4_id int;
			set @results4_id = ( select ItemAggregationResultTypeID from SobekCM_Item_Aggregation_Result_Types where ResultType=@results4 );

			-- Does this result view already exist?
			if ( not exists ( select 1 from SobekCM_Item_Aggregation_Result_Views where AggregationID=@id and ItemAggregationResultTypeID=@results4_id ))
			begin
				-- Doesn't exist, so add it
				insert into SobekCM_Item_Aggregation_Result_Views ( AggregationID, ItemAggregationResultTypeID, DefaultView )
				values ( @id, @results4_id, 'false' );
			end
			else
			begin
				-- It did exist, so mark it in the temp table
				update @existing_views
				set StillExisting='true'
				where ResultTypeId=@results4_id;
			end;
		end;

		-- Add the FIFTH results view
		if (( len(@results5) > 0 ) and ( exists ( select 1 from SobekCM_Item_Aggregation_Result_Types where ResultType=@results5)))
		begin
			declare @results5_id int;
			set @results5_id = ( select ItemAggregationResultTypeID from SobekCM_Item_Aggregation_Result_Types where ResultType=@results5 );

			-- Does this result view already exist?
			if ( not exists ( select 1 from SobekCM_Item_Aggregation_Result_Views where AggregationID=@id and ItemAggregationResultTypeID=@results5_id ))
			begin
				-- Doesn't exist, so add it
				insert into SobekCM_Item_Aggregation_Result_Views ( AggregationID, ItemAggregationResultTypeID, DefaultView )
				values ( @id, @results5_id, 'false' );
			end
			else
			begin
				-- It did exist, so mark it in the temp table
				update @existing_views
				set StillExisting='true'
				where ResultTypeId=@results5_id;
			end;
		end;

		-- Add the SIXTH results view
		if (( len(@results6) > 0 ) and ( exists ( select 1 from SobekCM_Item_Aggregation_Result_Types where ResultType=@results6)))
		begin
			declare @results6_id int;
			set @results6_id = ( select ItemAggregationResultTypeID from SobekCM_Item_Aggregation_Result_Types where ResultType=@results6 );

			-- Does this result view already exist?
			if ( not exists ( select 1 from SobekCM_Item_Aggregation_Result_Views where AggregationID=@id and ItemAggregationResultTypeID=@results6_id ))
			begin
				-- Doesn't exist, so add it
				insert into SobekCM_Item_Aggregation_Result_Views ( AggregationID, ItemAggregationResultTypeID, DefaultView )
				values ( @id, @results6_id, 'false' );
			end
			else
			begin
				-- It did exist, so mark it in the temp table
				update @existing_views
				set StillExisting='true'
				where ResultTypeId=@results6_id;
			end;
		end;

		-- Add the SEVENTH results view
		if (( len(@results7) > 0 ) and ( exists ( select 1 from SobekCM_Item_Aggregation_Result_Types where ResultType=@results7)))
		begin
			declare @results7_id int;
			set @results7_id = ( select ItemAggregationResultTypeID from SobekCM_Item_Aggregation_Result_Types where ResultType=@results7 );

			-- Does this result view already exist?
			if ( not exists ( select 1 from SobekCM_Item_Aggregation_Result_Views where AggregationID=@id and ItemAggregationResultTypeID=@results7_id ))
			begin
				-- Doesn't exist, so add it
				insert into SobekCM_Item_Aggregation_Result_Views ( AggregationID, ItemAggregationResultTypeID, DefaultView )
				values ( @id, @results7_id, 'false' );
			end
			else
			begin
				-- It did exist, so mark it in the temp table
				update @existing_views
				set StillExisting='true'
				where ResultTypeId=@results7_id;
			end;
		end;

		-- Add the EIGHTH results view
		if (( len(@results8) > 0 ) and ( exists ( select 1 from SobekCM_Item_Aggregation_Result_Types where ResultType=@results8)))
		begin
			declare @results8_id int;
			set @results8_id = ( select ItemAggregationResultTypeID from SobekCM_Item_Aggregation_Result_Types where ResultType=@results8 );

			-- Does this result view already exist?
			if ( not exists ( select 1 from SobekCM_Item_Aggregation_Result_Views where AggregationID=@id and ItemAggregationResultTypeID=@results8_id ))
			begin
				-- Doesn't exist, so add it
				insert into SobekCM_Item_Aggregation_Result_Views ( AggregationID, ItemAggregationResultTypeID, DefaultView )
				values ( @id, @results8_id, 'false' );
			end
			else
			begin
				-- It did exist, so mark it in the temp table
				update @existing_views
				set StillExisting='true'
				where ResultTypeId=@results8_id;
			end;
		end;

		-- Add the NINTH results view
		if (( len(@results9) > 0 ) and ( exists ( select 1 from SobekCM_Item_Aggregation_Result_Types where ResultType=@results9)))
		begin
			declare @results9_id int;
			set @results9_id = ( select ItemAggregationResultTypeID from SobekCM_Item_Aggregation_Result_Types where ResultType=@results9 );

			-- Does this result view already exist?
			if ( not exists ( select 1 from SobekCM_Item_Aggregation_Result_Views where AggregationID=@id and ItemAggregationResultTypeID=@results9_id ))
			begin
				-- Doesn't exist, so add it
				insert into SobekCM_Item_Aggregation_Result_Views ( AggregationID, ItemAggregationResultTypeID, DefaultView )
				values ( @id, @results9_id, 'false' );
			end
			else
			begin
				-- It did exist, so mark it in the temp table
				update @existing_views
				set StillExisting='true'
				where ResultTypeId=@results9_id;
			end;
		end;

		-- Add the TENTH results view
		if (( len(@results10) > 0 ) and ( exists ( select 1 from SobekCM_Item_Aggregation_Result_Types where ResultType=@results10)))
		begin
			declare @results10_id int;
			set @results10_id = ( select ItemAggregationResultTypeID from SobekCM_Item_Aggregation_Result_Types where ResultType=@results10 );

			-- Does this result view already exist?
			if ( not exists ( select 1 from SobekCM_Item_Aggregation_Result_Views where AggregationID=@id and ItemAggregationResultTypeID=@results10_id ))
			begin
				-- Doesn't exist, so add it
				insert into SobekCM_Item_Aggregation_Result_Views ( AggregationID, ItemAggregationResultTypeID, DefaultView )
				values ( @id, @results10_id, 'false' );
			end
			else
			begin
				-- It did exist, so mark it in the temp table
				update @existing_views
				set StillExisting='true'
				where ResultTypeId=@results10_id;
			end;
		end;

		-- Now, remove any 
		if (( select count(*) from @existing_views ) > 0 )
		begin
			-- First delete the fields
			delete from SobekCM_Item_Aggregation_Result_Fields
			where exists ( select 1 from @existing_views V where V.StillExisting='false' and V.AggrSpecificId=ItemAggregationResultID);

			-- Now, delete this results view
			delete from SobekCM_Item_Aggregation_Result_Views 
			where exists ( select 1 from @existing_views V where V.StillExisting='false' and V.AggrSpecificId=ItemAggregationResultID);

		end;

		-- Set the DEFAULT view
		if (( len(@default) > 0 ) and ( exists ( select 1 from SobekCM_Item_Aggregation_Result_Types where ResultType=@default )))
		begin
			-- Get the ID for the default
			declare @default_id int;
			set @default_id = ( select ItemAggregationResultTypeID from SobekCM_Item_Aggregation_Result_Types where ResultType=@default );

			-- Update, if it exists
			update SobekCM_Item_Aggregation_Result_Views
			set DefaultView = 'false'
			where AggregationID = @id and ItemAggregationResultTypeID != @default_id;

			-- Update, if it exists
			update SobekCM_Item_Aggregation_Result_Views
			set DefaultView = 'true'
			where AggregationID = @id and ItemAggregationResultTypeID = @default_id;
		end;

	end;

commit transaction;
GO


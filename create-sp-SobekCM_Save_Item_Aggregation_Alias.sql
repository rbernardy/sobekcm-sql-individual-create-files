USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Save_Item_Aggregation_Alias]    Script Date: 2/23/2022 8:09:49 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



-- Procedure either adds a forwarding or edits an existing forward
CREATE PROCEDURE [dbo].[SobekCM_Save_Item_Aggregation_Alias]
	@alias varchar(50),
	@aggregation_code varchar(20)	
AS
BEGIN
	
	-- Get the aggregation id from the aggregation code
	if (( select count(*) from SobekCM_Item_Aggregation where Code=@aggregation_code and Deleted='false' ) = 1 )
	begin
		-- Get the aggregation id
		declare @aggregationid int;
		select @aggregationid = AggregationID from SobekCM_Item_Aggregation where Code=@aggregation_code;

		-- Does this alias already exist?
		if (( select count(*) from SobekCM_Item_Aggregation_Alias where AggregationAlias=@alias ) > 0 )
		begin
			-- Update existing
			update SobekCM_Item_Aggregation_Alias
			set AggregationID = @aggregationID
			where AggregationAlias = @alias;
		end
		else
		begin
			-- Not existing, so add new one
			insert into SobekCM_Item_Aggregation_Alias ( AggregationAlias, AggregationID )
			values ( @alias, @aggregationid );
		end;
	end;
END;
GO


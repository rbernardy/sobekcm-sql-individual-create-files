USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[mySobek_Set_Aggregation_Home_Page_Flag]    Script Date: 1/19/2022 7:55:05 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Set aggregation home page flag 
CREATE PROCEDURE [dbo].[mySobek_Set_Aggregation_Home_Page_Flag]
	@userid int,
	@aggregationid int,
	@onhomepage bit
AS
begin transaction

	-- Check to see if this aggregation is already tied to this user
	if ( ( select count(*) from mySobek_User_Edit_Aggregation where UserID=@userid and AggregationID=@aggregationid ) > 0 )
	begin
		-- update existing link
		update mySobek_User_Edit_Aggregation
		set OnHomePage=@onhomepage
		where UserID =  @userid and AggregationID = @aggregationid

		-- delete any links that have nothing flagged
		delete from mySobek_User_Edit_Aggregation
		where CanSelect='false' and CanEditItems='false' and IsCurator='false' and OnHomePage='false'
	end
	else
	begin
		-- Insert new link with no permissions
		insert into mySobek_User_Edit_Aggregation ( UserID, AggregationID, CanSelect, CanEditItems, IsCurator, OnHomePage )
		values ( @userid, @aggregationid, 'false', 'false', 'false', @onhomepage )
	end

commit transaction
GO


USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Edit_IP_Range]    Script Date: 2/9/2022 7:34:36 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Edit basic information about an ip restriction range, or add a new range
CREATE PROCEDURE [dbo].[SobekCM_Edit_IP_Range]
	@rangeid int,
	@title nvarchar(150),
	@notes nvarchar(2000),
	@not_valid_statement nvarchar(max)
AS
begin

	-- Does this range id exist?
	if ( @rangeid in (select IP_RangeID from SobekCM_IP_Restriction_Range ))
	begin
		-- Range id existed, so update the existing IP range
		update SobekCM_IP_Restriction_Range
		set Title=@title, Notes=@notes, Not_Valid_Statement=@not_valid_statement
		where IP_RangeID = @rangeid;
	end
	else
	begin
		-- New range id, so add this IP range
		insert into SobekCM_IP_Restriction_Range ( Title, Notes, Not_Valid_Statement )
		values ( @title, @notes, @not_valid_statement );	
	end;
end;
GO


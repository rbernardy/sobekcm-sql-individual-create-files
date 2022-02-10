USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Edit_Single_IP]    Script Date: 2/9/2022 8:16:43 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Edits a single ip point within an entire IP restriction set of ranges, or
-- else adds a new ip point, if the provided ip_singleid is zero or less
CREATE PROCEDURE [dbo].[SobekCM_Edit_Single_IP]
	@ip_singleid int,
	@ip_rangeid int,
	@startip char(15),
	@endip char(15),
	@notes nvarchar(100),
	@new_ip_singleid int output
AS
BEGIN
	
	-- Was a primary key provided?
	if ( @ip_singleid > 0 )
	begin
	
		-- Update existing if there was one
		update SobekCM_IP_Restriction_Single
		set StartIP = @startip, EndIP = @endip, Notes=@notes
		where IP_SingleID = @ip_singleid;
		
		-- Return the existing ID
		set @new_ip_singleid = @ip_singleid;
	
	end
	else
	begin
	
		-- Insert new
		insert into SobekCM_IP_Restriction_Single ( IP_RangeID, StartIP, EndIP, Notes )
		values ( @ip_rangeid, @startip, @endip, @notes );
		
		-- Return the new primary key
		set @new_ip_singleid = @@identity;
	
	end;
END;
GO


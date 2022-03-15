USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Set_Additional_Work_Needed]    Script Date: 3/15/2022 7:34:14 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



-- Set the flag to have the builder reprocss this item
CREATE procedure [dbo].[SobekCM_Set_Additional_Work_Needed]
	@bibid varchar(10),
	@vid varchar(5) = null
as
begin transaction

	-- Find the GroupID
	declare @groupid int;
	if ( exists ( select 1 from SobekCM_Item_Group where BibID=@bibid ))
	begin
		
		set @groupid = ( select GroupID from SobekCM_Item_Group where BibID=@bibid );

		-- Was a VID provided?
		if ( @vid is null )
		begin
			-- Mark all VIDs of the BibID to be reprocessed
			update SobekCM_Item set AdditionalWorkNeeded='true'
			where GroupID = @groupid;
		end
		else
		begin
			-- update the specific vid
			update SobekCM_Item set AdditionalWorkNeeded='true'
			where GroupID = @groupid
			  and VID = @vid;		
		end;
	end;

commit transaction;
GO


USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Item_List]    Script Date: 2/19/2022 8:27:40 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Gets a list of items and groups which exist within this instance
CREATE PROCEDURE [dbo].[SobekCM_Item_List]
	@include_private bit
as
begin

	-- No need to perform any locks here
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	-- Set value for filtering privates
	declare @lower_mask int;
	set @lower_mask = 0;
	if ( @include_private = 'true' )
	begin
		set @lower_mask = -256;
	end;

	-- Return the item group / item information in one large table
	select G.BibID, I.VID, IP_Restriction_Mask, I.Title, G.[Type], I.Dark
	from SobekCM_Item I, SobekCM_Item_Group G
	where ( I.GroupID = G.GroupID )
	  and ( G.Deleted = CONVERT(bit,0) )
	  and ( I.Deleted = CONVERT(bit,0) )
	  and ( I.IP_Restriction_Mask >= @lower_mask )
	order by BibID, VID;

end;
GO


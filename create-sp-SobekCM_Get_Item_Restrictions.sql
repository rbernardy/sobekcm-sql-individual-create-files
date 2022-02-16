USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Get_Item_Restrictions]    Script Date: 2/15/2022 10:24:19 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SobekCM_Get_Item_Restrictions]
	@bibid varchar(10),
	@vid varchar(5)
AS
BEGIN
	select IP_Restriction_Mask, Dark
	from SObekCM_Item I, SobekCM_Item_Group G
	where ( I.VID = @vid )
	  and ( I.GroupID = G.GroupID )
	  and ( G.BibID=@bibid)
	  and ( I.Deleted = 'false' )
	  and ( G.Deleted = 'false' );
END
GO


USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Get_Item_Viewers]    Script Date: 2/15/2022 11:26:08 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SobekCM_Get_Item_Viewers]
	@bibid varchar(10),
	@vid varchar(5)
as
begin

	-- No need to perform any locks here
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	-- Return the current viewer information
	select T.ViewType, V.Attribute, V.Label, coalesce(V.MenuOrder, T.MenuOrder) as MenuOrder, V.Exclude, coalesce(V.OrderOverride, T.[Order]) as [Order]
	from SobekCM_Item_Viewers V, SobekCM_Item_Viewer_Types T, SobekCM_Item I, SobekCM_Item_Group G
	where ( I.GroupID = G.GroupID )
	  and ( G.BibID = @bibid )
	  and ( I.VID = @vid )
	  and ( V.ItemID = I.ItemID )
	  and ( V.ItemViewTypeID = T.ItemViewTypeID )
	group by T.ViewType, V.Attribute, V.Label, coalesce(V.MenuOrder, T.MenuOrder), V.Exclude, coalesce(V.OrderOverride, T.[Order])
	order by coalesce(V.OrderOverride, T.[Order]) ASC;

end;
GO


USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Get_All_Portals]    Script Date: 2/10/2022 9:32:11 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Get all of the portal information for this digital library
CREATE PROCEDURE [dbo].[SobekCM_Get_All_Portals]
	@activeonly bit
AS
begin

	-- No need to perform any locks here
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	if ( @activeonly = 'true' )
	begin
	
		select *
		from SobekCM_Portal_URL
		where isActive = 'true';
	
		select P.PortalID, A.Code
		from SobekCM_Portal_URL P, SobekCM_Portal_Item_Aggregation_Link AL, SobekCM_Item_Aggregation A
		where ( P.PortalID = AL.PortalID )
		  and ( AL.AggregationID = A.AggregationID )
		  and ( P.isActive = 'true' );
		  
		select P.PortalID, W.WebSkinCode
		from SobekCM_Portal_URL P, SobekCM_Portal_Web_Skin_Link WL, SobekCM_Web_Skin W
		where ( P.PortalID = WL.PortalID )
		  and ( WL.WebSkinID = W.WebSkinID )
		  and ( P.isActive = 'true' );
	end
	else
	begin
	
		select *
		from SobekCM_Portal_URL;
	
		select P.PortalID, A.Code
		from SobekCM_Portal_URL P, SobekCM_Portal_Item_Aggregation_Link AL, SobekCM_Item_Aggregation A
		where ( P.PortalID = AL.PortalID )
		  and ( AL.AggregationID = A.AggregationID );
		  
		select P.PortalID, W.WebSkinCode
		from SobekCM_Portal_URL P, SobekCM_Portal_Web_Skin_Link WL, SobekCM_Web_Skin W
		where ( P.PortalID = WL.PortalID )
		  and ( WL.WebSkinID = W.WebSkinID );
	
	end;
end;
GO


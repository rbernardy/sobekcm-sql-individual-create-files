USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Get_All_Regions]    Script Date: 2/10/2022 9:44:31 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Returns the entire GeoCore database of locations
CREATE PROCEDURE [dbo].[SobekCM_Get_All_Regions] AS
begin

	select GeoAuthCode, RegionName, RegionTypeName
	from Auth_GeoRegion R, Auth_GeoRegion_Type T
	where R.RegionTypeID = T.RegionTypeID
	order by GeoAuthCode;

end;
GO


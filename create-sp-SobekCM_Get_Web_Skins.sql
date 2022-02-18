USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Get_Web_Skins]    Script Date: 2/17/2022 10:04:39 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



-- Stored procedure to get all the web skin information 
CREATE PROCEDURE [dbo].[SobekCM_Get_Web_Skins] AS
begin

	-- No need to perform any locks here
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	select WebSkinCode, OverrideHeaderFooter=isnull(OverrideHeaderFooter,'false'), 
		OverrideBanner=isnull(OverrideBanner, 'false'), BannerLink=isnull(BannerLink,''),
		BaseInterface=isnull(BaseWebSkin,''), Notes=isnull(Notes,''), Build_On_Launch,
		SuppressTopNavigation
	from SobekCM_Web_Skin
	order by WebSkinCode;
end;
GO


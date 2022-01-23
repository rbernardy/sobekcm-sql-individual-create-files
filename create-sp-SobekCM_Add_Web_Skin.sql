USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Add_Web_Skin]    Script Date: 1/23/2022 12:25:09 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Procedure to add a new web skin, or edit an existing web skin
CREATE PROCEDURE [dbo].[SobekCM_Add_Web_Skin]
	@webskincode varchar(20),
	@basewebskin varchar(20),
	@overridebanner bit,
	@overrideheaderfooter bit,
	@bannerlink varchar(255),
	@notes varchar(250),
	@build_on_launch bit,
	@suppress_top_nav bit	
AS
BEGIN
	-- Does a web skin with this code already exist?
	if (( select count(*) from SobekCM_Web_Skin where WebSkinCode = @webskincode ) = 0 )
	begin
		-- No?  Add a new one
		insert into SobekCM_Web_Skin ( WebSkinCode, OverrideHeaderFooter, OverrideBanner, BaseWebSkin, BannerLink, Notes, Build_On_Launch, SuppressTopNavigation )
		values ( @webskincode, @overrideheaderfooter, @overridebanner, @basewebskin, @bannerlink, @notes, @build_on_launch, @suppress_top_nav );

	end
	else
	begin
		-- Yes? Update the existing web skin with the same code
		update SobekCM_Web_Skin
		set OverrideHeaderFooter=@overrideheaderfooter, OverrideBanner=@overridebanner, BaseWebSkin=@basewebskin, BannerLink=@bannerlink, Notes=@notes, Build_On_Launch=@build_on_launch, SuppressTopNavigation=@suppress_top_nav
		where WebSkinCode = @webskincode;
	
	end;
END;
GO


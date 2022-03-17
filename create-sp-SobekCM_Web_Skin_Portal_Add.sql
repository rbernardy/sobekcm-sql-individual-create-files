USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Web_Skin_Portal_Add]    Script Date: 3/16/2022 8:19:58 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Add a link between a url portal and a web skin, also indicating
-- if this addition is the default web skin
CREATE PROCEDURE [dbo].[SobekCM_Web_Skin_Portal_Add]
	@PortalID int,
	@Skin_Code nvarchar(20),
	@isDefault bit
AS
BEGIN
	-- Ensure the web skin exists
	if ( @Skin_Code in ( select WebSkinCode from SobekCM_Web_Skin ))
	begin
		-- Get the web skin primary key
		declare @skinid int;
		set @skinid=(select top 1 WebSkinCode from SobekCM_Web_Skin where WebSkinCode=@Skin_Code);
		
		-- Does this link already exist?
		if exists ( select * from SobekCM_Portal_Web_Skin_Link where WebSkinID=@skinid and PortalID=@PortalID )
		begin
			-- Just update the default value
			update SobekCM_Portal_Web_Skin_Link
			set isDefault=@isDefault
			where WebSkinID=@skinid and PortalID=@PortalID;
		end
		else
		begin
			-- Insert a new link between this portal and web skin
			insert into SobekCM_Portal_Web_Skin_Link ( PortalID, WebSkinID, isDefault )
			values ( @PortalID, @skinid, @isDefault );
		end;		
	end;
END;
GO


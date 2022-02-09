USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Delete_Web_Skin]    Script Date: 2/8/2022 10:19:11 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Procedure to delete a web skin, and unlink any items or web portals which
-- were linked to this web skin
CREATE PROCEDURE [dbo].[SobekCM_Delete_Web_Skin]
	@webskincode varchar(20),
	@force_delete bit,
	@links int output
AS
BEGIN

	-- set default links return value
	set @links = 0;
	
	-- Only continue if the web skin code exists
	if (( select count(*) from SobekCM_Web_Skin where WebSkinCode = @webskincode ) > 0 )
	begin	
	
		-- Get the web skin id, from the code
		declare @webskinid int;
		select @webskinid=WebSkinID from SobekCM_Web_Skin where WebSkinCode=@webskincode;	
	
		-- Should this force delete?
		if ( @force_delete = 'true' )
		begin	
		
			-- Delete the web skins to item group links
			delete from SobekCM_Item_Group_Web_Skin_Link 
			where WebSkinID=@webskinid;
			
			-- Delete the web skin links to URL portals
			delete from SobekCM_Portal_Web_Skin_Link 
			where WebSkinID=@webskinid;
			
			-- Remove any links to the item aggregation
			update SobekCM_Item_Aggregation
			set DefaultInterface = '' 
			where DefaultInterface = @webskincode;
			
			-- Delete the web skins themselves
			delete from SobekCM_Web_Skin
			where WebSkinID=@webskinid;		
		end
		else
		begin
			if ((( select count(*) from SobekCM_Item_Group_Web_Skin_Link where WebSkinID=@webskinid ) > 0 ) or
			    (( select count(*) from SobekCM_Portal_Web_Skin_Link where WebSkinID=@webskinid ) > 0 ) or
			    (( select count(*) from SobekCM_Item_Aggregation where DefaultInterface=@webskincode ) > 0 ))
			begin
				set @links = 1;
			end
			else
			begin
				-- Delete the web skins themselves, since no links found
				delete from SobekCM_Web_Skin
				where WebSkinID=@webskinid;					
			end;			
		end;
	end;
END;
GO


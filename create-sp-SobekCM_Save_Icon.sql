USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Save_Icon]    Script Date: 2/22/2022 8:44:19 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SobekCM_Save_Icon]
	@iconid int,
	@icon_name varchar(255),
	@icon_url varchar(255),
	@link varchar(255), 
	@height int,
	@title varchar(255),
	@new_iconid int output
as
begin transaction	

	-- Does an icon with this icon name (code) exists?
    if ((select count(*) from SobekCM_Icon where icon_name = @icon_name) = 0 )
    begin     
		-- None existed, so insert a new one 
		insert into SobekCM_Icon(icon_name,icon_url, link, height, title )
		values(@icon_name, @icon_url, @link, @height, @title )
		select @new_iconid = @@identity
    end
	else
	begin
		-- Update the existing row
		update SobekCM_Icon
		set icon_url = @icon_url, link = @link, height = @height, title = @title
		where icon_name = @icon_name
   		
		-- Return this icon id
		select @new_iconid = IconID
		from SobekCM_Icon
		where icon_name = @icon_name
   end  
  
commit transaction
GO


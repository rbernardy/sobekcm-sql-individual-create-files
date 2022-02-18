USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Icon_List]    Script Date: 2/17/2022 10:11:18 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Returns the list of all icons used by the SobekCM web app
CREATE PROCEDURE [dbo].[SobekCM_Icon_List]
as
begin

	-- No need to perform any locks here
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	-- Return all the icon information, in any sort order
	select Icon_Name, Icon_URL, Link=isnull(Link,''), Title=isnull(Title,'')
	from SobekCM_Icon;

end;
GO


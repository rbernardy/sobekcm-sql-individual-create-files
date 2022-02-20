USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Manager_Get_Thematic_Headings]    Script Date: 2/20/2022 6:58:52 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Stored procedure for pulling the list of thematic headings
CREATE PROCEDURE [dbo].[SobekCM_Manager_Get_Thematic_Headings] 
AS
BEGIN
	-- No need to perform any locks here
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
	
	-- Return all the thematic heading information
	select * 
	from SobekCM_Thematic_Heading
	order by ThemeOrder;
END;
GO


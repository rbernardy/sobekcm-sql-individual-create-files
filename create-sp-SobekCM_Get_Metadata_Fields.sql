USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Get_Metadata_Fields]    Script Date: 2/16/2022 10:29:29 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Return the list of all metadata searchable fields
CREATE PROCEDURE [dbo].[SobekCM_Get_Metadata_Fields]
AS
begin

	-- No need to perform any locks here.  A slightly dirty read won't hurt much
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
	
	-- Just return all the values, but sort by display term
	select * 
	from SobekCM_Metadata_Types
	order by DisplayTerm;
end;
GO


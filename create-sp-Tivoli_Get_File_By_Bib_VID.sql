USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[Tivoli_Get_File_By_Bib_VID]    Script Date: 3/17/2022 7:42:19 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Procedure to pull the stored files by bib id and vid
CREATE PROCEDURE [dbo].[Tivoli_Get_File_By_Bib_VID]
	@bibid char(10),
	@vid char(5)
AS
BEGIN
	
	select * 
	from Tivoli_File_Log 
	where BibID = @bibid and VID = @vid

END
GO


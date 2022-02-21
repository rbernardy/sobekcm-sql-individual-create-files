USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Manager_GroupID_From_BibID]    Script Date: 2/20/2022 7:05:49 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Returns the group id for a single provided bib id
CREATE PROCEDURE [dbo].[SobekCM_Manager_GroupID_From_BibID]
      @bibid varchar(10)
AS
BEGIN
      select GroupID 
      from SobekCM_Item_Group
      where BibID = @bibid;
END;
GO


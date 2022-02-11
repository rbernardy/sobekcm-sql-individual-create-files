USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Get_All_Groups_First_VID]    Script Date: 2/10/2022 8:56:00 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SobekCM_Get_All_Groups_First_VID]
AS
begin
  
	  with temp as (
		select G.BibID, G.GroupID, I.VID, 
    		row_number() over (partition by G.BibID order by I.VID) as rownum
		from SobekCM_Item_Group G, SobekCM_Item I
		where G.GroupID=I.GroupID
	)
	select BibID, GroupID, VID from temp where rownum = 1;

end;
GO


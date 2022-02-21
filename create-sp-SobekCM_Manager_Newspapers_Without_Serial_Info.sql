USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Manager_Newspapers_Without_Serial_Info]    Script Date: 2/20/2022 7:10:42 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Returns basic information about newspaper titles which lack some
-- serial information and should be processed somehow.
-- This is generally used from the SMaRT tool right now, but will likely
-- be added to the web interface shortly.
CREATE PROCEDURE [dbo].[SobekCM_Manager_Newspapers_Without_Serial_Info]
as
begin

	-- Return the bibid's and group title for titles which have items lacking
	-- serial information
	select distinct(G.BibID), G.GroupTitle
	from SobekCM_Item I, SobekCM_Item_Group G
	where ( I.GroupID = G.GroupID )
	  and ( G.Type like '%Newspaper%' )
      and (( len( isnull(Level1_Text,'')) = 0 ) or ( Level1_Index <= 0 ) or ( LEN( ISNULL( Level2_Text,'')) = 0 )or ( Level2_Index <= 0 ))
      and ( G.ItemCount > 1 );
end;
GO


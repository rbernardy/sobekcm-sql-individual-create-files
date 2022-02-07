USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Check_For_Record_Existence]    Script Date: 2/6/2022 7:12:57 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


/****** Object:  StoredProcedure [dbo].[SobekCM_Check_For_Record_Existence]    Script Date: 12/20/2013 05:43:36 ******/
-- Returns basic information for the importer to verify if a record currently exists, 
-- by checkig BibID, VID, OCLC_Number, or ALEPH number
CREATE PROCEDURE [dbo].[SobekCM_Check_For_Record_Existence]
	@BibID varchar(10),
	@VID varchar(5),
	@OCLC_Number bigint,
	@Local_Cat_Number int
AS
begin

	-- No need to perform any locks here
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	-- Check to see if a VID was provided
	if ( LEN(@VID) > 0 )
	begin	
		select G.BibID, I.VID, G.OCLC_Number, G.ALEPH_Number, G.GroupTitle, I.Title, I.Author, I.Publisher
		from SobekCM_Item_Group G, SobekCM_Item I
		where G.GroupID = I.GroupID 
		and ((( G.BibID = @BibID ) and ( I.VID = @VID )) or ( G.OCLC_Number = @OCLC_Number ) or ( G.ALEPH_Number = @Local_Cat_Number ));	
	end
	else
	begin
		select G.BibID, I.VID, G.OCLC_Number, G.ALEPH_Number, G.GroupTitle, I.Title, I.Author, I.Publisher
		from SobekCM_Item_Group G, SobekCM_Item I
		where G.GroupID = I.GroupID 
		and (( G.BibID = @BibID ) or ( G.OCLC_Number = @OCLC_Number ) or ( G.ALEPH_Number = @Local_Cat_Number ));	
	end;
end;
GO


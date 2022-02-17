USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Get_OAI_Data_Item]    Script Date: 2/16/2022 11:39:56 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Returns the OAI data for a single item from the oai source tables
CREATE PROCEDURE [dbo].[SobekCM_Get_OAI_Data_Item]
	@bibid varchar(10),
	@vid varchar(5),
	@data_code varchar(20)
AS
begin
	-- No need to perform any locks here
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
	
	-- Select the matching rows
	select G.GroupID, BibID, O.OAI_Data, O.OAI_Date, VID
	from SobekCM_Item_Group G, SobekCM_Item I, SobekCM_Item_OAI O
	where G.BibID = @bibid
	  and G.GroupID = I.GroupID
	  and I.VID = @vid
	  and I.ItemID = O.ItemID	
	  and O.Data_Code = @data_code;
end;
GO


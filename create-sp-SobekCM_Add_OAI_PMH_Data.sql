USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Add_OAI_PMH_Data]    Script Date: 1/23/2022 11:56:12 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Add some OAI-PMH data to an item.  Included will be the data (usually in XML format)
-- and the OAI-PMH code for that data type.  The XML information is saved as nvarchar, rather
-- than XML, since this data is never sub-queried.  It is just returned while serving OAI.
CREATE PROCEDURE [dbo].[SobekCM_Add_OAI_PMH_Data]
	@itemid int,
	@data_code nvarchar(20),
	@oai_data nvarchar(max)
AS
begin

	-- Does this already exists?
	if (( select COUNT(*) from SobekCM_Item_OAI where ItemID=@itemid and Data_Code=@data_code ) = 0 )
	begin
		insert into SobekCM_Item_OAI ( ItemID, OAI_Data, OAI_Date, Data_Code )
		values ( @itemid, @oai_data, GETDATE(), @data_code );
	end
	else
	begin
		update SobekCM_Item_OAI
		set OAI_Data=@oai_data, OAI_Date=GETDATE(), Data_Code=@data_code
		where ItemID=@itemid and Locked='false' and Data_Code=@data_code;
	end;
end;
GO


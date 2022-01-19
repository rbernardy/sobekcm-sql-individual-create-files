USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[mySobek_Get_User_Item_Link_Relationships]    Script Date: 1/18/2022 8:25:24 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[mySobek_Get_User_Item_Link_Relationships]
AS
begin
	select * from mySobek_User_Item_Link_Relationship
end
GO


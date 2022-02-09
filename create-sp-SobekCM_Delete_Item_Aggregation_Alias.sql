USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Delete_Item_Aggregation_Alias]    Script Date: 2/8/2022 9:03:31 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Delete a single item aggregation alias (or forwarding) by alias
CREATE PROCEDURE [dbo].[SobekCM_Delete_Item_Aggregation_Alias]
	@alias varchar(50)
AS
BEGIN
	delete from SobekCM_Item_Aggregation_Alias
	where AggregationAlias = @alias;
END;
GO


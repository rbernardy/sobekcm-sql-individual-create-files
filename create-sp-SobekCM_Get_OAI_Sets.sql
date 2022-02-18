USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Get_OAI_Sets]    Script Date: 2/17/2022 8:32:20 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




-- Get the OAI set information from the database
-- This stored procedure is called from the UFDC Web
-- Written by Mark Sullivan (March, 2007)
CREATE PROCEDURE [dbo].[SobekCM_Get_OAI_Sets] AS
begin transaction

	-- Get the basic collection information that supports OAI
	select C.AggregationID, C.Code, C.[Name], C.Description, OAI_Metadata=isnull(C.OAI_Metadata, '')
	into #TEMP1
	from SobekCM_Item_Aggregation C
	where ( C.isActive = 1 )
	  and ( C.OAI_Flag = 1 )
	  and ( C.Deleted = 0 )
	order by C.Code;

	select T.Code, T.[Name], T.Description, LastItemAddedDate=MAX(I.CreateDate), T.OAI_Metadata
	from #TEMP1 T, SobekCM_Item_Aggregation_Item_Link L, SobekCM_Item I
	where ( T.AggregationID = L.AggregationID )
      and ( L.ItemID = I.ItemID )
	group by Code, [Name], Description, OAI_Metadata;

	-- drop the temporary tables
	drop table #TEMP1;

commit transaction;
GO


USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Get_Aggregations_By_ProjectID]    Script Date: 2/9/2022 9:40:46 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SobekCM_Get_Aggregations_By_ProjectID]
	@ProjectID int
AS
Begin
  
  select AggregationID from SobekCM_Project_Aggregation_Link
  where ProjectID=@ProjectID;
 End

GO


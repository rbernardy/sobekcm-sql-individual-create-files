USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Delete_Project_Aggregation_Link]    Script Date: 2/8/2022 9:24:17 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[SobekCM_Delete_Project_Aggregation_Link]
	@ProjectID int,
	@AggregationID int	
AS
Begin
  --If this link exists, delete it
  if((select count(*) from SobekCM_Project_Aggregation_Link  where ( ProjectID = @ProjectID and AggregationID=@AggregationID ))  = 1 )
    delete from SobekCM_Project_Aggregation_Link
    where (ProjectID=@ProjectID and AggregationID=@AggregationID);
End
GO


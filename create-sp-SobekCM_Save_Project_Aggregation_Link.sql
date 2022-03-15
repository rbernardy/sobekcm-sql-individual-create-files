USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Save_Project_Aggregation_Link]    Script Date: 3/14/2022 10:12:30 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SobekCM_Save_Project_Aggregation_Link]
	@ProjectID int,
	@AggregationID int
AS
Begin
  --If this link does not already exist, insert it
  if((select count(*) from SobekCM_Project_Aggregation_Link  where ( ProjectID = @ProjectID and AggregationID=@AggregationID ))  < 1 )
    insert into SobekCM_Project_Aggregation_Link(ProjectID, AggregationID)
    values(@ProjectID, @AggregationID);
End
GO


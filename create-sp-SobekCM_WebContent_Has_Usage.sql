USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_WebContent_Has_Usage]    Script Date: 3/16/2022 9:09:19 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Pull the flag indicating if this instance has any web content usage logged
CREATE PROCEDURE [dbo].[SobekCM_WebContent_Has_Usage]
	@value bit output
AS
BEGIN	

	if ( exists ( select 1 from SobekCM_WebContent_Statistics ))
		set @value = 'true';
	else
		set @value = 'false';
	
END;
GO


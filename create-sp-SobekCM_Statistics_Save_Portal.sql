USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Statistics_Save_Portal]    Script Date: 3/16/2022 7:37:41 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SobekCM_Statistics_Save_Portal]
	@year smallint,
	@month smallint,
	@hits int,
	@portalid int
as
begin

	insert into SobekCM_Portal_URL_Statistics ( PortalID, [Year], [Month], [Hits] )
	values ( @portalid, @year, @month, @hits );

end;
GO


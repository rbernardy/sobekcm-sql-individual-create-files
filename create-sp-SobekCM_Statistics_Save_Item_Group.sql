USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Statistics_Save_Item_Group]    Script Date: 3/15/2022 10:20:30 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SobekCM_Statistics_Save_Item_Group]
	@year smallint,
	@month smallint,
	@hits int,
	@sessions int,
	@groupid int
as
begin

	insert into SobekCM_Item_Group_Statistics ( GroupID, [Year], [Month], [Hits], [Sessions] ) 
	values ( @groupid, @year, @month, @hits, @sessions );

end;
GO


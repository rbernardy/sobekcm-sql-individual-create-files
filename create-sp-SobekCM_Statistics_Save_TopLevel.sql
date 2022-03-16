USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Statistics_Save_TopLevel]    Script Date: 3/16/2022 7:41:03 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[SobekCM_Statistics_Save_TopLevel]
	@year smallint,
	@month smallint,
	@hits int,
	@sessions int,
	@robot_hits int,
	@xml_hits int,
	@oai_hits int,
	@json_hits int
as
begin

	-- Clear any existing one
	delete from SobekCM_Statistics where [Year]=@year and [Month]=@month;

	-- Add this
	insert into SobekCM_Statistics ( [Year], [Month], [Hits], [Sessions], Robot_Hits, XML_Hits, OAI_Hits, JSON_Hits )
	values ( @year, @Month, @hits, @sessions, @robot_hits, @xml_hits, @oai_hits, @json_hits);
end;
GO


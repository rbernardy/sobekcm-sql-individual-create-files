USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Extensions_Set_Enable]    Script Date: 2/9/2022 9:10:55 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SobekCM_Extensions_Set_Enable]
	@Code nvarchar(50),
	@EnableFlag bit,
	@Message varchar(255) output
AS
BEGIN
	-- If the code is missing, do nothing
	if ( not exists ( select 1 from SobekCM_Extension where Code=@Code ))
	begin
		set @Message = 'ERROR: Unable to find matching extension in the database!';
		return;
	end;

	-- If the enable flag in the database is already set that way, do nothing
	if ( exists ( select 1 from SobekCM_Extension where Code=@Code and IsEnabled=@EnableFlag ))
	begin
		set @Message = 'Enabled flag was already set as requested for this plug-in';
		return;
	end;

	-- plug-in exists and flag is new
	if ( @EnableFlag = 'false' )
	begin
		update SobekCM_Extension set IsEnabled='false', EnabledDate=null where Code=@Code;
		set @Message='Disabled ' + @Code + ' plugin';
	end
	else
	begin
		update SobekCM_Extension set IsEnabled='true', EnabledDate=getdate() where Code=@Code;
		set @Message='Enabled ' + @Code + ' plugin';
	end;

END;
GO


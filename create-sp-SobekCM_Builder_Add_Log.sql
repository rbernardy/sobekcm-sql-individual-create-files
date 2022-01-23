USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Builder_Add_Log]    Script Date: 1/23/2022 1:46:54 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SobekCM_Builder_Add_Log]
	@RelatedBuilderLogID bigint,
	@BibID_VID varchar(16),
	@LogType varchar(25),
	@LogMessage varchar(2000),
	@METS_Type varchar(50),
	@BuilderLogID bigint output
AS
BEGIN

	insert into SobekCM_Builder_Log ( RelatedBuilderLogID, LogDate, BibID_VID, LogType, LogMessage )
	values ( @RelatedBuilderLogID, getdate(), @BibID_VID, @LogType, @LogMessage );
	
	set @BuilderLogID = @@IDENTITY;
END;
GO


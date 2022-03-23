USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[Tracking_OCR_Complete]    Script Date: 3/22/2022 8:44:34 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Adds an OCR Workflow progress for a specific volume.
CREATE PROCEDURE [dbo].[Tracking_OCR_Complete]
	@bibid varchar(10),
	@vid varchar(5)	
AS
begin transaction

	exec [Tracking_Add_Workflow_Once_Per_Day] @bibid, @vid, '', '', 6, null

commit transaction
GO


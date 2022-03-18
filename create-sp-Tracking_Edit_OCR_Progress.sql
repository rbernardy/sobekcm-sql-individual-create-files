USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[Tracking_Edit_OCR_Progress]    Script Date: 3/17/2022 9:24:42 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Adds an OCR Workflow progress for a specific volume.
-- Created:		04/08/09
-- Project:		OCR Automation Project-
-- Developer:	Tom Bielicke
CREATE PROCEDURE [dbo].[Tracking_Edit_OCR_Progress]
	@BibID		varchar(10),
	@VIDNumber	varchar (5)	
AS
begin

	exec Tracking_Add_Workflow_Once_Per_Day @bibid, @VIDNumber, '', '', 6, '';
	
end;
GO


USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[Tracking_Load_Metadata_Update_Complete]    Script Date: 3/22/2022 8:15:51 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Marks this volume as having processed a metadata update for it
-- This is called when an item successfully passes 'UFDC Loader'
-- Written by Mark Sullivan (April 2007)
CREATE PROCEDURE [dbo].[Tracking_Load_Metadata_Update_Complete]
	@bibid varchar(10),
	@vid varchar(5),
	@user varchar(50),
	@usernotes varchar(1000)
AS
begin transaction

	exec [Tracking_Add_Workflow_Once_Per_Day] @bibid, @vid, @user, @usernotes, 11, null

commit transaction
GO


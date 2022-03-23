USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[Tracking_Online_Edit_Complete]    Script Date: 3/22/2022 8:48:04 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Marks this volume as having been edited online
CREATE PROCEDURE [dbo].[Tracking_Online_Edit_Complete]
	@itemid int,
	@user varchar(50),
	@usernotes varchar(1000)
AS
begin transaction

	-- Just add this new progress then
	insert into Tracking_Progress ( ItemID, WorkFlowID, DateCompleted, WorkPerformedBy, ProgressNote, WorkingFilePath )
	values ( @itemid, 30, getdate(), @user, @usernotes, '' )

commit transaction
GO


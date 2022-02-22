USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_QC_Save_Error]    Script Date: 2/21/2022 10:33:10 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SobekCM_QC_Save_Error] 
	-- Add the parameters for the stored procedure here
	@itemID int,
	@filename nvarchar(MAX),
	@errorCode nchar(10),
	@isVolumeError bit,
	@description nvarchar(MAX),
	@errorID int out
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	--Insert this error into the SobekCM_QC_Errors Table
	if not exists(select * from SobekCM_QC_Errors where ItemID=@itemID and [FileName]=@filename)
	Begin
		-- Insert statements for procedure here
		INSERT INTO SobekCM_QC_Errors(ItemID, [FileName],ErrorCode,isVolumeError,[Description])
		VALUES(@itemID,@filename,@errorCode, @isVolumeError, @description);
	End
	else
	Begin
		Update SobekCM_QC_Errors set ErrorCode=@errorCode, isVolumeError=@isVolumeError,[Description]=@description
		where ItemID=@itemID AND [FileName]=@filename;
 
	End
	set @errorID=@@IDENTITY;   
  
	--Also add this error into the the errors History	table
	if not exists(select * from SobekCM_QC_Errors_History where ItemID=@itemID and ErrorCode=@errorCode)
    BEGIN
        INSERT INTO SobekCM_QC_Errors_History(ItemID,ErrorCode,isVolumeError,[Count])
        VALUES(@itemID,@errorCode,@isVolumeError,1);
    END
    else
    Begin
      Declare @errorCount int
      select @errorCount = [Count] from SobekCM_QC_Errors_History
      where ItemID=@itemID and ErrorCode=@errorCode;
      
      update SobekCM_QC_Errors_History set [Count]=(@errorCount+1)
      where ItemID=@itemID and ErrorCode=@errorCode; 
    End
END
GO


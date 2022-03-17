USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[Tivoli_Add_File_Archive_Log]    Script Date: 3/16/2022 9:20:28 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Sullivan, Mark
-- Create date: October 7, 2009
-- Description:	Stores the file archive log
-- =============================================
CREATE PROCEDURE [dbo].[Tivoli_Add_File_Archive_Log]
	@BibID char(10),
	@VID char(5),
	@Folder varchar(250),
	@FileName varchar(100),
	@Size bigint,
	@LastWriteDate datetime,
	@ItemID int,
	@Original_FileName varchar(100),
	@SHA1_Checksum nvarchar(250)
AS
BEGIN
	insert into Tivoli_File_Log ( BibID, VID, Folder, [FileName], [Size], LastWriteDate, ArchiveDate, ItemID, Original_FileName, SHA1_Checksum, ArchiveMonth, ArchiveYear )
	values ( @BibID, @VID, @Folder, @FileName, @Size, @LastWriteDate, getdate(), @ItemID, @Original_FileName, @SHA1_Checksum, DATEPART(month, getdate()), DATEPART(YEAR, GETDATE()))
END
GO


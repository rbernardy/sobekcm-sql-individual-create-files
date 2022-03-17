USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[Tivoli_Request_File]    Script Date: 3/17/2022 7:53:37 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Procedure logs a tivoli file retrieval request
CREATE PROCEDURE [dbo].[Tivoli_Request_File]
	@folder varchar(250),
	@filename varchar(100),
	@username varchar(100),
	@emailaddress varchar(100),
	@requestnote nvarchar(1500)
AS
begin
	insert into Tivoli_File_Request( Folder, [FileName], UserName, EmailAddress, RequestNote, RequestDate, Completed )
	values ( @folder, @filename, @username, @emailaddress, @requestnote, GETDATE(), 'false' )
end
GO


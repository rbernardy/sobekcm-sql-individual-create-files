USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[Tivoli_Outstanding_File_Requests]    Script Date: 3/17/2022 7:50:00 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Procedure returns all pending tivoli file requests
CREATE PROCEDURE [dbo].[Tivoli_Outstanding_File_Requests]
AS
begin

	select * from Tivoli_File_Request where Completed = 'false'

end
GO


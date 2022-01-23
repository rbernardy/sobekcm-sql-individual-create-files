USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Admin_Suggest_User_Item_Links]    Script Date: 1/23/2022 12:48:45 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Procedure tries to match users that can submit with authors and suggests new
-- possible relationships for the users and items
CREATE PROCEDURE [dbo].[SobekCM_Admin_Suggest_User_Item_Links]
AS
begin

	-- No need to perform any locks here
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	-- Create a temporary table for all matching creator metadata
	create table #TEMP1 ( 	UserID int, ItemID int, FirstName nvarchar(100), LastName nvarchar(100), Email nvarchar(100), MetadataValue nvarchar(max), Title nvarchar(max));

	-- Create temporary variables to hold each author's information for searching
	declare @userid int;
	declare @firstname nvarchar(100);
	declare @lastname nvarchar(100);
	declare @nickname nvarchar(100);
	declare @email nvarchar(100);

	-- Create a cursor to go through all users that can submit to this system
	declare author_cursor CURSOR FOR 
	select UserID, '"' + FirstName + '"', '"' + LastName + '"', '"' + NickName + '"','"' + EmailAddress + '"' from mySobek_User where Can_Submit_Items='true';

	OPEN author_cursor;

	-- Get the first author
	FETCH NEXT FROM author_cursor 
	INTO @userid, @firstname, @lastname, @nickname, @email;

	-- Do while there are more authors to dor
	WHILE @@FETCH_STATUS = 0
	BEGIN

		insert into #TEMP1 ( UserID, ItemID, FirstName, LastName, Email, MetadataValue, Title )	   
		select @userid, L.itemid, @firstname, @lastname, @email, MetadataValue, I.Title
		from SobekCM_Metadata_Unique_Search_Table M, SobekCM_Metadata_Unique_Link L, SobekCM_Item I 
		where ( contains( MetadataValue, @lastname )) 
		  and (( contains( MetadataValue, @firstname )) or ( contains( MetadataValue, @nickname )))
		  and ( L.MetadataID=M.MetadataID ) 
		  and ( M.MetadataTypeID = 4 )
		  and ( L.ItemID = I.ItemID )
		  and ( not exists ( select * from mySobek_User_Item_Link U where U.UserID=@userid and U.ItemID=L.ItemID));

		-- Get the next author
		FETCH NEXT FROM author_cursor 
		INTO @userid, @firstname, @lastname, @nickname, @email;
	END;

	-- Done with the author cursor
	CLOSE author_cursor;
	DEALLOCATE author_cursor;

	select * from #TEMP1
	order by LastName, FirstName, UserID, ItemID;

	drop table #TEMP1;
end;
GO


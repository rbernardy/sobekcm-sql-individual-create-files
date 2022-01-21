USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Add_External_Record_Number]    Script Date: 1/20/2022 9:09:15 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- This procedure adds a new external record number to an existing item
CREATE PROCEDURE [dbo].[SobekCM_Add_External_Record_Number]
	@groupID int,
	@extRecordValue varchar(50),
	@extRecordType varchar(25)
AS
begin transaction

	-- declare two variables that may be needed for this
	declare @extRecordTypeID int;
	declare @extRecordLinkID int;

	-- Look for an existing record type
	select @extRecordTypeID = isnull(extRecordTypeID, -1)
	from SobekCM_External_Record_Type
	where (extRecordType = @extRecordType);

	-- Was this a new record type
	if ( isnull( @extRecordTypeID, -1 ) < 0 )
	begin
		-- Add this new record type
		insert into SobekCM_External_Record_Type ( ExtRecordType, repeatableTypeFlag )
		values ( @extRecordType, 1 );

		-- Save this new id
		set @extRecordTypeID = @@identity;
	end;

	-- The linkID parameter is less than zero; query the database 
	-- to see if one exists for this record type.		
	select @extRecordLinkID = isnull( extRecordLinkID, -1 )
	from [SobekCM_Item_Group_External_Record]
	where (GroupID = @groupID )
	  and ( ExtRecordTypeID = @extRecordTypeID )
	  and ( ExtRecordValue = @extRecordValue );

	if (isnull( @extRecordLinkID, -1 ) < 0)
	begin	
		-- Check to see if this record type is singular type (nonrepeatable)
		if (( select count(*) from SobekCM_External_Record_Type where ExtRecordTypeID = @extRecordTypeID and repeatableTypeFlag = 'False' ) > 0 )
		begin
			-- Look for an existing singular record for this item group
			if (( select count(*) from SobekCM_Item_Group_External_Record 
				where ( ExtRecordTypeID = @extRecordTypeID ) and ( GroupID = @groupID )) > 0 )
			begin
				-- Get the link id
				select @extRecordLinkID = extRecordLinkID
				from SobekCM_Item_Group_External_Record 
				where ( ExtRecordTypeID = @extRecordTypeID ) and ( GroupID = @groupID );

				--Update existing link
				update SobekCM_Item_Group_External_Record
				set extRecordValue = @extRecordValue 
				where (extRecordLinkID = @extRecordLinkID);
			end
			else
			begin
				-- No existing record for this singular record type, so just insert
				insert into SobekCM_Item_Group_External_Record ( groupid, extRecordTypeID, extRecordValue)
				values ( @groupID, @extRecordTypeID, @extRecordValue );
			end;
		end
		else
		begin
			-- Non-singular record type value, so just insert if it doesn't exist
			if (( select COUNT(*) from SobekCM_Item_Group_External_Record where GroupID=@groupID and ExtRecordTypeID=@extRecordTypeID and ExtRecordValue = @extRecordValue ) = 0 )
			begin
				insert into SobekCM_Item_Group_External_Record ( groupid, extRecordTypeID, extRecordValue)
				values ( @groupID, @extRecordTypeID, @extRecordValue );
			end;
		end;
	end;
	
commit transaction;
GO


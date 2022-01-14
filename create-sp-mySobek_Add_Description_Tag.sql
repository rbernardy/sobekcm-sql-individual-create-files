USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[mySobek_Add_Description_Tag]    Script Date: 1/13/2022 10:42:57 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Add a user tag
CREATE PROCEDURE [dbo].[mySobek_Add_Description_Tag] 
	@UserID int,
	@TagID int,
	@ItemID int,
	@Description nvarchar(2000),
	@new_TagID int output
AS
begin

	set @new_TagID = -1;

	if ( ISNULL(@TagID, -1 ) > 0 )
	begin
		update mySobek_User_Description_Tags
		set Description_Tag = @Description, Date_Modified = GETDATE()
		where TagID=@TagID and UserID=@UserID
		
		set @new_TagID = @TagID;	
	end
	else
	begin
		-- Can have up to five comments on a single item 
		if (( select COUNT(*) from mySobek_User_Description_Tags where UserID=@UserID and ItemID=@ItemID ) < 5)
		begin
			insert into mySobek_User_Description_Tags( UserID, ItemID, Description_Tag, Date_Modified )
			values ( @UserID, @ItemID, @Description, GETDATE() )	
			
			set @new_TagID = @@identity
		end
	end
end
GO


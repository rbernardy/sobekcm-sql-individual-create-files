USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Edit_Aggregation_Details]    Script Date: 2/8/2022 10:44:30 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[SobekCM_Edit_Aggregation_Details]
	@AggregationID int,
	@Code varchar(20),
	@Name varchar(255),
	@ShortName varchar(100),
	@Description varchar(1000),
	@ThematicHeadingID int,
	@Type varchar(50),
	@isActive bit,
	@Hidden bit,
	@DisplayOptions varchar(10),
	@Map_Search tinyint,
	@Map_Display tinyint,
	@OAI_Flag bit,
	@OAI_Metadata nvarchar(2000),
	@ContactEmail nvarchar(255),
	@HasNewItems bit,
	@Default_Skin varchar(50),
	@Items_Can_Be_Described tinyint,
	@LastItemAdded date,
	@External_Link nvarchar(255),
	@Can_Browse_Items bit,
	@Include_In_Collection_Facet bit,
	@ParentID int,
	@NewID int output
AS
BEGIN
	-- Is this a new aggregation?
	if (( select COUNT(*) from SobekCM_Item_Aggregation where AggregationID=@AggregationID ) = 0 )
	begin	
		-- Insert new portal
		insert into SobekCM_Item_Aggregation ( Code, Name, ShortName, [Description], ThematicHeadingID, [Type], isActive, Hidden, DisplayOptions, Map_Search, Map_Display, OAI_Flag, OAI_Metadata, ContactEmail, HasNewItems, DefaultInterface, Items_Can_Be_Described, LastItemAdded, External_Link, Can_Browse_Items, DateAdded, Include_In_Collection_Facet )
		values ( @Code, @Name, @ShortName, @Description, @ThematicHeadingID, @Type, @isActive, @Hidden, @DisplayOptions, @Map_Search, @Map_Display, @OAI_Flag, @OAI_Metadata, @ContactEmail, @HasNewItems, @Default_Skin, @Items_Can_Be_Described, @LastItemAdded, @External_Link, @Can_Browse_Items, GETDATE(), @Include_In_Collection_Facet );
		
		-- Save the new id
		set @NewID = @@Identity;
		
		-- Was a parent id provided for this new aggreation?
		if ( isnull(@ParentID, -1 ) > 0 )
		begin		
			insert into SobekCM_Item_Aggregation_Hierarchy ( ParentID, ChildID )
			values ( @parentid, @NewID )
		end;
	end
	else
	begin
		-- update the existing information
		update SobekCM_Item_Aggregation
		set Code=@Code, Name=@Name, ShortName=@ShortName, [Description]=@Description, 
			ThematicHeadingID=@ThematicHeadingID, [Type]=@Type, isActive=@isActive, Hidden=@Hidden, 
			DisplayOptions=@DisplayOptions, Map_Search=@Map_Search, Map_Display=@Map_Display, 
			OAI_Flag=@OAI_Flag, OAI_Metadata=@OAI_Metadata, ContactEmail=@ContactEmail, 
			HasNewItems=@HasNewItems, DefaultInterface=@Default_Skin, 
			Items_Can_Be_Described=@Items_Can_Be_Described, LastItemAdded=@LastItemAdded, 
			External_Link=@External_Link, Can_Browse_Items=@Can_Browse_Items, 
			Include_In_Collection_Facet = @Include_In_Collection_Facet
		where AggregationID=@AggregationID;
		
		-- Just return the same id
		set @NewID = @AggregationID;
	end;
END;
GO


USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[Tracking_Get_Aggregation_Browse]    Script Date: 3/17/2022 9:28:34 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Return a single browse for a collection or group
-- This is identical to SobekCM_Get_Aggregation_Browse, EXCEPT:
--    (1) Title, Author, IP restriction flag, Thumbnail, and Publisher returned with item list
--    (2) Group title, thumbnail, type, OCLC, and ALEPH returned with title list
--    (3) No facets returned and both PRIVATE and PUBLIC items are returned in list
--    (4) Always returns all the items, not just NEW items
--    (5) All tracking information ( milestones, tracking box, etc..) returned in item list
CREATE PROCEDURE [dbo].[Tracking_Get_Aggregation_Browse]
	@code varchar(20)
AS
begin

	-- No need to perform any locks here, especially given the possible
	-- length of this search
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
	SET NOCOUNT ON;

	-- Create the temporary tables first
	-- Create the temporary table to hold all the item id's
	create table #TEMP_ITEMS ( BibID varchar(10), VID varchar(5), SortDate bigint, Spatial_KML varchar(4000), fk_TitleID int, Title nvarchar(500), IP_Restriction_Mask smallint, ItemID int, Hit_Count int, Author nvarchar(1000), Publisher nvarchar(1000), Thumbnail varchar(100), Internal_Comments nvarchar(1000), Dark bit, Last_MileStone int, Milestone_DigitalAcquisition datetime, Milestone_ImageProcessing datetime, Milestone_QualityControl datetime, Milestone_OnlineComplete datetime, Born_Digital bit, Material_Received_Date datetime, Disposition_Advice int, Disposition_Date datetime, Disposition_Type int, Locally_Archived bit, Remotely_Archived bit, Tracking_Box varchar(25), AggregationCodes varchar(100), Level1_Text nvarchar(255), Level1_Index int, Level2_Text nvarchar(255), Level2_Index int, Level3_Text nvarchar(255), Level3_Index int, Level4_Text nvarchar(255), Level4_Index int, Level5_Text nvarchar(255), Level5_Index int, SortTitle nvarchar(500), PubDate nvarchar(100))
	create table #TEMP_TITLES ( fk_TitleID int );

	-- Populate the temporary item list	
	insert into #TEMP_ITEMS ( BibID, VID, SortDate, Spatial_KML, fk_TitleID, Title, IP_Restriction_Mask, ItemID, Author, Publisher, Thumbnail, Internal_Comments, Dark, Last_MileStone, Milestone_DigitalAcquisition, Milestone_ImageProcessing, Milestone_QualityControl, Milestone_OnlineComplete, Born_Digital, Material_Received_Date, Disposition_Advice, Disposition_Date, Disposition_Type, Locally_Archived, Remotely_Archived, Tracking_Box, AggregationCodes, Level1_Text, Level1_Index, Level2_Text, Level2_Index, Level3_Text, Level3_Index, Level4_Text, Level4_Index, Level5_Text, Level5_Index, SortTitle, PubDate )
	select G.BibID, I.VID, isnull( I.SortDate,-1), isnull(Spatial_KML,''), I.GroupID, I.Title, I.IP_Restriction_Mask, I.ItemID, I.Author, I.Publisher, I.MainThumbnail, I.Internal_Comments, I.Dark, I.Last_MileStone, I.Milestone_DigitalAcquisition, I.Milestone_ImageProcessing, I.Milestone_QualityControl, I.Milestone_OnlineComplete, I.Born_Digital, I.Material_Received_Date, I.Disposition_Advice, I.Disposition_Date, I.Disposition_Type, I.Locally_Archived, I.Remotely_Archived, I.Tracking_Box, I.AggregationCodes, Level1_Text=isnull(Level1_Text,''), Level1_Index=isnull(Level1_Index,-1), Level2_Text=isnull(Level2_Text, ''), Level2_Index=isnull(Level2_Index, -1), Level3_Text=isnull(Level3_Text, ''), Level3_Index=isnull(Level3_Index, -1), Level4_Text=isnull(Level4_Text, ''), Level4_Index=isnull(Level4_Index, -1), Level5_Text=isnull(Level5_Text, ''), Level5_Index=isnull(Level5_Index,-1), SortTitle=ISNULL(I.SortTitle, UPPER(Title)), I.PubDate
	from SobekCM_Item I, SobekCM_Item_Aggregation_Item_Link CL, SobekCM_Item_Aggregation C, SobekCM_Item_Group G
	where ( CL.ItemID = I.ItemID )
	  and ( CL.AggregationID = C.AggregationID )
	  and ( C.Code = @code )
	  and ( I.Deleted = CONVERT(bit,0) )
	  and ( I.GroupID = G.GroupID );
		
	-- Select the title information
	insert into #TEMP_TITLES ( fk_TitleID )
	select distinct(fk_TitleID)
	from #TEMP_ITEMS I
	group by fk_TitleID;

	-- Return the item informaiton
	select BibID, VID, SortDate, Spatial_KML, fk_TitleID, Title, Author, Publisher, Level1_Text, Level1_Index, Level2_Text, Level2_Index, Level3_Text, Level3_Index, Level4_Text, Level4_Index, Level5_Text, Level5_Index, IP_Restriction_Mask, Thumbnail, Internal_Comments, Dark, Last_MileStone, Milestone_DigitalAcquisition, Milestone_ImageProcessing, Milestone_QualityControl, Milestone_OnlineComplete, Born_Digital, Material_Received_Date, isnull(DAT.DispositionFuture,'') AS Disposition_Advice, Disposition_Date, isnull(DT.DispositionPast,'') AS Disposition_Type, Locally_Archived, Remotely_Archived, Tracking_Box, AggregationCodes, ItemID, SortTitle, PubDate
	from #TEMP_ITEMS AS T left outer join
		 Tracking_Disposition_Type AS DAT ON T.Disposition_Advice=DAT.DispositionID left outer join
		 Tracking_Disposition_Type AS DT ON T.Disposition_Type=DT.DispositionID;

	-- Return the title information
	select G.BibID, G.SortTitle, TitleID=G.GroupID, [Rank]=-1, G.GroupTitle, G.GroupThumbnail, G.[Type], G.ALEPH_Number, G.OCLC_Number, isnull(G.Primary_Identifier_Type,'') as Primary_Identifier_Type, isnull(G.Primary_Identifier, '') as Primary_Identifier
	from SobekCM_Item_Group G, #TEMP_TITLES I
	where  G.GroupID = I.fk_TitleID;
	
	-- drop the temporary tables
	drop table #TEMP_ITEMS;
	drop table #TEMP_TITLES;
			
    Set NoCount OFF;

end;
GO


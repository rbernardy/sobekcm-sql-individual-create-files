USE [sobektest]
GO

/****** Object:  Table [dbo].[SobekCM_Metadata_Basic_Search_Table]    Script Date: 1/9/2022 1:17:20 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table](
	[ItemID] [int] NOT NULL,
	[FullCitation] [nvarchar](max) NOT NULL,
	[Title] [nvarchar](max) NOT NULL,
	[Type] [nvarchar](max) NOT NULL,
	[Language] [nvarchar](max) NOT NULL,
	[Creator] [nvarchar](max) NOT NULL,
	[Publisher] [nvarchar](max) NOT NULL,
	[Publication_Place] [nvarchar](max) NOT NULL,
	[Subject_Keyword] [nvarchar](max) NOT NULL,
	[Genre] [nvarchar](max) NOT NULL,
	[Target_Audience] [nvarchar](max) NOT NULL,
	[Spatial_Coverage] [nvarchar](max) NOT NULL,
	[Country] [nvarchar](max) NOT NULL,
	[State] [nvarchar](max) NOT NULL,
	[County] [nvarchar](max) NOT NULL,
	[City] [nvarchar](max) NOT NULL,
	[Source_Institution] [nvarchar](max) NOT NULL,
	[Holding_Location] [nvarchar](max) NOT NULL,
	[Identifier] [nvarchar](max) NOT NULL,
	[Notes] [nvarchar](max) NOT NULL,
	[Other_Citation] [nvarchar](max) NOT NULL,
	[Tickler] [nvarchar](max) NOT NULL,
	[Donor] [nvarchar](max) NOT NULL,
	[Format] [nvarchar](max) NOT NULL,
	[BibID] [nvarchar](max) NOT NULL,
	[Publication_Date] [nvarchar](max) NOT NULL,
	[Affiliation] [nvarchar](max) NOT NULL,
	[Frequency] [nvarchar](max) NOT NULL,
	[Name_as_Subject] [nvarchar](max) NOT NULL,
	[Title_as_Subject] [nvarchar](max) NOT NULL,
	[All_Subjects] [nvarchar](max) NOT NULL,
	[Temporal_Subject] [nvarchar](max) NOT NULL,
	[Attribution] [nvarchar](max) NOT NULL,
	[User_Description] [nvarchar](max) NOT NULL,
	[Temporal_Decade] [nvarchar](max) NOT NULL,
	[MIME_Type] [nvarchar](max) NOT NULL,
	[Tracking_Box] [nvarchar](max) NOT NULL,
	[Abstract] [nvarchar](max) NOT NULL,
	[Edition] [nvarchar](max) NOT NULL,
	[TOC] [nvarchar](max) NOT NULL,
	[ZT_Kingdom] [nvarchar](max) NOT NULL,
	[ZT_Phylum] [nvarchar](max) NOT NULL,
	[ZT_Class] [nvarchar](max) NOT NULL,
	[ZT_Order] [nvarchar](max) NOT NULL,
	[ZT_Family] [nvarchar](max) NOT NULL,
	[ZT_Genus] [nvarchar](max) NOT NULL,
	[ZT_Species] [nvarchar](max) NOT NULL,
	[ZT_Common_Name] [nvarchar](max) NOT NULL,
	[ZT_Scientific_Name] [nvarchar](max) NOT NULL,
	[ZT_All_Taxonomy] [nvarchar](max) NOT NULL,
	[Cultural_Context] [nvarchar](max) NOT NULL,
	[Inscription] [nvarchar](max) NOT NULL,
	[Material] [nvarchar](max) NOT NULL,
	[Style_Period] [nvarchar](max) NOT NULL,
	[Technique] [nvarchar](max) NOT NULL,
	[Accession_Number] [nvarchar](max) NOT NULL,
	[Interviewee] [nvarchar](max) NOT NULL,
	[Interviewer] [nvarchar](max) NOT NULL,
	[Temporal_Year] [nvarchar](max) NOT NULL,
	[ETD_Committee] [nvarchar](max) NOT NULL,
	[ETD_Degree] [nvarchar](max) NOT NULL,
	[ETD_Degree_Discipline] [nvarchar](max) NOT NULL,
	[ETD_Degree_Grantor] [nvarchar](max) NOT NULL,
	[ETD_Degree_Level] [nvarchar](max) NOT NULL,
	[UserDefined01] [nvarchar](max) NOT NULL,
	[UserDefined02] [nvarchar](max) NOT NULL,
	[UserDefined03] [nvarchar](max) NOT NULL,
	[UserDefined04] [nvarchar](max) NOT NULL,
	[UserDefined05] [nvarchar](max) NOT NULL,
	[UserDefined06] [nvarchar](max) NOT NULL,
	[UserDefined07] [nvarchar](max) NOT NULL,
	[UserDefined08] [nvarchar](max) NOT NULL,
	[UserDefined09] [nvarchar](max) NOT NULL,
	[UserDefined10] [nvarchar](max) NOT NULL,
	[UserDefined11] [nvarchar](max) NOT NULL,
	[UserDefined12] [nvarchar](max) NOT NULL,
	[UserDefined13] [nvarchar](max) NOT NULL,
	[UserDefined14] [nvarchar](max) NOT NULL,
	[UserDefined15] [nvarchar](max) NOT NULL,
	[UserDefined16] [nvarchar](max) NOT NULL,
	[UserDefined17] [nvarchar](max) NOT NULL,
	[UserDefined18] [nvarchar](max) NOT NULL,
	[UserDefined19] [nvarchar](max) NOT NULL,
	[UserDefined20] [nvarchar](max) NOT NULL,
	[UserDefined21] [nvarchar](max) NOT NULL,
	[UserDefined22] [nvarchar](max) NOT NULL,
	[UserDefined23] [nvarchar](max) NOT NULL,
	[UserDefined24] [nvarchar](max) NOT NULL,
	[UserDefined25] [nvarchar](max) NOT NULL,
	[UserDefined26] [nvarchar](max) NOT NULL,
	[UserDefined27] [nvarchar](max) NOT NULL,
	[UserDefined28] [nvarchar](max) NOT NULL,
	[UserDefined29] [nvarchar](max) NOT NULL,
	[UserDefined30] [nvarchar](max) NOT NULL,
	[UserDefined31] [nvarchar](max) NOT NULL,
	[UserDefined32] [nvarchar](max) NOT NULL,
	[UserDefined33] [nvarchar](max) NOT NULL,
	[UserDefined34] [nvarchar](max) NOT NULL,
	[UserDefined35] [nvarchar](max) NOT NULL,
	[UserDefined36] [nvarchar](max) NOT NULL,
	[UserDefined37] [nvarchar](max) NOT NULL,
	[UserDefined38] [nvarchar](max) NOT NULL,
	[UserDefined39] [nvarchar](max) NOT NULL,
	[UserDefined40] [nvarchar](max) NOT NULL,
	[UserDefined41] [nvarchar](max) NOT NULL,
	[UserDefined42] [nvarchar](max) NOT NULL,
	[UserDefined43] [nvarchar](max) NOT NULL,
	[UserDefined44] [nvarchar](max) NOT NULL,
	[UserDefined45] [nvarchar](max) NOT NULL,
	[UserDefined46] [nvarchar](max) NOT NULL,
	[UserDefined47] [nvarchar](max) NOT NULL,
	[UserDefined48] [nvarchar](max) NOT NULL,
	[UserDefined49] [nvarchar](max) NOT NULL,
	[UserDefined50] [nvarchar](max) NOT NULL,
	[UserDefined51] [nvarchar](max) NOT NULL,
	[UserDefined52] [nvarchar](max) NOT NULL,
	[Publisher.Display] [nvarchar](max) NOT NULL,
	[Spatial_Coverage.Display] [nvarchar](max) NOT NULL,
	[Measurements] [nvarchar](max) NOT NULL,
	[Subjects.Display] [nvarchar](max) NOT NULL,
	[Aggregations] [nvarchar](max) NOT NULL,
	[LOM_Aggregation] [nvarchar](max) NOT NULL,
	[LOM_Context] [nvarchar](max) NOT NULL,
	[LOM_Classification] [nvarchar](max) NOT NULL,
	[LOM_Difficulty] [nvarchar](max) NOT NULL,
	[LOM_Intended_End_User] [nvarchar](max) NOT NULL,
	[LOM_Interactivity_Level] [nvarchar](max) NOT NULL,
	[LOM_Interactivity_Type] [nvarchar](max) NOT NULL,
	[LOM_Status] [nvarchar](max) NOT NULL,
	[LOM_Requirement] [nvarchar](max) NOT NULL,
	[LOM_AgeRange] [nvarchar](max) NOT NULL,
	[ETD_Degree_Division] [nvarchar](max) NOT NULL,
	[SortDate] [bigint] NOT NULL,
 CONSTRAINT [PK_SobekCM_Metadata_Basic_Search_Table] PRIMARY KEY CLUSTERED 
(
	[ItemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [Title]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [Type]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [Language]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [Creator]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [Publisher]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [Publication_Place]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [Subject_Keyword]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [Genre]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [Target_Audience]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [Spatial_Coverage]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [Country]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [State]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [County]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [City]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [Source_Institution]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [Holding_Location]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [Identifier]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [Notes]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [Other_Citation]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [Tickler]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [Donor]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [Format]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [BibID]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [Publication_Date]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [Affiliation]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [Frequency]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [Name_as_Subject]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [Title_as_Subject]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [All_Subjects]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [Temporal_Subject]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [Attribution]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [User_Description]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [Temporal_Decade]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [MIME_Type]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [Tracking_Box]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [Abstract]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [Edition]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [TOC]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [ZT_Kingdom]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [ZT_Phylum]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [ZT_Class]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [ZT_Order]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [ZT_Family]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [ZT_Genus]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [ZT_Species]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [ZT_Common_Name]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [ZT_Scientific_Name]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [ZT_All_Taxonomy]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [Cultural_Context]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [Inscription]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [Material]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [Style_Period]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [Technique]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [Accession_Number]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [Interviewee]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [Interviewer]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [Temporal_Year]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [ETD_Committee]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [ETD_Degree]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [ETD_Degree_Discipline]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [ETD_Degree_Grantor]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [ETD_Degree_Level]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [UserDefined01]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [UserDefined02]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [UserDefined03]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [UserDefined04]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [UserDefined05]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [UserDefined06]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [UserDefined07]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [UserDefined08]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [UserDefined09]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [UserDefined10]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [UserDefined11]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [UserDefined12]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [UserDefined13]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [UserDefined14]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [UserDefined15]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [UserDefined16]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [UserDefined17]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [UserDefined18]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [UserDefined19]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [UserDefined20]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [UserDefined21]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [UserDefined22]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [UserDefined23]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [UserDefined24]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [UserDefined25]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [UserDefined26]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [UserDefined27]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [UserDefined28]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [UserDefined29]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [UserDefined30]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [UserDefined31]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [UserDefined32]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [UserDefined33]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [UserDefined34]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [UserDefined35]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [UserDefined36]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [UserDefined37]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [UserDefined38]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [UserDefined39]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [UserDefined40]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [UserDefined41]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [UserDefined42]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [UserDefined43]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [UserDefined44]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [UserDefined45]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [UserDefined46]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [UserDefined47]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [UserDefined48]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [UserDefined49]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [UserDefined50]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [UserDefined51]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [UserDefined52]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [Publisher.Display]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [Spatial_Coverage.Display]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [Measurements]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [Subjects.Display]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [Aggregations]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [LOM_Aggregation]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [LOM_Context]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [LOM_Classification]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [LOM_Difficulty]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [LOM_Intended_End_User]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [LOM_Interactivity_Level]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [LOM_Interactivity_Type]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [LOM_Status]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [LOM_Requirement]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [LOM_AgeRange]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ('') FOR [ETD_Degree_Division]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] ADD  DEFAULT ((-1)) FOR [SortDate]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table]  WITH CHECK ADD  CONSTRAINT [FK_SobekCM_Metadata_Basic_Search_Table_SobekCM_Item] FOREIGN KEY([ItemID])
REFERENCES [dbo].[SobekCM_Item] ([ItemID])
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Basic_Search_Table] CHECK CONSTRAINT [FK_SobekCM_Metadata_Basic_Search_Table_SobekCM_Item]
GO


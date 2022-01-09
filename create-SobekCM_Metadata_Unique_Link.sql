USE [sobektest]
GO

/****** Object:  Table [dbo].[SobekCM_Metadata_Unique_Link]    Script Date: 1/9/2022 1:58:05 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[SobekCM_Metadata_Unique_Link](
	[ItemID] [int] NOT NULL,
	[MetadataID] [bigint] NOT NULL,
 CONSTRAINT [PK_SobekCM_Metadata_Unique_Link] PRIMARY KEY CLUSTERED 
(
	[ItemID] ASC,
	[MetadataID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Unique_Link]  WITH CHECK ADD  CONSTRAINT [FK_SobekCM_Metadata_Unique_Link_SobekCM_Item] FOREIGN KEY([ItemID])
REFERENCES [dbo].[SobekCM_Item] ([ItemID])
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Unique_Link] CHECK CONSTRAINT [FK_SobekCM_Metadata_Unique_Link_SobekCM_Item]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Unique_Link]  WITH CHECK ADD  CONSTRAINT [FK_SobekCM_Metadata_Unique_Link_SobekCM_Metadata_Unique_Search_Table] FOREIGN KEY([MetadataID])
REFERENCES [dbo].[SobekCM_Metadata_Unique_Search_Table] ([MetadataID])
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Unique_Link] CHECK CONSTRAINT [FK_SobekCM_Metadata_Unique_Link_SobekCM_Metadata_Unique_Search_Table]
GO


USE [sobektest]
GO

/****** Object:  Table [dbo].[Tracking_Archive_Item_Link]    Script Date: 1/5/2022 8:59:09 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Tracking_Archive_Item_Link](
	[ArchiveMediaID] [int] NOT NULL,
	[ItemID] [int] NOT NULL,
	[FileRangeOnCD] [varchar](1200) NULL,
	[Images] [int] NULL,
	[ImageSize_KB] [float] NULL,
 CONSTRAINT [PK_CS_Archive_Volume_Link] PRIMARY KEY CLUSTERED 
(
	[ArchiveMediaID] ASC,
	[ItemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Tracking_Archive_Item_Link]  WITH NOCHECK ADD  CONSTRAINT [FK_Archive_Item_Link_ArchiveMedia] FOREIGN KEY([ArchiveMediaID])
REFERENCES [dbo].[Tracking_ArchiveMedia] ([ArchiveMediaID])
GO

ALTER TABLE [dbo].[Tracking_Archive_Item_Link] CHECK CONSTRAINT [FK_Archive_Item_Link_ArchiveMedia]
GO

ALTER TABLE [dbo].[Tracking_Archive_Item_Link]  WITH NOCHECK ADD  CONSTRAINT [FK_Archive_Item_Link_Item] FOREIGN KEY([ItemID])
REFERENCES [dbo].[SobekCM_Item] ([ItemID])
GO

ALTER TABLE [dbo].[Tracking_Archive_Item_Link] CHECK CONSTRAINT [FK_Archive_Item_Link_Item]
GO


USE [sobektest]
GO

/****** Object:  Table [dbo].[Tivoli_File_Log]    Script Date: 1/4/2022 11:46:05 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Tivoli_File_Log](
	[FileID] [bigint] IDENTITY(1,1) NOT NULL,
	[BibID] [char](10) NOT NULL,
	[VID] [char](5) NOT NULL,
	[Folder] [varchar](250) NOT NULL,
	[FileName] [varchar](100) NOT NULL,
	[Size] [bigint] NOT NULL,
	[LastWriteDate] [datetime] NOT NULL,
	[ArchiveDate] [datetime] NOT NULL,
	[ArchiveYear] [smallint] NOT NULL,
	[ArchiveMonth] [smallint] NOT NULL,
	[ItemID] [int] NOT NULL,
	[DeleteMsg] [varchar](1000) NULL,
	[SHA1_Checksum] [nvarchar](250) NOT NULL,
	[Original_FileName] [varchar](100) NOT NULL,
 CONSTRAINT [PK_Tivoli_File_Log] PRIMARY KEY CLUSTERED 
(
	[FileID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Tivoli_File_Log] ADD  DEFAULT ((-1)) FOR [ArchiveYear]
GO

ALTER TABLE [dbo].[Tivoli_File_Log] ADD  DEFAULT ((-1)) FOR [ArchiveMonth]
GO

ALTER TABLE [dbo].[Tivoli_File_Log] ADD  DEFAULT ((-1)) FOR [ItemID]
GO

ALTER TABLE [dbo].[Tivoli_File_Log] ADD  DEFAULT ('') FOR [SHA1_Checksum]
GO

ALTER TABLE [dbo].[Tivoli_File_Log] ADD  DEFAULT ('') FOR [Original_FileName]
GO


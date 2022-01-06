USE [sobektest]
GO

/****** Object:  Table [dbo].[Tracking_ArchiveMedia]    Script Date: 1/5/2022 9:11:30 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Tracking_ArchiveMedia](
	[ArchiveMediaID] [int] NOT NULL,
	[ArchiveNumber] [int] NOT NULL,
	[DateSorted] [datetime] NULL,
	[ArchiveSerialNum] [varchar](50) NULL,
 CONSTRAINT [PK_CS_CD] PRIMARY KEY NONCLUSTERED 
(
	[ArchiveMediaID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_CS_ArchiveMedia] UNIQUE NONCLUSTERED 
(
	[ArchiveNumber] ASC,
	[ArchiveSerialNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


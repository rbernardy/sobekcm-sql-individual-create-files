USE [sobektest]
GO

/****** Object:  Table [dbo].[SobekCM_Source_Line]    Script Date: 1/6/2022 9:08:24 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[SobekCM_Source_Line](
	[SourceLineID] [int] IDENTITY(1,1) NOT NULL,
	[SourceLine] [varchar](500) NULL,
	[ItemID] [int] NULL,
	[PageSequence] [int] NULL,
 CONSTRAINT [PK_SobekCM_Source_Line] PRIMARY KEY CLUSTERED 
(
	[SourceLineID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO


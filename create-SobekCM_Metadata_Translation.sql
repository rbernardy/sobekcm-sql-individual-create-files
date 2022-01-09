USE [sobektest]
GO

/****** Object:  Table [dbo].[SobekCM_Metadata_Translation]    Script Date: 1/9/2022 1:13:39 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[SobekCM_Metadata_Translation](
	[TranslationID] [int] IDENTITY(1,1) NOT NULL,
	[English] [varchar](50) NOT NULL,
	[French] [varchar](50) NOT NULL,
	[Spanish] [varchar](50) NOT NULL,
 CONSTRAINT [PK_SobekCM_Metadata_Translation] PRIMARY KEY CLUSTERED 
(
	[TranslationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO


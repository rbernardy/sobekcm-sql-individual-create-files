USE [sobektest]
GO

/****** Object:  Table [dbo].[SobekCM_Search_Stop_Words]    Script Date: 1/9/2022 8:04:05 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[SobekCM_Search_Stop_Words](
	[StopWordId] [int] IDENTITY(1,1) NOT NULL,
	[StopWord] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_SobekCM_Search_Stop_Words] PRIMARY KEY CLUSTERED 
(
	[StopWordId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


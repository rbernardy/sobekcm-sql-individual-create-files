USE [sobektest]
GO

/****** Object:  Table [dbo].[SobekCM_Thematic_Heading]    Script Date: 1/6/2022 9:15:34 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[SobekCM_Thematic_Heading](
	[ThematicHeadingID] [int] IDENTITY(1,1) NOT NULL,
	[ThemeOrder] [int] NOT NULL,
	[ThemeName] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_SobekCM_Thematic_Heading] PRIMARY KEY CLUSTERED 
(
	[ThematicHeadingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


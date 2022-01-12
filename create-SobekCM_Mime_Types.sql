USE [sobektest]
GO

/****** Object:  Table [dbo].[SobekCM_Mime_Types]    Script Date: 1/11/2022 10:57:15 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[SobekCM_Mime_Types](
	[MimeTypeID] [int] IDENTITY(1,1) NOT NULL,
	[Extension] [varchar](20) NOT NULL,
	[MimeType] [varchar](100) NOT NULL,
	[isBlocked] [bit] NOT NULL,
	[shouldForward] [bit] NOT NULL,
 CONSTRAINT [PK_SobekCM_Mime_Types] PRIMARY KEY CLUSTERED 
(
	[MimeTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


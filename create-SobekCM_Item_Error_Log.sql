USE [sobektest]
GO

/****** Object:  Table [dbo].[SobekCM_Item_Error_Log]    Script Date: 1/9/2022 9:40:27 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[SobekCM_Item_Error_Log](
	[ItemErrorID] [int] IDENTITY(1,1) NOT NULL,
	[BibID] [varchar](50) NOT NULL,
	[VID] [varchar](5) NOT NULL,
	[ErrorDescription] [varchar](1000) NOT NULL,
	[Date] [datetime] NOT NULL,
	[METS_Type] [varchar](20) NULL,
	[ClearedBy] [varchar](100) NULL,
	[ClearedDate] [datetime] NULL,
 CONSTRAINT [PK_SobekCM_Item_Error_Log] PRIMARY KEY CLUSTERED 
(
	[ItemErrorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


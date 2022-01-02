USE [sobekexample]
GO

/****** Object:  Table [dbo].[mySobek_Editable_Regex]    Script Date: 1/2/2022 1:30:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[mySobek_Editable_Regex](
	[EditableID] [int] IDENTITY(1,1) NOT NULL,
	[Editable_Name] [varchar](250) NOT NULL,
	[EditableRegex] [varchar](max) NOT NULL,
 CONSTRAINT [PK_UFDC_Editable_Regex] PRIMARY KEY CLUSTERED 
(
	[EditableID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO


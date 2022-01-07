USE [sobektest]
GO

/****** Object:  Table [dbo].[SobekCM_External_Record_Type]    Script Date: 1/6/2022 8:30:32 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[SobekCM_External_Record_Type](
	[ExtRecordTypeID] [int] IDENTITY(1,1) NOT NULL,
	[ExtRecordType] [varchar](25) NOT NULL,
	[repeatableTypeFlag] [bit] NOT NULL,
 CONSTRAINT [PK_External_Record_Type] PRIMARY KEY CLUSTERED 
(
	[ExtRecordTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_ExtRecordType] UNIQUE NONCLUSTERED 
(
	[ExtRecordType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[SobekCM_External_Record_Type] ADD  CONSTRAINT [DF_External_Record_Type_singleValueFlag]  DEFAULT ((0)) FOR [repeatableTypeFlag]
GO


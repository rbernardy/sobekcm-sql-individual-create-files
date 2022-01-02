USE [sobekexample]
GO

/****** Object:  Table [dbo].[SobekCM_Builder_Module_Type]    Script Date: 1/2/2022 12:32:53 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[SobekCM_Builder_Module_Type](
	[ModuleTypeID] [int] IDENTITY(1,1) NOT NULL,
	[TypeAbbrev] [varchar](4) NOT NULL,
	[TypeDescription] [varchar](200) NOT NULL,
 CONSTRAINT [PK_SobekCM_Builder_Module_Types] PRIMARY KEY CLUSTERED 
(
	[ModuleTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


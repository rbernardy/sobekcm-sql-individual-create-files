USE [sobektest]
GO

/****** Object:  Table [dbo].[SobekCM_Metadata_Types]    Script Date: 1/9/2022 1:35:24 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[SobekCM_Metadata_Types](
	[MetadataTypeID] [smallint] IDENTITY(1,1) NOT NULL,
	[MetadataName] [varchar](100) NOT NULL,
	[SobekCode] [char](2) NULL,
	[SolrCode] [varchar](100) NULL,
	[DisplayTerm] [nvarchar](100) NULL,
	[FacetTerm] [varchar](100) NULL,
	[CustomField] [bit] NOT NULL,
	[canFacetBrowse] [bit] NOT NULL,
	[DefaultAdvancedSearch] [bit] NOT NULL,
	[LegacySolrCode] [varchar](100) NULL,
	[SolrCode_Facets] [varchar](100) NULL,
	[SolrCode_Display] [varchar](100) NULL,
 CONSTRAINT [PK_SobekCM_Metadata_Types] PRIMARY KEY CLUSTERED 
(
	[MetadataTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Types] ADD  DEFAULT ('false') FOR [CustomField]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Types] ADD  DEFAULT ('true') FOR [canFacetBrowse]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Types] ADD  DEFAULT ('false') FOR [DefaultAdvancedSearch]
GO


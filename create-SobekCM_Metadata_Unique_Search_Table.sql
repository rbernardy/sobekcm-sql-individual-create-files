USE [sobektest]
GO

/****** Object:  Table [dbo].[SobekCM_Metadata_Unique_Search_Table]    Script Date: 1/9/2022 7:31:23 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[SobekCM_Metadata_Unique_Search_Table](
	[MetadataID] [bigint] IDENTITY(1,1) NOT NULL,
	[MetadataTypeID] [smallint] NOT NULL,
	[MetadataValue] [nvarchar](max) NOT NULL,
	[MetadataValueStart] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_SobekCM_Metadata_Unique_Search_Table] PRIMARY KEY CLUSTERED 
(
	[MetadataID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Unique_Search_Table]  WITH CHECK ADD  CONSTRAINT [FK_SobekCM_Metadata_Unique_Metadata_Types] FOREIGN KEY([MetadataTypeID])
REFERENCES [dbo].[SobekCM_Metadata_Types] ([MetadataTypeID])
GO

ALTER TABLE [dbo].[SobekCM_Metadata_Unique_Search_Table] CHECK CONSTRAINT [FK_SobekCM_Metadata_Unique_Metadata_Types]
GO


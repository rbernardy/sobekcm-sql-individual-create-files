USE [sobektest]
GO

/****** Object:  Table [dbo].[SobekCM_Project_DefaultMetadata_Link]    Script Date: 1/6/2022 10:22:28 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[SobekCM_Project_DefaultMetadata_Link](
	[ProjectID] [int] NOT NULL,
	[DefaultMetadataID] [int] NOT NULL,
 CONSTRAINT [PK_SobekCM_Project_DefaultMetadata_Link] PRIMARY KEY CLUSTERED 
(
	[ProjectID] ASC,
	[DefaultMetadataID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[SobekCM_Project_DefaultMetadata_Link]  WITH CHECK ADD  CONSTRAINT [FK_DefaultMetadata] FOREIGN KEY([DefaultMetadataID])
REFERENCES [dbo].[mySobek_DefaultMetadata] ([DefaultMetadataID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[SobekCM_Project_DefaultMetadata_Link] CHECK CONSTRAINT [FK_DefaultMetadata]
GO

ALTER TABLE [dbo].[SobekCM_Project_DefaultMetadata_Link]  WITH CHECK ADD  CONSTRAINT [FK_Project] FOREIGN KEY([ProjectID])
REFERENCES [dbo].[SobekCM_Project] ([ProjectID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[SobekCM_Project_DefaultMetadata_Link] CHECK CONSTRAINT [FK_Project]
GO


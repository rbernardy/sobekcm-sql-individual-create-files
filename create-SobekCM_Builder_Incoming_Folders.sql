USE [sobekexample]
GO

/****** Object:  Table [dbo].[SobekCM_Builder_Incoming_Folders]    Script Date: 1/2/2022 11:43:17 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[SobekCM_Builder_Incoming_Folders](
	[IncomingFolderId] [int] IDENTITY(1,1) NOT NULL,
	[NetworkFolder] [varchar](255) NOT NULL,
	[ErrorFolder] [varchar](255) NOT NULL,
	[ProcessingFolder] [varchar](255) NOT NULL,
	[Perform_Checksum_Validation] [bit] NOT NULL,
	[Archive_TIFF] [bit] NOT NULL,
	[Archive_All_Files] [bit] NOT NULL,
	[Allow_Deletes] [bit] NOT NULL,
	[Allow_Folders_No_Metadata] [bit] NOT NULL,
	[Allow_Metadata_Updates] [bit] NOT NULL,
	[FolderName] [nvarchar](150) NOT NULL,
	[Can_Move_To_Content_Folder] [bit] NULL,
	[BibID_Roots_Restrictions] [varchar](255) NOT NULL,
	[ModuleSetID] [int] NULL,
 CONSTRAINT [PK_Builder_Incoming_Folders] PRIMARY KEY CLUSTERED 
(
	[IncomingFolderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[SobekCM_Builder_Incoming_Folders] ADD  DEFAULT ('') FOR [FolderName]
GO

ALTER TABLE [dbo].[SobekCM_Builder_Incoming_Folders] ADD  DEFAULT ('') FOR [BibID_Roots_Restrictions]
GO

ALTER TABLE [dbo].[SobekCM_Builder_Incoming_Folders]  WITH CHECK ADD  CONSTRAINT [FK_SobekCM_Builder_Incoming_Folders_SobekCM_Builder_Module_Set] FOREIGN KEY([ModuleSetID])
REFERENCES [dbo].[SobekCM_Builder_Module_Set] ([ModuleSetID])
GO

ALTER TABLE [dbo].[SobekCM_Builder_Incoming_Folders] CHECK CONSTRAINT [FK_SobekCM_Builder_Incoming_Folders_SobekCM_Builder_Module_Set]
GO


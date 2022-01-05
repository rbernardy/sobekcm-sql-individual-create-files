USE [sobekexample]
GO

/****** Object:  Table [dbo].[mySobek_User_DefaultMetadata_Link]    Script Date: 1/4/2022 8:29:15 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[mySobek_User_DefaultMetadata_Link](
	[UserID] [int] NOT NULL,
	[DefaultMetadataID] [int] NOT NULL,
	[CurrentlySelected] [bit] NOT NULL,
 CONSTRAINT [PK_mySobek_User_DefaultMetadata_Link] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC,
	[DefaultMetadataID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[mySobek_User_DefaultMetadata_Link]  WITH CHECK ADD  CONSTRAINT [FK_mysobek_user_DefaultMetadata_Link_sobek_user] FOREIGN KEY([UserID])
REFERENCES [dbo].[mySobek_User] ([UserID])
GO

ALTER TABLE [dbo].[mySobek_User_DefaultMetadata_Link] CHECK CONSTRAINT [FK_mysobek_user_DefaultMetadata_Link_sobek_user]
GO

ALTER TABLE [dbo].[mySobek_User_DefaultMetadata_Link]  WITH CHECK ADD  CONSTRAINT [FK_sobek_user_DefaultMetadata_Link] FOREIGN KEY([DefaultMetadataID])
REFERENCES [dbo].[mySobek_DefaultMetadata] ([DefaultMetadataID])
GO

ALTER TABLE [dbo].[mySobek_User_DefaultMetadata_Link] CHECK CONSTRAINT [FK_sobek_user_DefaultMetadata_Link]
GO


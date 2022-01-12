USE [sobektest]
GO

/****** Object:  Table [dbo].[mySobek_User_Group_DefaultMetadata_Link]    Script Date: 1/11/2022 9:34:24 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[mySobek_User_Group_DefaultMetadata_Link](
	[UserGroupID] [int] NOT NULL,
	[DefaultMetadataID] [int] NOT NULL,
 CONSTRAINT [PK_sobek_user_Group_DefaultMetadata_Link] PRIMARY KEY CLUSTERED 
(
	[UserGroupID] ASC,
	[DefaultMetadataID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[mySobek_User_Group_DefaultMetadata_Link]  WITH CHECK ADD  CONSTRAINT [FK_sobek_user_Group_DefaultMetadata_Link] FOREIGN KEY([DefaultMetadataID])
REFERENCES [dbo].[mySobek_DefaultMetadata] ([DefaultMetadataID])
GO

ALTER TABLE [dbo].[mySobek_User_Group_DefaultMetadata_Link] CHECK CONSTRAINT [FK_sobek_user_Group_DefaultMetadata_Link]
GO

ALTER TABLE [dbo].[mySobek_User_Group_DefaultMetadata_Link]  WITH CHECK ADD  CONSTRAINT [FK_sobek_user_Group_DefaultMetadata_Link_sobek_user] FOREIGN KEY([UserGroupID])
REFERENCES [dbo].[mySobek_User_Group] ([UserGroupID])
GO

ALTER TABLE [dbo].[mySobek_User_Group_DefaultMetadata_Link] CHECK CONSTRAINT [FK_sobek_user_Group_DefaultMetadata_Link_sobek_user]
GO


USE [sobekexample]
GO

/****** Object:  Table [dbo].[mySobek_User_Description_Tags]    Script Date: 1/2/2022 1:51:26 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[mySobek_User_Description_Tags](
	[TagID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[Description_Tag] [nvarchar](2000) NOT NULL,
	[Date_Modified] [datetime] NOT NULL,
	[ItemID] [int] NOT NULL,
 CONSTRAINT [PK_sobek_user_Description_Tags] PRIMARY KEY CLUSTERED 
(
	[TagID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[mySobek_User_Description_Tags] ADD  DEFAULT ((1)) FOR [ItemID]
GO

ALTER TABLE [dbo].[mySobek_User_Description_Tags]  WITH CHECK ADD  CONSTRAINT [FK_sobek_user_Description_Tags_sobek_user] FOREIGN KEY([UserID])
REFERENCES [dbo].[mySobek_User] ([UserID])
GO

ALTER TABLE [dbo].[mySobek_User_Description_Tags] CHECK CONSTRAINT [FK_sobek_user_Description_Tags_sobek_user]
GO

ALTER TABLE [dbo].[mySobek_User_Description_Tags]  WITH CHECK ADD  CONSTRAINT [FK_User_Description_Item] FOREIGN KEY([ItemID])
REFERENCES [dbo].[SobekCM_Item] ([ItemID])
GO

ALTER TABLE [dbo].[mySobek_User_Description_Tags] CHECK CONSTRAINT [FK_User_Description_Item]
GO


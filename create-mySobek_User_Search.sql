USE [sobekexample]
GO

/****** Object:  Table [dbo].[mySobek_User_Search]    Script Date: 1/4/2022 8:21:58 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[mySobek_User_Search](
	[UserSearchID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[SearchURL] [nvarchar](500) NOT NULL,
	[SearchDescription] [nvarchar](500) NOT NULL,
	[ItemOrder] [int] NOT NULL,
	[UserNotes] [nvarchar](2000) NOT NULL,
	[DateAdded] [datetime] NOT NULL,
 CONSTRAINT [PK_sobek_user_Search] PRIMARY KEY CLUSTERED 
(
	[UserSearchID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[mySobek_User_Search]  WITH CHECK ADD  CONSTRAINT [FK_sobek_user_Search_sobek_user] FOREIGN KEY([UserID])
REFERENCES [dbo].[mySobek_User] ([UserID])
GO

ALTER TABLE [dbo].[mySobek_User_Search] CHECK CONSTRAINT [FK_sobek_user_Search_sobek_user]
GO


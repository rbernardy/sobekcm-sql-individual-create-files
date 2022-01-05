USE [sobekexample]
GO

/****** Object:  Table [dbo].[mySobek_User_Settings]    Script Date: 1/4/2022 8:01:38 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[mySobek_User_Settings](
	[UserSettingID] [bigint] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[Setting_Key] [nvarchar](255) NOT NULL,
	[Setting_Value] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_mySobek_User_Settings] PRIMARY KEY CLUSTERED 
(
	[UserSettingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[mySobek_User_Settings]  WITH CHECK ADD  CONSTRAINT [FK_User_Settings_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[mySobek_User] ([UserID])
GO

ALTER TABLE [dbo].[mySobek_User_Settings] CHECK CONSTRAINT [FK_User_Settings_User]
GO


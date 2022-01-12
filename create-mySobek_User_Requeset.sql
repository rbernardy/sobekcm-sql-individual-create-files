USE [sobektest]
GO

/****** Object:  Table [dbo].[mySobek_User_Request]    Script Date: 1/11/2022 10:38:59 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[mySobek_User_Request](
	[UserRequestID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[UserGroupID] [int] NULL,
	[RequestDate] [datetime] NOT NULL,
	[RequestSubmitPermissions] [bit] NOT NULL,
	[RequestUrl] [nvarchar](255) NULL,
	[Pending] [bit] NOT NULL,
	[Approved] [bit] NOT NULL,
	[Notes] [nvarchar](2000) NULL,
	[ApproverUserID] [int] NULL,
 CONSTRAINT [PK_mySobek_User_Request] PRIMARY KEY CLUSTERED 
(
	[UserRequestID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[mySobek_User_Request]  WITH CHECK ADD  CONSTRAINT [FK_mySobek_User_Request_mySobek_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[mySobek_User] ([UserID])
GO

ALTER TABLE [dbo].[mySobek_User_Request] CHECK CONSTRAINT [FK_mySobek_User_Request_mySobek_User]
GO

ALTER TABLE [dbo].[mySobek_User_Request]  WITH CHECK ADD  CONSTRAINT [FK_mySobek_User_Request_mySobek_User_Group] FOREIGN KEY([UserGroupID])
REFERENCES [dbo].[mySobek_User_Group] ([UserGroupID])
GO

ALTER TABLE [dbo].[mySobek_User_Request] CHECK CONSTRAINT [FK_mySobek_User_Request_mySobek_User_Group]
GO

ALTER TABLE [dbo].[mySobek_User_Request]  WITH CHECK ADD  CONSTRAINT [FK_mySobek_User_Request_mySobek_User1] FOREIGN KEY([ApproverUserID])
REFERENCES [dbo].[mySobek_User] ([UserID])
GO

ALTER TABLE [dbo].[mySobek_User_Request] CHECK CONSTRAINT [FK_mySobek_User_Request_mySobek_User1]
GO


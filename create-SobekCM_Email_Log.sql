USE [sobekexample]
GO

/****** Object:  Table [dbo].[SobekCM_Email_Log]    Script Date: 1/4/2022 8:54:35 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[SobekCM_Email_Log](
	[EmailID] [int] IDENTITY(1,1) NOT NULL,
	[Sender] [varchar](255) NOT NULL,
	[Receipt_List] [varchar](500) NOT NULL,
	[Subject_Line] [varchar](500) NOT NULL,
	[Email_Body] [varchar](max) NOT NULL,
	[Sent_Date] [datetime] NOT NULL,
	[HTML_Format] [bit] NOT NULL,
	[Contact_Us] [bit] NOT NULL,
	[ReplyToEmailId] [int] NULL,
	[UserID] [int] NULL,
 CONSTRAINT [PK_SobekCM_Email_Log] PRIMARY KEY CLUSTERED 
(
	[EmailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[SobekCM_Email_Log] ADD  DEFAULT ('false') FOR [Contact_Us]
GO


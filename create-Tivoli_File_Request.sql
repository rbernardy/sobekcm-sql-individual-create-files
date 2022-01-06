USE [sobektest]
GO

/****** Object:  Table [dbo].[Tivoli_File_Request]    Script Date: 1/5/2022 8:33:40 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Tivoli_File_Request](
	[TivoliRequestId] [int] IDENTITY(1,1) NOT NULL,
	[Folder] [varchar](250) NOT NULL,
	[FileName] [varchar](100) NOT NULL,
	[UserName] [varchar](100) NOT NULL,
	[EmailAddress] [varchar](100) NOT NULL,
	[RequestNote] [nvarchar](1500) NOT NULL,
	[RequestDate] [date] NOT NULL,
	[Completed] [bit] NOT NULL,
	[CompleteDate] [date] NULL,
	[RequestFailed] [bit] NOT NULL,
	[ReplyEmailSubject] [nvarchar](250) NULL,
 CONSTRAINT [PK_Tivoli_File_Request] PRIMARY KEY CLUSTERED 
(
	[TivoliRequestId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Tivoli_File_Request] ADD  DEFAULT ('false') FOR [RequestFailed]
GO


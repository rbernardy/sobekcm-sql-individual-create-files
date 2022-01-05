USE [sobekexample]
GO

/****** Object:  Table [dbo].[SobekCM_IP_Restriction_Range]    Script Date: 1/4/2022 8:49:00 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[SobekCM_IP_Restriction_Range](
	[IP_RangeID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](150) NOT NULL,
	[Notes] [nvarchar](2000) NOT NULL,
	[Not_Valid_Statement] [nvarchar](max) NOT NULL,
	[Deleted] [bit] NOT NULL,
 CONSTRAINT [PK_SobekCM_IP_Restriction_Range] PRIMARY KEY CLUSTERED 
(
	[IP_RangeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[SobekCM_IP_Restriction_Range] ADD  DEFAULT ('false') FOR [Deleted]
GO


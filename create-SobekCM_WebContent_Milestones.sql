USE [sobektest]
GO

/****** Object:  Table [dbo].[SobekCM_WebContent_Milestones]    Script Date: 1/4/2022 9:49:06 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[SobekCM_WebContent_Milestones](
	[WebContentMilestoneID] [int] IDENTITY(1,1) NOT NULL,
	[WebContentID] [int] NOT NULL,
	[Milestone] [nvarchar](max) NOT NULL,
	[MilestoneDate] [datetime] NOT NULL,
	[MilestoneUser] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_SobekCM_WebContent_Milestones] PRIMARY KEY CLUSTERED 
(
	[WebContentMilestoneID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[SobekCM_WebContent_Milestones]  WITH CHECK ADD  CONSTRAINT [FK_SobekCM_WebContent_Milestones_SobekCM_WebContent] FOREIGN KEY([WebContentID])
REFERENCES [dbo].[SobekCM_WebContent] ([WebContentID])
GO

ALTER TABLE [dbo].[SobekCM_WebContent_Milestones] CHECK CONSTRAINT [FK_SobekCM_WebContent_Milestones_SobekCM_WebContent]
GO


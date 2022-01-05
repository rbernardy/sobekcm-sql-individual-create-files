USE [sobekexample]
GO

/****** Object:  Table [dbo].[mySobek_User_Item_Link_Relationship]    Script Date: 1/4/2022 7:50:15 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[mySobek_User_Item_Link_Relationship](
	[RelationshipID] [int] IDENTITY(1,1) NOT NULL,
	[RelationshipLabel] [nvarchar](50) NOT NULL,
	[Include_In_Results] [bit] NOT NULL,
 CONSTRAINT [PK_mySobek_User_Item_Link_Relationship] PRIMARY KEY CLUSTERED 
(
	[RelationshipID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[mySobek_User_Item_Link_Relationship] ADD  DEFAULT ('true') FOR [Include_In_Results]
GO


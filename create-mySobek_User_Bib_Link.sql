USE [sobekexample]
GO

/****** Object:  Table [dbo].[mySobek_User_Bib_Link]    Script Date: 1/2/2022 11:36:43 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[mySobek_User_Bib_Link](
	[UserID] [int] NOT NULL,
	[GroupID] [int] NOT NULL,
 CONSTRAINT [PK_mySobek_User_Bib_Link] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC,
	[GroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[mySobek_User_Bib_Link] ADD  DEFAULT ((1)) FOR [GroupID]
GO

ALTER TABLE [dbo].[mySobek_User_Bib_Link]  WITH CHECK ADD  CONSTRAINT [FK_User_Bib_Link_Item_Group] FOREIGN KEY([GroupID])
REFERENCES [dbo].[SobekCM_Item_Group] ([GroupID])
GO

ALTER TABLE [dbo].[mySobek_User_Bib_Link] CHECK CONSTRAINT [FK_User_Bib_Link_Item_Group]
GO


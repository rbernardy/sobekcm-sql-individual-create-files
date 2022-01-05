USE [sobektest]
GO

/****** Object:  Table [dbo].[SobekCM_Item_Group_Web_Skin_Link]    Script Date: 1/4/2022 10:56:39 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[SobekCM_Item_Group_Web_Skin_Link](
	[WebSkinID] [int] NOT NULL,
	[GroupID] [int] NOT NULL,
	[Sequence] [int] NOT NULL,
 CONSTRAINT [PK_Item_Group_Web_Skin_Link] PRIMARY KEY CLUSTERED 
(
	[WebSkinID] ASC,
	[GroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[SobekCM_Item_Group_Web_Skin_Link]  WITH CHECK ADD  CONSTRAINT [FK_Item_Group_Web_Skin_Link_Item_Group] FOREIGN KEY([GroupID])
REFERENCES [dbo].[SobekCM_Item_Group] ([GroupID])
GO

ALTER TABLE [dbo].[SobekCM_Item_Group_Web_Skin_Link] CHECK CONSTRAINT [FK_Item_Group_Web_Skin_Link_Item_Group]
GO

ALTER TABLE [dbo].[SobekCM_Item_Group_Web_Skin_Link]  WITH CHECK ADD  CONSTRAINT [FK_Item_Group_Web_Skin_Link_Web_Skin] FOREIGN KEY([WebSkinID])
REFERENCES [dbo].[SobekCM_Web_Skin] ([WebSkinID])
GO

ALTER TABLE [dbo].[SobekCM_Item_Group_Web_Skin_Link] CHECK CONSTRAINT [FK_Item_Group_Web_Skin_Link_Web_Skin]
GO


USE [sobektest]
GO

/****** Object:  Table [dbo].[SobekCM_Item_Group_Viewers]    Script Date: 1/13/2022 12:06:21 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[SobekCM_Item_Group_Viewers](
	[ItemGroupViewID] [int] IDENTITY(1,1) NOT NULL,
	[GroupID] [int] NOT NULL,
	[ItemGroupViewTypeID] [int] NOT NULL,
	[Attribute] [nvarchar](250) NOT NULL,
	[Label] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_SobekCM_Item_Group_Viewers] PRIMARY KEY CLUSTERED 
(
	[ItemGroupViewID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[SobekCM_Item_Group_Viewers]  WITH CHECK ADD  CONSTRAINT [FK_SobekCM_Item_Group_Viewers_Item_Group] FOREIGN KEY([GroupID])
REFERENCES [dbo].[SobekCM_Item_Group] ([GroupID])
GO

ALTER TABLE [dbo].[SobekCM_Item_Group_Viewers] CHECK CONSTRAINT [FK_SobekCM_Item_Group_Viewers_Item_Group]
GO

ALTER TABLE [dbo].[SobekCM_Item_Group_Viewers]  WITH CHECK ADD  CONSTRAINT [FK_SobekCM_Item_Group_Viewers_Viewer_Types] FOREIGN KEY([ItemGroupViewTypeID])
REFERENCES [dbo].[SobekCM_Item_Group_Viewer_Types] ([ItemGroupViewTypeID])
GO

ALTER TABLE [dbo].[SobekCM_Item_Group_Viewers] CHECK CONSTRAINT [FK_SobekCM_Item_Group_Viewers_Viewer_Types]
GO


USE [sobektest]
GO

/****** Object:  Table [dbo].[SobekCM_Item_Group_Relationship]    Script Date: 1/12/2022 11:47:54 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[SobekCM_Item_Group_Relationship](
	[GroupA] [int] NOT NULL,
	[GroupB] [int] NOT NULL,
	[Relationship_A_to_B] [nvarchar](100) NOT NULL,
	[Relationship_B_to_A] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_SobekCM_Item_Group_Relationship] PRIMARY KEY CLUSTERED 
(
	[GroupA] ASC,
	[GroupB] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[SobekCM_Item_Group_Relationship]  WITH CHECK ADD  CONSTRAINT [FK_SobekCM_Item_Group_Relationship_SobekCM_Item_Group] FOREIGN KEY([GroupA])
REFERENCES [dbo].[SobekCM_Item_Group] ([GroupID])
GO

ALTER TABLE [dbo].[SobekCM_Item_Group_Relationship] CHECK CONSTRAINT [FK_SobekCM_Item_Group_Relationship_SobekCM_Item_Group]
GO

ALTER TABLE [dbo].[SobekCM_Item_Group_Relationship]  WITH CHECK ADD  CONSTRAINT [FK_SobekCM_Item_Group_Relationship_SobekCM_Item_Group1] FOREIGN KEY([GroupB])
REFERENCES [dbo].[SobekCM_Item_Group] ([GroupID])
GO

ALTER TABLE [dbo].[SobekCM_Item_Group_Relationship] CHECK CONSTRAINT [FK_SobekCM_Item_Group_Relationship_SobekCM_Item_Group1]
GO


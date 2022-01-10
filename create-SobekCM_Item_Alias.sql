USE [sobektest]
GO

/****** Object:  Table [dbo].[SobekCM_Item_Alias]    Script Date: 1/9/2022 8:56:02 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[SobekCM_Item_Alias](
	[ItemAliasID] [int] IDENTITY(1,1) NOT NULL,
	[Alias] [varchar](50) NOT NULL,
	[ItemID] [int] NOT NULL,
 CONSTRAINT [PK_SobekCM_Item_Alias] PRIMARY KEY CLUSTERED 
(
	[ItemAliasID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[SobekCM_Item_Alias]  WITH CHECK ADD  CONSTRAINT [FK_SobekCM_Item_Alias_SobekCM_Item] FOREIGN KEY([ItemID])
REFERENCES [dbo].[SobekCM_Item] ([ItemID])
GO

ALTER TABLE [dbo].[SobekCM_Item_Alias] CHECK CONSTRAINT [FK_SobekCM_Item_Alias_SobekCM_Item]
GO


USE [sobektest]
GO

/****** Object:  Table [dbo].[SobekCM_Item_Icons]    Script Date: 1/9/2022 9:37:29 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[SobekCM_Item_Icons](
	[ItemID] [int] NOT NULL,
	[IconID] [int] NOT NULL,
	[Sequence] [int] NOT NULL,
 CONSTRAINT [PK_SobekCM_Item_Icons] PRIMARY KEY CLUSTERED 
(
	[ItemID] ASC,
	[IconID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[SobekCM_Item_Icons]  WITH NOCHECK ADD  CONSTRAINT [FK_UFDC_Item_Icons_UFDC_Icon] FOREIGN KEY([IconID])
REFERENCES [dbo].[SobekCM_Icon] ([IconID])
GO

ALTER TABLE [dbo].[SobekCM_Item_Icons] CHECK CONSTRAINT [FK_UFDC_Item_Icons_UFDC_Icon]
GO

ALTER TABLE [dbo].[SobekCM_Item_Icons]  WITH CHECK ADD  CONSTRAINT [FK_UFDC_Item_Icons_UFDC_Item] FOREIGN KEY([ItemID])
REFERENCES [dbo].[SobekCM_Item] ([ItemID])
GO

ALTER TABLE [dbo].[SobekCM_Item_Icons] CHECK CONSTRAINT [FK_UFDC_Item_Icons_UFDC_Item]
GO


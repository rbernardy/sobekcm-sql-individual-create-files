USE [sobektest]
GO

/****** Object:  Table [dbo].[SobekCM_Item_OAI]    Script Date: 2/1/2022 9:07:06 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[SobekCM_Item_OAI](
	[ItemID] [int] NOT NULL,
	[OAI_Data] [nvarchar](max) NOT NULL,
	[Locked] [bit] NOT NULL,
	[OAI_Date] [date] NULL,
	[Data_Code] [varchar](20) NOT NULL,
 CONSTRAINT [PK_SobekCM_Item_OAI] PRIMARY KEY CLUSTERED 
(
	[ItemID] ASC,
	[Data_Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[SobekCM_Item_OAI] ADD  DEFAULT ('false') FOR [Locked]
GO

ALTER TABLE [dbo].[SobekCM_Item_OAI] ADD  DEFAULT ('oai_dc') FOR [Data_Code]
GO

ALTER TABLE [dbo].[SobekCM_Item_OAI]  WITH CHECK ADD  CONSTRAINT [FK_SobekCM_Item_OAI_SobekCM_Item] FOREIGN KEY([ItemID])
REFERENCES [dbo].[SobekCM_Item] ([ItemID])
GO

ALTER TABLE [dbo].[SobekCM_Item_OAI] CHECK CONSTRAINT [FK_SobekCM_Item_OAI_SobekCM_Item]
GO


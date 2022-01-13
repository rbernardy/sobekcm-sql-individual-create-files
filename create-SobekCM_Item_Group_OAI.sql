USE [sobektest]
GO

/****** Object:  Table [dbo].[SobekCM_Item_Group_OAI]    Script Date: 1/12/2022 11:38:29 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[SobekCM_Item_Group_OAI](
	[GroupID] [int] NOT NULL,
	[OAI_Data] [nvarchar](max) NOT NULL,
	[Locked] [bit] NOT NULL,
	[OAI_Date] [date] NULL,
	[Data_Code] [varchar](20) NOT NULL,
 CONSTRAINT [PK_SobekCM_Item_Group_OAI] PRIMARY KEY CLUSTERED 
(
	[GroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[SobekCM_Item_Group_OAI] ADD  DEFAULT ('false') FOR [Locked]
GO

ALTER TABLE [dbo].[SobekCM_Item_Group_OAI] ADD  DEFAULT ('oai_dc') FOR [Data_Code]
GO

ALTER TABLE [dbo].[SobekCM_Item_Group_OAI]  WITH CHECK ADD  CONSTRAINT [FK_SobekCM_Item_Group_OAI_SobekCM_Item_Group] FOREIGN KEY([GroupID])
REFERENCES [dbo].[SobekCM_Item_Group] ([GroupID])
GO

ALTER TABLE [dbo].[SobekCM_Item_Group_OAI] CHECK CONSTRAINT [FK_SobekCM_Item_Group_OAI_SobekCM_Item_Group]
GO


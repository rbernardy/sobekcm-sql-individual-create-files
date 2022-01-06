USE [sobektest]
GO

/****** Object:  Table [dbo].[Tracking_Item]    Script Date: 1/5/2022 9:38:56 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Tracking_Item](
	[ItemID] [int] NOT NULL,
	[Original_AccessCode] [varchar](25) NULL,
	[EmbargoEnd] [date] NULL,
	[Original_EmbargoEnd] [date] NULL,
	[UMI] [varchar](20) NULL,
 CONSTRAINT [PK_Tracking_Item] PRIMARY KEY CLUSTERED 
(
	[ItemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Tracking_Item]  WITH CHECK ADD  CONSTRAINT [FK_Tracking_Item_SobekCM_Item] FOREIGN KEY([ItemID])
REFERENCES [dbo].[SobekCM_Item] ([ItemID])
GO

ALTER TABLE [dbo].[Tracking_Item] CHECK CONSTRAINT [FK_Tracking_Item_SobekCM_Item]
GO


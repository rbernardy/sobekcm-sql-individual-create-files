USE [sobektest]
GO

/****** Object:  Table [dbo].[SobekCM_Item_Group_External_Record]    Script Date: 1/12/2022 11:27:27 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[SobekCM_Item_Group_External_Record](
	[ExtRecordLinkID] [int] IDENTITY(1,1) NOT NULL,
	[GroupID] [int] NOT NULL,
	[ExtRecordTypeID] [int] NOT NULL,
	[ExtRecordValue] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Bib_External_Record_Type_Link] PRIMARY KEY CLUSTERED 
(
	[ExtRecordLinkID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[SobekCM_Item_Group_External_Record]  WITH CHECK ADD  CONSTRAINT [FK_ExtRecordID_Item_Group_External_Record] FOREIGN KEY([ExtRecordTypeID])
REFERENCES [dbo].[SobekCM_External_Record_Type] ([ExtRecordTypeID])
GO

ALTER TABLE [dbo].[SobekCM_Item_Group_External_Record] CHECK CONSTRAINT [FK_ExtRecordID_Item_Group_External_Record]
GO

ALTER TABLE [dbo].[SobekCM_Item_Group_External_Record]  WITH CHECK ADD  CONSTRAINT [FK_GroupID_Item_Group_External_Record] FOREIGN KEY([GroupID])
REFERENCES [dbo].[SobekCM_Item_Group] ([GroupID])
GO

ALTER TABLE [dbo].[SobekCM_Item_Group_External_Record] CHECK CONSTRAINT [FK_GroupID_Item_Group_External_Record]
GO


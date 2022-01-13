USE [sobektest]
GO

/****** Object:  Table [dbo].[SobekCM_Item_Group_Viewer_Types]    Script Date: 1/12/2022 11:56:51 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[SobekCM_Item_Group_Viewer_Types](
	[ItemGroupViewTypeID] [int] IDENTITY(1,1) NOT NULL,
	[ViewType] [varchar](50) NOT NULL,
 CONSTRAINT [PK_SobekCM_Item_Group_Viewer_Types] PRIMARY KEY CLUSTERED 
(
	[ItemGroupViewTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


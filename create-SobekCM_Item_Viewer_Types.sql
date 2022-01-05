USE [sobektest]
GO

/****** Object:  Table [dbo].[SobekCM_Item_Viewer_Types]    Script Date: 1/4/2022 10:17:03 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[SobekCM_Item_Viewer_Types](
	[ItemViewTypeID] [int] IDENTITY(1,1) NOT NULL,
	[ViewType] [varchar](50) NOT NULL,
	[Order] [int] NOT NULL,
	[DefaultView] [bit] NOT NULL,
	[MenuOrder] [float] NOT NULL,
 CONSTRAINT [PK_SobekCM_Item_Viewer_Types] PRIMARY KEY CLUSTERED 
(
	[ItemViewTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [SobekCM_Item_Viewer_Types_Viewer_Unique] UNIQUE NONCLUSTERED 
(
	[ViewType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[SobekCM_Item_Viewer_Types] ADD  DEFAULT ((100)) FOR [Order]
GO

ALTER TABLE [dbo].[SobekCM_Item_Viewer_Types] ADD  DEFAULT ('false') FOR [DefaultView]
GO

ALTER TABLE [dbo].[SobekCM_Item_Viewer_Types] ADD  DEFAULT ((1000)) FOR [MenuOrder]
GO


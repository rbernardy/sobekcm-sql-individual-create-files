USE [sobekexample]
GO

/****** Object:  Table [dbo].[mySobek_User_Edit_Aggregation]    Script Date: 1/4/2022 8:17:40 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[mySobek_User_Edit_Aggregation](
	[UserID] [int] NOT NULL,
	[AggregationID] [int] NOT NULL,
	[CanSelect] [bit] NOT NULL,
	[CanEditItems] [bit] NOT NULL,
	[OnHomePage] [bit] NOT NULL,
	[IsCurator] [bit] NOT NULL,
	[IsAdmin] [bit] NOT NULL,
	[CanEditMetadata] [bit] NOT NULL,
	[CanEditBehaviors] [bit] NOT NULL,
	[CanPerformQc] [bit] NOT NULL,
	[CanUploadFiles] [bit] NOT NULL,
	[CanChangeVisibility] [bit] NOT NULL,
	[CanDelete] [bit] NOT NULL,
 CONSTRAINT [PK_sobek_user_Edit_Aggregation] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC,
	[AggregationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[mySobek_User_Edit_Aggregation] ADD  DEFAULT ((0)) FOR [OnHomePage]
GO

ALTER TABLE [dbo].[mySobek_User_Edit_Aggregation] ADD  DEFAULT ((0)) FOR [IsCurator]
GO

ALTER TABLE [dbo].[mySobek_User_Edit_Aggregation] ADD  DEFAULT ('false') FOR [IsAdmin]
GO

ALTER TABLE [dbo].[mySobek_User_Edit_Aggregation] ADD  DEFAULT ('false') FOR [CanEditMetadata]
GO

ALTER TABLE [dbo].[mySobek_User_Edit_Aggregation] ADD  DEFAULT ('false') FOR [CanEditBehaviors]
GO

ALTER TABLE [dbo].[mySobek_User_Edit_Aggregation] ADD  DEFAULT ('false') FOR [CanPerformQc]
GO

ALTER TABLE [dbo].[mySobek_User_Edit_Aggregation] ADD  DEFAULT ('false') FOR [CanUploadFiles]
GO

ALTER TABLE [dbo].[mySobek_User_Edit_Aggregation] ADD  DEFAULT ('false') FOR [CanChangeVisibility]
GO

ALTER TABLE [dbo].[mySobek_User_Edit_Aggregation] ADD  DEFAULT ('false') FOR [CanDelete]
GO


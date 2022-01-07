USE [sobektest]
GO

/****** Object:  Table [dbo].[SobekCM_Project]    Script Date: 1/6/2022 10:06:47 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[SobekCM_Project](
	[ProjectID] [int] IDENTITY(1,1) NOT NULL,
	[ProjectCode] [nvarchar](20) NULL,
	[ProjectName] [nvarchar](100) NOT NULL,
	[ProjectManager] [nvarchar](100) NULL,
	[GrantID] [nvarchar](20) NULL,
	[GrantName] [nvarchar](250) NULL,
	[StartDate] [date] NULL,
	[EndDate] [date] NULL,
	[isActive] [bit] NULL,
	[Description] [nvarchar](1000) NULL,
	[Specifications] [nvarchar](1000) NULL,
	[Priority] [nvarchar](100) NULL,
	[QC_Profile] [nvarchar](100) NULL,
	[TargetItemCount] [int] NULL,
	[TargetPageCount] [int] NULL,
	[Comments] [nvarchar](1000) NULL,
	[CopyrightPermissions] [nvarchar](1000) NULL,
 CONSTRAINT [PK_SobekCM_Project] PRIMARY KEY CLUSTERED 
(
	[ProjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


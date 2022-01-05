USE [sobektest]
GO

/****** Object:  Table [dbo].[FDA_Report]    Script Date: 1/4/2022 11:20:28 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[FDA_Report](
	[FdaReportID] [int] IDENTITY(1,1) NOT NULL,
	[Package] [varchar](50) NOT NULL,
	[IEID] [varchar](50) NULL,
	[FdaReportTypeID] [int] NOT NULL,
	[Report_Date] [datetime] NULL,
	[Account] [varchar](50) NULL,
	[Project] [varchar](50) NULL,
	[Warnings] [int] NOT NULL,
	[Message] [varchar](1000) NULL,
	[Database_Date] [datetime] NULL,
	[ItemID] [int] NOT NULL,
 CONSTRAINT [PK_FDA_Report] PRIMARY KEY CLUSTERED 
(
	[FdaReportID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[FDA_Report] ADD  CONSTRAINT [DF_FDA_Report_Warnings]  DEFAULT ((0)) FOR [Warnings]
GO

ALTER TABLE [dbo].[FDA_Report] ADD  DEFAULT ((-1)) FOR [ItemID]
GO

ALTER TABLE [dbo].[FDA_Report]  WITH CHECK ADD  CONSTRAINT [FK_FDA_Report_FDA_Report_Type] FOREIGN KEY([FdaReportTypeID])
REFERENCES [dbo].[FDA_Report_Type] ([FdaReportTypeID])
GO

ALTER TABLE [dbo].[FDA_Report] CHECK CONSTRAINT [FK_FDA_Report_FDA_Report_Type]
GO


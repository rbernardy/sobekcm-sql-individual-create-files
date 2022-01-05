USE [sobektest]
GO

/****** Object:  Table [dbo].[FDA_Report_Type]    Script Date: 1/4/2022 11:28:19 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[FDA_Report_Type](
	[FdaReportTypeID] [int] IDENTITY(1,1) NOT NULL,
	[FdaReportType] [varchar](50) NOT NULL,
 CONSTRAINT [PK_FDA_Report_Type] PRIMARY KEY CLUSTERED 
(
	[FdaReportTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


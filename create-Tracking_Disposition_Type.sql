USE [sobektest]
GO

/****** Object:  Table [dbo].[Tracking_Disposition_Type]    Script Date: 1/5/2022 9:20:24 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Tracking_Disposition_Type](
	[DispositionID] [int] IDENTITY(1,1) NOT NULL,
	[DispositionFuture] [varchar](100) NOT NULL,
	[DispositionPast] [varchar](100) NOT NULL,
	[DispositionNotes] [varchar](1000) NOT NULL,
 CONSTRAINT [PK_Tracking_Disposition_Type] PRIMARY KEY CLUSTERED 
(
	[DispositionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


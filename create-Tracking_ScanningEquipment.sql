USE [sobektest]
GO

/****** Object:  Table [dbo].[Tracking_ScanningEquipment]    Script Date: 1/5/2022 10:04:01 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Tracking_ScanningEquipment](
	[EquipmentID] [int] IDENTITY(1,1) NOT NULL,
	[ScanningEquipment] [nvarchar](255) NOT NULL,
	[Notes] [nvarchar](max) NULL,
	[Location] [nvarchar](255) NULL,
	[EquipmentType] [nvarchar](255) NULL,
	[isActive] [bit] NOT NULL,
	[ProductionStartDate] [date] NULL,
	[ProductionEndDate] [date] NULL,
 CONSTRAINT [PK_Tracking_ScanningEquipment] PRIMARY KEY CLUSTERED 
(
	[EquipmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO


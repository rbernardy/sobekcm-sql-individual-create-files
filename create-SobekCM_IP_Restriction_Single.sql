USE [sobekexample]
GO

/****** Object:  Table [dbo].[SobekCM_IP_Restriction_Single]    Script Date: 1/4/2022 8:43:15 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[SobekCM_IP_Restriction_Single](
	[IP_SingleID] [int] IDENTITY(1,1) NOT NULL,
	[IP_RangeID] [int] NOT NULL,
	[StartIP] [char](15) NOT NULL,
	[EndIP] [char](15) NULL,
	[Notes] [nvarchar](100) NULL,
 CONSTRAINT [PK_SobekCM_IP_Restriction_Single] PRIMARY KEY CLUSTERED 
(
	[IP_SingleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[SobekCM_IP_Restriction_Single]  WITH CHECK ADD  CONSTRAINT [FK_SobekCM_IP_Restriction_Single_SobekCM_IP_Restriction_Range] FOREIGN KEY([IP_RangeID])
REFERENCES [dbo].[SobekCM_IP_Restriction_Range] ([IP_RangeID])
GO

ALTER TABLE [dbo].[SobekCM_IP_Restriction_Single] CHECK CONSTRAINT [FK_SobekCM_IP_Restriction_Single_SobekCM_IP_Restriction_Range]
GO


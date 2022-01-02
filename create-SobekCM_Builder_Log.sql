USE [sobekexample]
GO

/****** Object:  Table [dbo].[SobekCM_Builder_Log]    Script Date: 1/2/2022 11:52:04 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[SobekCM_Builder_Log](
	[BuilderLogID] [bigint] IDENTITY(1,1) NOT NULL,
	[RelatedBuilderLogID] [bigint] NULL,
	[LogDate] [datetime] NULL,
	[BibID_VID] [varchar](16) NULL,
	[LogType] [varchar](25) NULL,
	[LogMessage] [varchar](2000) NULL,
	[SuccessMessage] [varchar](500) NULL,
	[METS_Type] [varchar](50) NULL,
 CONSTRAINT [PK_SobekCM_Builder_Log] PRIMARY KEY CLUSTERED 
(
	[BuilderLogID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[SobekCM_Builder_Log]  WITH CHECK ADD  CONSTRAINT [FK_Self_SobekCM_Builder_Log] FOREIGN KEY([RelatedBuilderLogID])
REFERENCES [dbo].[SobekCM_Builder_Log] ([BuilderLogID])
GO

ALTER TABLE [dbo].[SobekCM_Builder_Log] CHECK CONSTRAINT [FK_Self_SobekCM_Builder_Log]
GO


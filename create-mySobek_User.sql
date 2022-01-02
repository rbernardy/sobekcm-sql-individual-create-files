USE [sobekexample]
GO

/****** Object:  Table [dbo].[mySobek_User]    Script Date: 1/2/2022 1:46:38 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[mySobek_User](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[ShibbID] [char](8) NULL,
	[UserName] [nvarchar](100) NULL,
	[Password] [nvarchar](100) NULL,
	[EmailAddress] [varchar](100) NULL,
	[FirstName] [nvarchar](100) NULL,
	[LastName] [nvarchar](100) NULL,
	[DateCreated] [datetime] NOT NULL,
	[LastActivity] [datetime] NOT NULL,
	[isActive] [bit] NOT NULL,
	[Note_Length] [int] NOT NULL,
	[Can_Make_Folders_Public] [bit] NOT NULL,
	[isTemporary_Password] [bit] NOT NULL,
	[sendEmailOnSubmission] [bit] NOT NULL,
	[Can_Submit_Items] [bit] NOT NULL,
	[Lock_Out_Count] [int] NULL,
	[Lock_Out_Date] [datetime] NULL,
	[NickName] [nvarchar](100) NULL,
	[Organization] [nvarchar](250) NULL,
	[College] [nvarchar](250) NULL,
	[Department] [nvarchar](250) NULL,
	[Unit] [nvarchar](250) NULL,
	[Default_Rights] [nvarchar](1000) NULL,
	[UI_Language] [nvarchar](50) NULL,
	[Internal_User] [bit] NOT NULL,
	[OrganizationCode] [varchar](15) NOT NULL,
	[EditTemplate] [varchar](20) NOT NULL,
	[EditTemplateMarc] [varchar](20) NOT NULL,
	[Receive_Stats_Emails] [bit] NOT NULL,
	[Has_Item_Stats] [bit] NOT NULL,
	[IsSystemAdmin] [bit] NOT NULL,
	[IsPortalAdmin] [bit] NOT NULL,
	[Include_Tracking_Standard_Forms] [bit] NOT NULL,
	[qcProfile] [nvarchar](50) NOT NULL,
	[Can_Delete_All_Items] [bit] NOT NULL,
	[ScanningTechnician] [bit] NOT NULL,
	[ProcessingTechnician] [bit] NOT NULL,
	[InternalNotes] [nvarchar](500) NULL,
	[IsHostAdmin] [bit] NOT NULL,
	[IsUserAdmin] [bit] NOT NULL,
 CONSTRAINT [PK_sobek_user] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[mySobek_User] ADD  DEFAULT ('') FOR [OrganizationCode]
GO

ALTER TABLE [dbo].[mySobek_User] ADD  DEFAULT ('edit') FOR [EditTemplate]
GO

ALTER TABLE [dbo].[mySobek_User] ADD  DEFAULT ('editmarc') FOR [EditTemplateMarc]
GO

ALTER TABLE [dbo].[mySobek_User] ADD  DEFAULT ('true') FOR [Receive_Stats_Emails]
GO

ALTER TABLE [dbo].[mySobek_User] ADD  DEFAULT ('false') FOR [Has_Item_Stats]
GO

ALTER TABLE [dbo].[mySobek_User] ADD  DEFAULT ('false') FOR [IsSystemAdmin]
GO

ALTER TABLE [dbo].[mySobek_User] ADD  DEFAULT ('false') FOR [IsPortalAdmin]
GO

ALTER TABLE [dbo].[mySobek_User] ADD  DEFAULT ('true') FOR [Include_Tracking_Standard_Forms]
GO

ALTER TABLE [dbo].[mySobek_User] ADD  DEFAULT ('') FOR [qcProfile]
GO

ALTER TABLE [dbo].[mySobek_User] ADD  DEFAULT ('false') FOR [Can_Delete_All_Items]
GO

ALTER TABLE [dbo].[mySobek_User] ADD  DEFAULT ((0)) FOR [ScanningTechnician]
GO

ALTER TABLE [dbo].[mySobek_User] ADD  DEFAULT ((0)) FOR [ProcessingTechnician]
GO

ALTER TABLE [dbo].[mySobek_User] ADD  DEFAULT ('false') FOR [IsHostAdmin]
GO

ALTER TABLE [dbo].[mySobek_User] ADD  DEFAULT ('false') FOR [IsUserAdmin]
GO


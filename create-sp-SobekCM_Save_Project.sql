USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Save_Project]    Script Date: 3/14/2022 9:59:11 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SobekCM_Save_Project]
	@ProjectID int,
	@ProjectCode nvarchar(20),
	@ProjectName nvarchar(100),
	@ProjectManager nvarchar(100),
	@GrantID nvarchar(250),
	@GrantName bigint,
	@StartDate date,
	@EndDate date,
	@isActive bit,
	@Description nvarchar(MAX),
	@Specifications nvarchar(MAX),
	@Priority nvarchar(100),
	@QC_Profile nvarchar(100),
	@TargetItemCount int,
	@TargetPageCount int,
	@Comments nvarchar(MAX),
	@CopyrightPermissions nvarchar(1000),
	@New_ProjectID int output
	
AS
Begin transaction

	-- Set the return ProjectID value first
	set @New_ProjectID = @ProjectID;
	

	-- If this project does not exist (ProjectID) insert, else update
	if (( select count(*) from SobekCM_Project  where ( ProjectID = @ProjectID ))  < 1 )
	   begin	
	    	-- begin insert
		    insert into SobekCM_Project (ProjectCode, ProjectName, ProjectManager, GrantID, GrantName, StartDate, EndDate, isActive, [Description], Specifications, [Priority],QC_Profile, TargetItemCount, TargetPageCount, Comments, CopyrightPermissions)
		    values (@ProjectCode, @ProjectName, @ProjectManager, @GrantID, @GrantName, @StartDate, @EndDate, @isActive, @Description, @Specifications, @Priority, @QC_Profile, @TargetItemCount, @TargetPageCount, @Comments, @CopyrightPermissions);
     	--Get the new ProjectID for this row
     	set @New_ProjectID = @@IDENTITY;
     	end
	else
	    begin
	    --update the corresponding row in the SobekCM_Project table
	    update SobekCM_Project
	    set ProjectCode=@ProjectCode, ProjectName=@ProjectName, ProjectManager=@ProjectManager, GrantID=@GrantID, GrantName=@GrantName, StartDate=@StartDate, EndDate=@EndDate, isActive=@isActive, [Description]=@Description, Specifications=@Specifications, [Priority]=@Priority, QC_Profile=@QC_Profile, TargetItemCount=@TargetItemCount, TargetPageCount=@TargetPageCount, Comments=@Comments, CopyrightPermissions=@CopyrightPermissions
	    where ProjectID=@ProjectID;
	    end	
		
commit transaction;		
GO


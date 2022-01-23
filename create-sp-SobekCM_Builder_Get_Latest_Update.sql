USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_Builder_Get_Latest_Update]    Script Date: 1/23/2022 2:53:50 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Gets the latest and greatest for when the builder ran, version, etc.. and also scheduled task information to show
CREATE PROCEDURE [dbo].[SobekCM_Builder_Get_Latest_Update]
as
begin

	-- Get the latest status / builder values which are stored in the settings table
	select Setting_Key, Setting_Value, Help, Options
	from SobekCM_Settings
	where ( Hidden = 'false' )
	  and ( TabPage = 'Builder' )
	  and ( Heading = 'Status' )
	order by TabPage, Heading, Setting_Key;

	
	-- Return all the scheduled type modules, with the schedule and the last run info
	with last_run_cte ( ModuleScheduleID, LastRun) as 
	(
		select ModuleScheduleID, MAX([Timestamp])
		from SobekCM_Builder_Module_Scheduled_Run
		group by ModuleScheduleID
	)
	-- Return all the scheduled type modules, along with information on when it was last run
	select S.ModuleSetID, S.SetName, S.[Enabled] as SetEnabled, C.ModuleScheduleID, C.[Enabled] as ScheduleEnabled, C.DaysOfWeek, C.TimesOfDay, C.[Description], coalesce(L.LastRun,'') as LastRun, coalesce(R.Outcome,'') as Outcome, coalesce(R.[Message],'') as [Message]
	from SobekCM_Builder_Module_Set S inner join
		 SobekCM_Builder_Module_Type T on S.ModuleTypeID = T.ModuleTypeID inner join
		 SobekCM_Builder_Module_Schedule C on C.ModuleSetID = S.ModuleSetID left outer join
		 last_run_cte L on L.ModuleScheduleID = C.ModuleScheduleID left outer join
		 SobekCM_Builder_Module_Scheduled_Run R on R.ModuleSchedRunID=L.ModuleScheduleID and R.[Timestamp] = L.LastRun
	where T.TypeAbbrev = 'SCHD'
	order by C.[Description], S.SetOrder;

end;
GO


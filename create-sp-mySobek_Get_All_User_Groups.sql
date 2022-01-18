USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[mySobek_Get_All_User_Groups]    Script Date: 1/17/2022 8:00:53 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[mySobek_Get_All_User_Groups] AS
BEGIN

	with linked_users_cte ( UserGroupID, UserCount ) AS
	(
		select UserGroupID, count(*)
		from mySobek_User_Group_Link
		group by UserGroupID
	)
	select G.UserGroupID, GroupName, GroupDescription, coalesce(UserCount,0) as UserCount, IsSpecialGroup
	from mySobek_User_Group G 
	     left outer join linked_users_cte U on U.UserGroupID=G.UserGroupID
	order by IsSpecialGroup, GroupName;

END
GO


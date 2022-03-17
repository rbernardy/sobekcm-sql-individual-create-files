USE [sobektest]
GO

/****** Object:  StoredProcedure [dbo].[SobekCM_WebContent_Usage_Report]    Script Date: 3/16/2022 9:13:04 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



-- Pull the usage for all top-level web content pages between two dates
CREATE PROCEDURE [dbo].[SobekCM_WebContent_Usage_Report]
	@year1 smallint,
	@month1 smallint,
	@year2 smallint,
	@month2 smallint
AS
BEGIN	

	with stats_compiled as
	(	
		select Level1, Level2, Level3, Level4, Level5, Level6, Level7, Level8, sum(Hits) as Hits, sum(Hits_Complete) as HitsHierarchical
		from SobekCM_WebContent_Statistics
		where ((( [Month] >= @month1 ) and ( [Year] = @year1 )) or ([Year] > @year1 ))
		  and ((( [Month] <= @month2 ) and ( [Year] = @year2 )) or ([Year] < @year2 ))
		group by Level1, Level2, Level3, Level4, Level5, Level6, Level7, Level8
	)
	select coalesce(W.Level1, S.Level1) as Level1, coalesce(W.Level2, S.Level2) as Level2, coalesce(W.Level3, S.Level3) as Level3,
	       coalesce(W.Level4, S.Level4) as Level4, coalesce(W.Level5, S.Level5) as Level5, coalesce(W.Level6, S.Level6) as Level6,
		   coalesce(W.Level7, S.Level7) as Level7, coalesce(W.Level8, S.Level8) as Level8, W.Deleted, coalesce(W.Title,'(no title)') as Title, S.Hits, S.HitsHierarchical
	into #TEMP1
	from stats_compiled S left outer join
	     SobekCM_WebContent W on     ( W.Level1=S.Level1 ) 
		                         and ( coalesce(W.Level2,'')=coalesce(S.Level2,''))
								 and ( coalesce(W.Level3,'')=coalesce(S.Level3,''))
								 and ( coalesce(W.Level4,'')=coalesce(S.Level4,''))
								 and ( coalesce(W.Level5,'')=coalesce(S.Level5,''))
								 and ( coalesce(W.Level6,'')=coalesce(S.Level6,''))
								 and ( coalesce(W.Level7,'')=coalesce(S.Level7,''))
								 and ( coalesce(W.Level8,'')=coalesce(S.Level8,''))
	order by Level1, Level2, Level3, Level4, Level5, Level6, Level7, Level8;	
	
	-- Return the full stats
	select * from #TEMP1;
	
	-- Return the distinct first level
	select Level1 
	from #TEMP1
	group by Level1
	order by Level1;
	
	-- Return the distinct first TWO level					
	select Level1, Level2
	from #TEMP1
	group by Level1, Level2
	order by Level1, Level2;

END;
GO


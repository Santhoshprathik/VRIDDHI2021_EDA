

-------------------------------------------------------------------------------------
--Show table

SELECT * 
FROM teams

--show duplicates

WITH cte AS( 
	SELECT *,ROW_NUMBER() OVER (
	PARTITION BY 
	name,teamMembers_0,eventId
	order by eventId
	) row_num
	FROM teams)
SELECT *
FROM cte
WHERE row_num >1

--delete duplicates

WITH cte AS( 
	SELECT *,ROW_NUMBER() OVER (
	PARTITION BY 
	name,teamMembers_0,eventId
	order by eventId
	) row_num
	FROM teams)
DELETE
FROM cte
WHERE row_num >1

--see nulls
SELECT * FROM projects..teams
WHERE teamMembers_0 IS NULL

DELETE FROM projects..teams
WHERE teamMembers_0 IS NULL





-------------------------------------------------------------------------------------
--Teams registerd as team of (5,4,3,2,1)

SELECT distinct COUNT(uniqueId) as Totalteams, COUNT(teamMembers_4) / 25.72 as TeamOf5, ( COUNT(teamMembers_3) - COUNT(teamMembers_4))/ 25.72 as TeamOf4
,( COUNT(teamMembers_2) - COUNT(teamMembers_3))/ 25.72 as TeamOf3
,( COUNT(teamMembers_1) - COUNT(teamMembers_2))/ 25.72 as TeamOf2
,( COUNT(teamMembers_0) - COUNT(teamMembers_1))/ 25.72 as TeamOf1
from projects..teams
-------------------------------------------------------------------------------------
--total no of teams
SELECT COUNT(teamMembers_0)
FROM projects..teams

--No of TEAMS for each event

SELECT eventId as Event_ID,COUNT(eventId) AS No_of_teams , COUNT(eventId)/22.80 AS Percent_registered
FROM projects..teams
group by eventId
ORDER BY 3 DESC

-------------------------------------------------------------------------------------
--Total users
SELECT * FROM projects..users

-------------------------------------------------------------------------------------

--Total Praticipants( paid Vs not paid )

SELECT COUNT(uniqueId) FROM projects..users

SELECT paidStatus AS PaidStatus, COUNT(paidStatus)/24.77 as PercentFromRegistered
FROM projects..users
GROUP BY paidStatus

-------------------------------------------------------------------------------------
--Total Participants NITR

SELECT COUNT(isNitr)/24.77
FROM projects..users
WHERE isNitr LIKE  '%1%'

--Total Participants NON-NITR

SELECT COUNT(isNitr)/24.77
FROM projects..users
WHERE isNitr LIKE  '%0%'

--participants from other nit,iit and iiits by total participants

SELECT COUNT(uniqueId) AS Total_tier_1, COUNT(uniqueId)/24.77 AS tier_1_percentage
FROM projects..users
WHERE isNitr LIKE '%0%' AND (collegeName LIKE '%IIT%' OR collegeName LIKE '%NIT%' OR collegeName LIKE '%IIIT%') AND  collegeName NOT LIKE '%Rourkela%'
AND  collegeName NOT LIKE 'nitr%';

--participants from other nit,iit and iiits by  total non nitr participants

SELECT COUNT(uniqueId) AS Total_tier_1, COUNT(uniqueId)/16.63 AS tier_1_percentage
FROM projects..users
WHERE isNitr LIKE '%0%' AND (collegeName LIKE '%IIT%' OR collegeName LIKE '%NIT%' OR collegeName LIKE '%IIIT%') AND  collegeName NOT LIKE '%Rourkela%'
AND  collegeName NOT LIKE 'nitr%';



-------------------------------------------------------------------------------------
-- Percentage Participated only in one event

SELECT COUNT(uniqueId)/24.77 
FROM projects..users
WHERE participatedEvents#0 IS NOT NULL AND participatedEvents#1 IS NULL

-- Percentage Participated in more than one event

SELECT COUNT(uniqueId)/24.77 
FROM projects..users
WHERE participatedEvents#0 IS NOT NULL AND participatedEvents#1 IS NOT NULL AND participatedEvents#2 IS NOT NULL AND participatedEvents#4 IS NOT NULL


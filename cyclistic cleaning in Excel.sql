-- open (postgres sql) pg admin 4 tool for futher process
--  now we've import the data ste into postgres sql by create table statement.
create table cyclistic_202408(
                              ride_id varchar(40),
							  rideable_type	text,
							  started_at timestamptz,
							  ended_at timestamptz,
							  start_station_name varchar(100),
							  start_station_id varchar(60),
							  end_station_name varchar(100),
							  end_station_id varchar(60),
							  start_lat float,
							  start_lng float,
							  end_lat float,
							  end_lng float,
							  member_casual text,
							  ride_length time,
							  ride_date	date,
							  ride_month int,
							  ride_year int,
							  Start_time time,
							  end_time time,
							  days_of_week text);
-- repeat this above command to import remaninig 5 tables as well.
Select * from cyclistic_202403;
select * from cyclistic_202404;
select * from cyclistic_202405;
select * from cyclistic_202406;
select * from cyclistic_202407;
select * from cyclistic_202408;


-- next we will combine all these tables into a single table to

create table cyclistic_company as
Select * from cyclistic_202403
union all
select * from cyclistic_202404
union all
select * from cyclistic_202405
union all
select * from cyclistic_202406
union all
select * from cyclistic_202407
union all
select * from cyclistic_202408

select * from cyclistic_company;

-- Actually why I merged these six table data into a single table which make exploratory data analysis easirer
-- After combined these table i got total rows of 3541371.

--cleaning in excel we didn't remove null because of large data set  
--creating the table without null vallues in specfic columns.
 create table cyclistic_company_non_null as
 select * from cyclistic_company
 where not (start_station_id IS NULL OR 
end_station_name IS NULL OR
 end_station_id IS NULL);
 
select * from cyclistic_company_non_null;

--we drop cyclistic_company table because i've created non_null values contain table.
drop table cyclistic_company;
## Process (EDA)
--now i got a total rows of 2546704
-- I have already added the addtional column like  start_time,end_time anddays_of_week now will extract seconds and minutes from the start_time and end_time
create table cyclistic_company_bikeshare as
select rideid,rideable_type,start_station_name,end_station_name,ride_length,ride_month,start_time,end_time,
 extract(Minutes from ride_length)as diff_Minutes,days_of_week
days_of_week,round(extract(EPOCH from ended_at)-extract(EPOCH from started_at),0)as diff_seconds
,member_casual
from  cyclistic_company_non_null;

-- find the average,maximum and minimum length of the ride in minutes.
select count(*) total_rides,round(avg(diff_minutes),2) as avg_ride_length,member_casual,
max(diff_minutes) as max_ride_length,
min(diff_minutes)as min_ride_length
from cyclistic_company_bikeshare
group by member_casual;


select * from cyclistic_company_bikeshare;

-- find the ride_length avg,max,min of a cyclistic _company for member riders and casual riders. 

select member_casual,avg(ride_length)as avg_length,days_of_week,
       min(ride_length)as min_length,
	   max(ride_length)as max_length
	   from cyclistic_company_non_null
	   group by member_casual,days_of_week;
---now I want update the days of weeks with day name first we alter the column with text data type and using update command update with
-- name of the week.

alter table cyclistic_company_non_null
alter column days_of_week
type text;
	  
select * from cyclistic_company_non_null;
update cyclistic_company_non_null
set days_of_week =case
                    When days_of_week = '1' then 'Sunday'
				    When days_of_week ='2' then 'Monday'
                    WHEN days_of_week = '3' THEN 'Tuesday'
                    WHEN days_of_week = '4' THEN 'Wednesday'
                    WHEN days_of_week = '5' THEN 'Thursday'
                    WHEN days_of_week = '6' THEN 'Friday'
                    WHEN days_of_week = '7' THEN 'Saturday' 
                    end
WHERE days_of_week in('1','2','3','4','5','6','7')	

-- let's check total number of rides in days of week by user members.

Select days_of_week,count(ride_id)as total_rides,member_casual from
    cyclistic_company_non_null
    group by days_of_week,member_casual
	order by total_rides desc;

--find number of rides by casual riders from 

Select member_casual,count(ride_id)as total_rides
from cyclistic_company_non_null
group by member_casual
order by total_rides desc;

-- Identifying the number of rides by each months .
Alter table cyclistic_company_non_null
alter column ride_month type text;
select case
          when ride_month = '3' then 'March'
		  when ride_month = '4' then 'April'
		  when ride_month = '5' then 'may'
		  when ride_month = '6' then 'june'
		  when ride_month = '7' then 'july'
		  when ride_month = '8' then 'August'
		  End as ride_month,Count(*) as total_rides,member_casual
from cyclistic_company_bikeshare
group by member_casual,ride_month;

-- counting rides taken by bike type 
SELECT rideable_type,COUNT(*) as total_ride_taken,member_casual
FROM cyclistic_company_non_null
GROUP BY rideable_type,member_casual
ORDER BY total_ride_taken;

--next we will combine  of the departure and arrival stations to create a route name.
--Then it counts the number of trips for each route created depending on the user type casual riders
---concatenating start and end location names to create route name.

select Concat(start_station_name,'&',end_station_name)as route,count(rideable_type)as number_of_rides,member_casual
from cyclistic_company_non_null
group by route,member_casual
order by number_of_rides desc
Limit 5;

--Identifying the time of ride in a dayby hours by users.

select extract(hour from start_time) as hour,count(ride_id)as total_rides,member_casual
from cyclistic_company_non_null
group by hour,member_casual
order by hour;

-- Calculating the median ride length of days of week.

select  DISTINCT median_ride_length,days_of_week,member_casual FROM 
        (SELECT days_of_week,member_casual,PERCENTILE_cont(0.10)WITHIN GROUP(ORDER BY ride_length) AS median_ride_length FROM cyclistic_company_non_null
				group by days_of_week,member_casual);

-- now let' busiest day of the week for memeber_casual

SELECT member_casual,
days_of_week as mode_of_day
FROM(SELECT DISTINCT member_casual, days_of_week,
ROW_NUMBER() OVER (PARTITION BY member_casual ORDER BY COUNT(days_of_week) DESC) rn
FROM cyclistic_company_non_null
GROUP BY member_casual, days_of_week)
WHERE rn =1
order by member_casual DESC
LIMIT 2

-- export all the output in csv file are make connection in power bi and make data visulization.	
	;



        


							  

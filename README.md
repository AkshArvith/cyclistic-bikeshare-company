## Case study: How does a bike-share navigate speedy success


![image](https://github.com/user-attachments/assets/8da05438-6b07-4683-a61c-edee73b20de7)




I’m happy to share my case study of a Chicago-based cyclitic bike share company in order to analyze the historical data sets to identify how their customers use the bike differently and improve their riding experience. 
I had demonstrated the skills as a data analyst to show to potential employers.

## Tools Used
•	Microsoft Excel
•	Postgres SQL server
•	Power Bi


## Scenario
You are a junior data analyst working on the marketing analyst team at Cyclistic, a bike-share company in Chicago. The director of marketing believes the company’s future success depends on maximizing the number of annual memberships. Therefore, your team wants to understand how casual riders and annual members use Cyclistic bikes differently. From these insights, your team will design a new marketing strategy to convert casual riders into annual members. But first, Cyclistic executives must approve your recommendations, so they must be backed up with compelling data insights and professional data visualizations.

## Stakeholders

Lily Moreno: The director of marketing and your manager. Moreno is responsible for the development of campaigns and initiatives to promote the bike-share program. These may include email, social media, and other channels.
Cyclistic marketing analytics team: A team of data analysts who are responsible for collecting, analysing, and reporting data that helps guide Cyclistic marketing strategy. You joined this team six months ago and have been busy learning about Cyclistic’s mission and business goals—as well as how you, as a junior data analyst, can help Cyclistic achieve them.
For this Data Analyse process, we will follow the steps by step
•	Ask
•	Prepare
•	Process
•	Analyse
•	Share
•	Act                                   
## Ask
We can use SMART frame work for ask process our analysis to make data driven decision making in the project
S -> Specific
M-> Measurable
A->Action-Oriented
R->Reasonable
T->Time Bound
1. How do annual members and casual riders use Cyclistic bikes differently?        
2. Why would casual riders buy Cyclistic annual memberships?
3. How can Cyclistic use digital media to influence casual riders to become members?

 
## Objective 
In this case study cyclitic bike-sharing company to conduct an analysis of historical data of six months identify the trends and pattern of the data bring insights in the annual members and casual riders how they use cyclitic bikes differently by this analyse the stakeholder and executive team come with the marketing strategy to convert the casual riders into memberships by their marketing strategy and influence of digital media of conversions process help with our findings and recommendation to achieve the goal

## Prepare 
To begin our process firstly we need the data of the cyclitic bike share company that can find publicly available Kaggle website are you can see here by clicking this link  navigate to the web page that consists of cyclitic  bike share data I Took only past  6 months of data  to analysis from 2024 April to 2024 September which consist of 6 Csv file and open the file and check data’s credibility using ROCCC Framework to the data’s dependability by:


R(Reliable): although the data has some missing value and inconsistent words I can find accuracy in data.

O(Original): the data source is primary and original.

C(Comprehensive): the dataset is contained around 500k of rows it comprehensive.

C(current): the information are current data over last 6 months.

C(cited): The data is referred based on reliable information. 

The cyclitic bike contains 13 columns of ride id, rideable ride, started at, ended_at, start_station_name, start_station_id,end_station_name,end_station_id,start_lat,start_lng,end_lat,end_lng,member_casual.
Process
Microsoft Excel for initial cleaning and manipulation
After download the 6 zip files from the above link and stored in a desktop and unzip the file in the folder created a sub folder to store the all files appropriately to analysis the data. Remember to save a copy of original data of Csv file and XLS file before proceeding the analysis of data. Then open Excel new sheet import each file and save as XLS file and started the cleaning the data
Change the format of (started_at and eneded_at) columns using custom format as Datetime type (DD:MM: YYYY HH:MM: SS)
As shown below

Follow these steps for each file and change datatype for both columns.

Created a column called ride length and calculated the length of each ride by subtracting the column started at from the column ended at =D2-C2, Name the column name as time.

Created a column called ride date, Calculated the date of each ride started using the DATE function as =DATE(YEAR(C2), MONTH(C2), DAY(C2))) and ensure the data type YYYY-MM-DD.

Created a column called ride month, Entered the month of each ride and formatted as number.

Created a column called ride year, Entered the year of each ride and formatted as general

Created a column called start time and calculated the start time of each ride using the started at column Formatted as TIME Formatted as TIME HH:MM: SS (37:30:55)

Created a column called end time and calculated the end time of each ride using the ended at column HH:MM: SS (37:30:55).

Created a column called day_of_week and calculated the day of the week that each ride started using the WEEKDAY formula =WEEKDAY(C2,1)) Note: 1 = Sunday and 7 = Saturday.

Save the XLS file as a CSV file and proceed to the next process.

## Postgres SQL (pgadmin4)

For further process of data cleaning and manipulation will do using SQL.
The data sets are too large so I decided to clean and manipulate in Postgres SQL
Step1: the initial step that I did import the all the file using create table command


CREATE TABLE CYCLISTIC_202408(ride_id  varchar(40), rideable_type text,started_at timestamptz, ended_at timestamptz,start_station_name varchar(100),start_station_id varchar(60),end_station_name varchar(100),end_station_id varchar(60),start_lat float,start_lng float,end_lat float,end_lng float,member_casual text,ride_length  time,ride_date	date, ride_month int,ride_year int, Start_time time,end_time time,days_of_week text);


create table and followed by column name and datatypes After created the table import data using schemas.


Right on table name and click import/export Data as show below figure.
 
Remember all columns should match the CSV file column that saved in my desktop 
Repeat this step for other Csv file and import the data.
After imported all file we are ready to write the SQL queries Firstly combine all past 6 months cyclitic tables into 1 single table using UNION


CREATE TABLE cyclistic_company as
SELECT * FROM cyclistic_202403
UNION ALL
SELECT * FROM cyclistic_202404
UNION ALL
SELECT * FROM cyclistic_202405
UNION ALL
SELECT * FROM cyclistic_202406
UNION ALL
SELECT * FROM cyclistic_202407
UNION ALL
SELECT * FROM cyclistic_202408
we got around 3.5 million rows.
Then I start checking for the duplicate values and created the table stored all unique value of data. By write query as  
CREATE TABLE cyclistic_company_non_null as
SELECT * FROM cyclistic_company
WHERE NOT  (start_station_id IS NULL OR 
end_station_name IS NULL OR
 end_station_id IS NULL); 


 

 ## Analyze (EDA)

I'Ve Attached the sql script in this repository check it out.

## Share
I’ve downloaded all the findings and save it as CSV file my desktop

To share these findings and gave some insights about the riders I create a data visualization using Power Bi and created a Dynamic Dashboard.

# Main Findings
Most of the riders have purchased annual memberships around 61% riders are annual members while 39% are casual riders of total riders were around 2.5 million.
Both Casual riders and member riders are liked to ride in the Classic bikes more than electric bikes. Docked bikes were not used in last six month
Then I looked at the number of rides taken for each hour of the day for weekdays and weekends. Weekday riding behaviour is similar between casual riders and members but there are more pronounced huge spikes of usage in 17:00 for both casual and member especially casual riders are busy in the evening.
I compared the average rides by user and over last 6 month to find which month has the peak riding by that I find monsoon season has rush riding time for the bikers over 3 lakh riders were riding on those three months.
When seen as a whole, the data indicates that although casual riders seem to utilize the bikes more for leisure, members are more likely to use them to get to and from work.
The busiest day of week by number of rides in a day for casual riders Saturday evening the riders were more actively riding and member riders was busy in Wednesdays the frequency of ridings was busy in those two days.
Finally, most rides done between stations the casual riders are Streeter Dr &Grand Ave& Streeter &Grand Ave these routes where more frequently rides were done, for member riders Calumet Ave & 33rd Testate st&33rdst frequently ride were done on these routes.
From these findings and valuable insights, I’ve created a dynamic dashboard in power Bi.

Find my dynamic dashboard of cyclistic bikeshare company 
 
![Screenshot 2024-10-28 195815](https://github.com/user-attachments/assets/12ebc245-eb64-4a83-bdbb-929a31a27846)

### Recommendations:

Marketing campaigns might be conducted in spring and summer at tourist/recreational locations popular among casual riders.

Casual riders are most active on weekends and during the summer and spring, thus they may be offered seasonal or weekend-only memberships.

Casual riders use their bikes for longer durations than members. Offering discounts for longer rides may incentivize casual riders and entice members to ride for longer periods of time.




# cyclistic-bikeshare-company

## Scenario

You are a junior data analyst working on the marketing analyst team at Cyclistic, a bike-share company in Chicago. The director of marketing believes the company’s future success depends on maximizing the number of annual memberships. Therefore, your team wants to understand how casual riders and annual members use Cyclistic bikes differently. From these insights, your team will design a new marketing strategy to convert casual riders into annual members. But first, Cyclistic executives must approve your recommendations, so they must be backed up with compelling data insights and professional data visualizations.
                                    
                                    Tools Used	
                                   --> Microsoft Excel
                                   
	                        --> Postgres SQL server
                         
	                        --> Power Bi

## Stakeholders
          
Lily Moreno: 
          The director of marketing and your manager. Moreno is responsible for the development of campaigns and initiatives to promote the bike-share program. These may include email, social media, and other channels.

Cyclistic marketing analytics team: 
                 A team of data analysts who are responsible for collecting, analysing, and reporting data that helps guide Cyclistic marketing strategy. You joined this team six months ago and have been busy learning about Cyclistic’s mission and business goals—as well as how you, as a junior data analyst, can help Cyclistic achieve them.

For this Data Analyse process, we will follow the steps of

	-->Ask
 
           -->Prepare
           
           -->Process
           
	-->Analyse
 
	-->Share
 
	-->Act                                   

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

# Data source
To begin our process firstly we need the data sets of the cyclitic bike share company that can find publicly available Kaggle website are you can see here by clicking this link [https://divvy-tripdata.s3.amazonaws.com/index.html]
 this will navigate to the web page that consists of cyclitic  bike share data.

## Prepare
   I Took only past  6 months of data  to analysis from 2024 April to 2024 September which consist of 6 Csv file and open the file and check data’s credibility using ROCCC Framework to the data’s dependability by:
R(Reliable): although the data has some missing value and inconsistent words I can find accuracy in data.
O(Original): the data source is primary and original.
C(Comprehensive): the dataset is contained around 500k of rows it comprehensive.
C(current): the information are current data over last 6 months.
C(cited): The data is referred based on reliable information. 
The cyclitic bike contains 13 columns of ride id, rideable ride, started at, ended_at, start_station_name, start_station_id,end_station_name,end_station_id,start_lat,start_lng,end_lat,end_lng,member_casual.


## Process
## Microsoft Excel for initial cleaning and manipulation
After download the 6 zip files from the above link and stored in a desktop and unzip the file in the folder created a sub folder to store the all files appropriately to analysis the data. Remember to save a copy of original data of Csv file and XLS file before proceeding the analysis of data. Then open Excel new sheet import each file and save as XLS file and started the cleaning the data
Change the format of (started_at and eneded_at) columns using custom format as Datetime type (DD:MM: YYYY HH:MM: SS)
As shown below

![image](https://github.com/user-attachments/assets/52c588f4-c4a7-417c-98a3-b2471225d3e4)


 
Follow these steps for each file and change datatype for both columns.

-->Created a column called ride length and calculated the length of each ride by subtracting the column started at from the column ended at 
     =D2-C2, Name the column name as time.
     
-->Created a column called ride date, Calculated the date of each ride started using the DATE function as =DATE(YEAR(C2), MONTH(C2), 
    DAY(C2))) and ensure the data type YYYY-MM-DD.
    
-->Created a column called ride month, Entered the month of each ride and formatted as number.

-->Created a column called ride year, Entered the year of each ride and formatted as general

-->Created a column called start time and calculated the start time of each ride using the started at column Formatted as TIME Formatted as 
  TIME HH:MM: SS (37:30:55)
  
-->Created a column called end time and calculated the end time of each ride using the ended at column HH:MM: SS (37:30:55).

-->Created a column called day_of_week and calculated the day of the week that each ride started using the WEEKDAY formula =WEEKDAY(C2,1)) 
   Note: 1 = Sunday and 7 = Saturday.

Save the XLS file as a CSV file and proceed to the next process.




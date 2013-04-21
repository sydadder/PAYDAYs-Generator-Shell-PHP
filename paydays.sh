#!/bin/bash
function HRPayement(){

#A loop starts from the current month till the last month of the year. (eg. April till December will be from 04-12)
COUNTER=$(date +'%m')
DC=0

#Display the headings
echo "Month,Salary Payment Date,Bonus Payment Date"
#Create a variable and insert the headings to be inserted into the CSV
CSVFeed="Month,Salary Payment Date,Bonus Payment Date\n"

while [  $COUNTER -lt 13 ]; 
do
	CurrMonth=$(date --date "+$DC months")
	
	#GET THE DATE VARIABLES TO DETERMINE THE PAYMENT AND BONUS DATES of the month in the loop
	
	#Current Day of the month
	thisday=$(date --date "+$DC months" +'%d')
	#Current Month
	thismonth=$(date --date "+$DC months" +'%m')
	#Current Year
	thisyear=$(date --date "+$DC months" +'%y')
	#Current Month Name
	MonthName=$(date --date "+$DC months" +'%B')
	
	#DETERMINE SALARY PAYMENT DATE based on the last date/day of the month
	
	#Output Last Date of the month 
	paymentdate=$(date -d "+$((DC+1)) month -$(date +%d) days" +'%d')
	
	#Output day of the week on the last day 
	dayofweeklastday=$(date -d "+$((DC+1)) month -$(date +%d) days" +'%u')
	
	#Check if the last day is a Sunday, if yes, decrement paymentdate by 2 days thereby making the payment day friday
	#Else if the last day is a Saturday decrement paymentdate by 1 days thereby making the payment day friday
	#The condition returns the Salary payment day for the current month in the loop
	if [ "$dayofweeklastday" == "7" ]; then
		paydate=$(date -s "$thisyear-$thismonth-$((paymentdate-2))" +'%d-%b-%y') 
	elif [ "$dayofweeklastday" == "6" ]; then
		paydate=$(date -s "$thisyear-$thismonth-$((paymentdate-1))" +'%d-%b-%y') 
	else 
		paydate=$(date -s "$thisyear-$thismonth-$paymentdate" +'%d-%b-%y')
	fi
	
	#DETERMINE BONUS PAYMENT DATE based on the 15th of the current month in the loop
	dayofweek15th=$(date -s "$thisyear-$thismonth-15" +'%u')
	
	#Check if the 15th of the month is a Sunday, if yes, increament bonusdate by 3 taking it to the next Wednesday
	#Else if the 15th if the month is a Saturday increament bonusdate by 4 taking it to the next Wednesday
	#The condition returns the Bonus payment day for the current month in the loop
	if [ "$dayofweek15th" == "7" ]; then
		bonusdate=$(date -s "$thisyear-$thismonth-18" +'%d-%b-%y')
	elif [ "$dayofweek15th" == "6" ]; then
		bonusdate=$(date -s "$thisyear-$thismonth-19" +'%d-%b-%y')
	else
		bonusdate=$(date -s "$thisyear-$thismonth-15" +'%d-%b-%y')
	fi
	
	#OUPUT INTO CSV
	#Insert Month name, paydate, and bonus date into CSVFeed variable which will be sent to the csv file
	CSVFeed+="$MonthName,$paydate,$bonusdate\n"
	#Display on the screen
	echo "$MonthName,$paydate,$bonusdate"
	echo "*******************************"
	
	let COUNTER=COUNTER+1
	let DC=DC+1			 
done
#Insert data into HRPaydates.csv
echo -e "$CSVFeed" >> HRPaydates.csv

#Commit to GIT (This is just for demonstration purpose)
#git commit -a -m "The CSV file has been updated"
}

#Execute the payment dates function
HRPayement

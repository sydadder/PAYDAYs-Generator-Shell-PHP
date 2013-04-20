#!/bin/bash
function HRPayement(){

#A loop starts from the current month till the last month of the year. (eg. April till December will be from 04-12)
COUNTER=$(date +'%m')
DC=0
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
	
	#Solution to find the last date of the month by using variable mp as Current Month + 1
	mp=$((DC+1))
	#Output Last Date of the month 
	lastday=$(date -d "+$mp month -$(date +%d) days")
	paymentdate=$(date -d "+$mp month -$(date +%d) days" +'%d')
	
	#Output day of the week on the last day 
	dayofweeklastday=$(date -d "+$mp month -$(date +%d) days" +'%u')
	
	#Check if the last day is a Sunday, if yes, decrement paymentdate by 2 days thereby making the payment day friday
	#Else if the last day is a Saturday decrement paymentdate by 1 days thereby making the payment day friday
	#The condition returns the Salary payment day for the current month in the loop
	if [ "$dayofweeklastday" == "7" ]; then
		paydate=$((paymentdate-2))
	elif [ "$dayofweeklastday" == "6" ]; then
		paydate=$((paymentdate-1))
	else 
		paydate=$paymentdate
	fi
	
	#DETERMINE BONUS PAYMENT DATE based on the 15th of the current month in the loop
	
	fifteenthofmonth=$(date -s "$thisyear-$thismonth-15")
	dayofweek15th=$(date -s "$thisyear-$thismonth-15" +'%u')
	
	#Check if the 15th of the month is a Sunday, if yes, increament bonusdate by 3 taking it to the next Wednesday
	#Else if the 15th if the month is a Saturday increament bonusdate by 4 taking it to the next Wednesday
	#The condition returns the Bonus payment day for the current month in the loop
	if [ "$dayofweek15th" == "7" ]; then
		bonusdate=18
	elif [ "$dayofweek15th" == "6" ]; then
		bonusdate=19
	else
		bonusdate=15
	fi
	
	#OUPUT INTO CSV
	#echo "$MonthName | $paydate | $bonusdate" >> HRPaydates.csv
	echo "$MonthName | $paydate | $bonusdate"

	echo "*******************************"
	let COUNTER=COUNTER+1
	let DC=DC+1			 
done

}

#Execute the payment dates function
HRPayement

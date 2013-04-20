#!/bin/bash
function HRPayement(){

#A loop starts from the current month till the last month of the year. (eg. April till December will be from 04-12)
COUNTER=$(date +'%m')
DC=0
while [  $COUNTER -lt 13 ]; 
do
	echo The Month is $COUNTER and counter at $DC
	CurrMonth=$(date --date "+$DC months")
	echo "Current Month is $CurrMonth"             
	#Output Current Month Name
	thisday=$(date --date "+$DC months" +'%d')
	thismonth=$(date --date "+$DC months" +'%m')
	thisyear=$(date --date "+$DC months" +'%y')
	MonthName=$(date --date "+$DC months" +'%B')
	mp=$((DC+1))
	echo "Month $MonthName"			 
	#Output Last Date of the month 
	lastday=$(date -d "+$mp month -$(date +%d) days")
	paymentdate=$(date -d "+$mp month -$(date +%d) days" +'%d')
	echo "Last day of the month $paymentdate"
	#Output day of the week on the last day 
	dayofweeklastday=$(date -d "+$mp month -$(date +%d) days" +'%u')
	echo "Day of the week on $paymentdate is $dayofweeklastday"
	#SALARY PAYMENT DATE
	if [ "$dayofweeklastday" == "7" ]; then
	paydate=$((paymentdate-2))
	elif [ "$dayofweeklastday" == "6" ]; then
	paydate=$((paymentdate-1))
	else 
	paydate=$paymentdate
	fi
	echo "New Payment date $paydate"
	#BONUS PAYMENT DATE
	fifteenthofmonth=$(date -s "$thisyear-$thismonth-15")
	dayofweek15th=$(date -s "$thisyear-$thismonth-15" +'%u')
	echo "$dayofweek15th Fiftheenth of the month is $fifteenthofmonth"
	if [ "$dayofweek15th" == "7" ]; then
	bonusdate=18
	elif [ "$dayofweek15th" == "6" ]; then
	bonusdate=19
	else
	bonusdate=15
	fi
	echo "Bonus Payment date $bonusdate"
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

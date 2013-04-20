#!/bin/bash
function HRPayement(){

#Output Current Month Name
 thismonth=$(date +'%m')
 thisyear=$(date +'%y')
 MonthName=$(date +'%B')
 echo "Month $MonthName"
 
 COUNTER=$(date +'%m')
         while [  $COUNTER -lt 13 ]; 
		 do
             echo The counter is $COUNTER
			 
             let COUNTER=COUNTER+1 
         done
 
#Output Last Date of the month 
 lastday=$(date -d "+1 month -$(date +%d) days")
 paymentdate=$(date -d "+1 month -$(date +%d) days" +'%d')
 echo "Last day of the month $paymentdate"
#Output day of the week on the last day 
 dayofweeklastday=$(date -d "+1 month -$(date +%d) days" +'%u')
 echo "Day of the week on $paymentdate is $dayofweeklastday"
#SALARY PAYMENT DATE
 if [ "$dayofweeklastday" == "0" ]; then
	echo "Weekend"
	paydate=$paymentdate-2
 elif [ "$dayofweeklastday" == "6" ]; then
	echo "Weekend"
	paydate=$paymentdate-1
 else 
	paydate=$paymentdate
 fi
 echo "New Payment date $paydate"
 
#BONUS PAYMENT DATE
 fifteenthofmonth=$(date -s "$thisyear-$thismonth-15")
 echo "Fiftheenth of the month $fifteenthofmonth"
 dayofweek15th=$(date -s "$thisyear-$thismonth-15" +'%u')
 
 if [ "$dayofweek15th" == "0" ]; then
	echo "add 3 days"
	bonusdate=15+3
 elif [ "$dayofweek15th" == "6" ]; then
	echo "add 4 days"
	bonusdate=15+4
 else
	bonusdate=15
 fi
 echo "Bonus Payment date $bonusdate"

#OUPUT INTO CSV
echo "$MonthName $paydate $bonusdate" >> outputfile.csv
  
 
}

#Execute the payment dates function
HRPayement

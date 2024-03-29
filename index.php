<?php

class hrdepartment{

    public function paymentday($date){
        //Returns Previous business day if the last day of the month falls on a weekend
        $CurrentMonthData = getdate($date);
        if($CurrentMonthData['wday']==0){
            $date = strtotime('-2 day', $date);
        } else if ($CurrentMonthData['wday']==6){
            $date = strtotime('-1 day', $date);
        }
        return $date;
    }

    public function bonusday($date){
        //Returns Next Wednesday of the week from 15th if the 15th falls on a weekend.
        $CurrentMonthData = getdate($date);
        if($CurrentMonthData['wday']==0){
            $date = strtotime('+3 day', $date);
        } else if($CurrentMonthData['wday']==6){
            $date = strtotime('+4 day', $date);
        }
        return $date;
    }

    public function displayPayDates($dateInput){
        //Returns a table
        $datedata = getdate($dateInput);
        $filename = "HRPaydates.csv";
        $fp = fopen($filename,"w");
        $CSVData =  "INSERTION INTO CSV VIA PHP SCRIPT \n Month,Salary Payment Date,Bonus Payment Date \n";
        fputs($fp, $CSVData);
        echo '<table id="container"><thead><tr><th>Month</th><th>Salary Payment Date</th><th>Bonus Payment Date</th></tr></thead><tbody>';
        for($i = $datedata['mon'];  $i<=12; $i++){
            //Generate Variables

            //SALARY PAYMENT DATE
            $CurrentMonthLastDateTimestamp = mktime(0,0,0,$i,date("t",mktime(0,0,0,$i)), $datedata['year']);
            $SalaryPaymentDate = date("d-M-Y", ($this->paymentday($CurrentMonthLastDateTimestamp)));

            //BONUS PAYMENT DATE
            $CurrentMonth15Timestamp = mktime(0,0,0,$i,15,$datedata['year']);
            $BonusPaymentDate = date("d-M-Y", ($this->bonusday($CurrentMonth15Timestamp)));

            $CSVData =  date("M", mktime(0, 0, 0, $i)).",".$SalaryPaymentDate.",". $BonusPaymentDate."\n";
            fputs($fp, $CSVData);
            echo '<tr><td>'.$i.' - '. date("M", mktime(0, 0, 0, $i)).'</td><td>'.$SalaryPaymentDate.'</td><td>'.$BonusPaymentDate.'</td></tr>';
        }

        echo '</tbody></table>';
        echo '<a href="HRPaydates.csv">Download CSV</a>';


    }
}

?>



<html >
<head>
    <title>HR DATES</title>
    <style type="text/css">
        #container td{
            width:150px;
        }
    </style>
</head>
<body>
<?php
    $Business = new hrdepartment();
    $Business->displayPayDates(time());
?>
</body>

</html>

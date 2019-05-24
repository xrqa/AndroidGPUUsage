#!/bin/sh

adb root
adb remount
adb shell "setenforce 0"

read -p "MEASURMENT TIME  (Unit: second): " time
read -p "OUTPUT FREQUENCY (Every n seconds): " output_frequency
read -p "TEST SCENARIO: " name
echo "Okay, let's measure $name memory usage."

let "count= $time / $output_frequency"

for ((n=0;n<count;n++))
do
current_date_time=`date "+%Y-%m-%d %H:%M:%S"`;
echo \n\n$current_date_time; 
echo "########## System Memory Usage ##########"
adb shell dumpsys meminfo | grep -A 3 "Total RAM:"
echo "########### App Memory Usage ###########"
adb shell dumpsys meminfo com.PGTeam.XRWorld | grep -A 11 "App Summary"

sleep $output_frequency
done

#!/bin/sh

adb root
adb remount
adb shell "setenforce 0"

read -p "MEASURMENT TIME  (Unit: second): " time
read -p "OUTPUT FREQUENCY (Every n seconds): " output_frequency
read -p "TEST SCENARIO: " name
echo "Okay, let's measure $name MEMORY and GPU usage."

let "count= $time / $output_frequency"

echo "\n-----------------------------GPU---------------------------------\n"
for ((n=0;n<count;n++))
do
adb shell cat /sys/class/kgsl/kgsl-3d0/gpu_busy_percentage
sleep $output_frequency
done

echo "\n-----------------------------MEMORY------------------------------\n"
adb shell dumpsys meminfo com.PGTeam.XRWorld

echo "\n-----------------------------FPS---------------------------------\n"
adb logcat -d | grep -i "FPS:" | tail -60

#!/system/bin/sh
echo "power and temperature reading started...."

ini_signal="echo 1 > /data/local/tmp/signal.txt"
exec_signal=$(eval $ini_signal)

signal="cat /data/local/tmp/signal.txt"
exec_signal=$(eval $signal)

file_name=profile.txt
current_time=$(date "+%T")
new_fileName=$current_time.$file_name

while [[ $exec_signal != "0" ]]
do

TEMP_0="cat /sys/class/thermal/thermal_zone0/temp"
TEMP_1="cat /sys/class/thermal/thermal_zone1/temp"
TEMP_2="cat /sys/class/thermal/thermal_zone2/temp"
C_CMD="cat /sys/class/power_supply/battery/current_now"
V_CMD="cat /sys/class/power_supply/battery/voltage_now"
POW_AVG="cat /sys/class/power_supply/battery/power_avg"
POW_NOW="cat /sys/class/power_supply/battery/power_now"
F_BIG="cat /sys/devices/system/cpu/cpu4/cpufreq/scaling_cur_freq"
F_SMALL="cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq"
F_GPU_MAX="cat /sys/kernel/gpu/gpu_max_clock"
F_GPU="cat /sys/kernel/gpu/gpu_clock"
GPU_BUSY="cat /sys/kernel/gpu/gpu_busy"
OUT_TEMP0=$(eval $TEMP_0)
OUT_TEMP1=$(eval $TEMP_1)
OUT_TEMP2=$(eval $TEMP_2)
OUT_POW=$(eval $C_CMD)
OUT_V=$(eval $V_CMD)
OUT_POW_AVG=$(eval $POW_AVG)
OUT_POW_NOW=$(eval $POW_NOW)
OUT_FBIG=$(eval $F_BIG)
OUT_FSMALL=$(eval $F_SMALL)
OUT_FGPU_MAX=$(eval $F_GPU_MAX)
OUT_FGPU=$(eval $F_GPU)
OUT_GPU_BUSY=$(eval $GPU_BUSY)
TEMP0=$((OUT_TEMP0 / 100))
TEMP1=$((OUT_TEMP1 / 100))
TEMP2=$((OUT_TEMP2 / 100))
FPS=$(source get_fps.sh)

echo $TEMP0,$TEMP1,$TEMP2,$OUT_POW,$OUT_V,$OUT_POW_AVG,$OUT_POW_NOW,$OUT_FBIG,$OUT_FSMALL,$OUT_FGPU_MAX,$OUT_FGPU,$OUT_GPU_BUSY,$FPS >> /data/local/tmp/$new_fileName

signal="cat /data/local/tmp/signal.txt"
exec_signal=$(eval $signal)
sleep 0.2

done
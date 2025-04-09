#!/bin/bash

LOG_FILE="query_execution_times.csv"

# Lấy thời gian thực hiện
CPU_time="$(date +"%Y-%m-%d %H:%M:%S.%3N")"
CPU_USAGE="$(LC_NUMERIC="C" mpstat 1 1 | awk 'NR==4 {printf "%.2f", 100.00 - $NF; exit}')"
GPU_time="$(date +"%Y-%m-%d %H:%M:%S.%3N")"
GPU_USAGE="$(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits | tr -d '[:space:]')"
RAM_time="$(date +"%Y-%m-%d %H:%M:%S.%3N")"
RAM_USED="$(free -m | awk '/Mem:/ {printf "%.2f\n", $3/1024}')"
VRAM_time="$(date +"%Y-%m-%d %H:%M:%S.%3N")"
VRAM_USED="$(nvidia-smi --query-gpu=memory.used --format=csv,noheader,nounits | awk '{printf "%.2f", $1/1024}')"
POWER_time="$(date +"%Y-%m-%d %H:%M:%S.%3N")"
POWER_USE="$(nvidia-smi --query-gpu=power.draw --format=csv,noheader,nounits | tr -d '[:space:]')"

# Ghi vào file log
echo "$CPU_time, $CPU_USAGE, $GPU_time, $GPU_USAGE, $RAM_time, $RAM_USED, $VRAM_time, $VRAM_USED, $POWER_time, $POWER_USE" >> "$LOG_FILE"


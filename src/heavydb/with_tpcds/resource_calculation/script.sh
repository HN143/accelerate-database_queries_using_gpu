#!/bin/bash

LOG_FILE="query_execution_times.log"

# Lấy thời gian thực hiện
CPU_USAGE=$(LC_NUMERIC="C" mpstat 1 1 | awk 'NR==4 {printf "%.2f\n", 100.00 - $NF; exit}')
GPU_USAGE=$(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits | tr -d '[:space:]')
RAM_USED=$(free -m | awk '/Mem:/ {printf "%.2f\n", $3/1024}')
VRAM_USED=$(nvidia-smi --query-gpu=memory.used --format=csv,noheader,nounits | awk '{printf "%.2f", $1/1024}')
POWER_USE=$(nvidia-smi --query-gpu=power.draw --format=csv,noheader,nounits | tr -d '[:space:]')

# Ghi vào file log
echo "$(date +%H:%M:%S), $CPU_USAGE%, $GPU_USAGE%, $RAM_USED Gb, $VRAM_USED Gb, $POWER_USE W" >> "$LOG_FILE"


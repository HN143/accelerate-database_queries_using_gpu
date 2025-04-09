#!/bin/bash

# Kiểm tra tham số logdir
if [ -z "$1" ]; then
  echo "Usage: $0 <logdir>"
  exit 1
fi

LOG_DIR=$1
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCRIPT_TO_RUN="$SCRIPT_DIR/script.sh"
DURATION=65
INTERVAL=0.1

chmod +x "$SCRIPT_TO_RUN"

echo "Starting process launcher. Running $SCRIPT_TO_RUN every $INTERVAL seconds for $DURATION seconds with logdir=$LOG_DIR..."

# Tạo log tổng (nếu muốn theo dõi chung)
LOG_FILE="$LOG_DIR/query_execution_times.csv"
mkdir -p "$LOG_DIR"
> "$LOG_FILE"
echo "CPU_time(ms), CPU_USAGE(%), GPU_time(ms), GPU_USAGE(%), RAM_time(ms), RAM_USED(Gb), VRAM_time(ms), VRAM_USED(Gb), POWER_time(ms), POWER_USE(W)" >> "$LOG_FILE"

# Giới hạn thời gian chạy bằng timeout, truyền logdir vào SCRIPT_TO_RUN
timeout $DURATION bash -c '
while true; do
    '"$SCRIPT_TO_RUN"' '"$LOG_DIR"' &  # Truyền logdir làm đối số
    sleep '"$INTERVAL"'
done
'

echo "Launcher finished! All processes have been started."


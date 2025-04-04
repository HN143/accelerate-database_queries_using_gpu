#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"  # Đường dẫn tới thư mục
SCRIPT_TO_RUN="$SCRIPT_DIR/script.sh"
DURATION=50                  # Thời gian chạy (giây)
INTERVAL=0.1                # Khoảng thời gian giữa các tiến trình

chmod +x "$SCRIPT_TO_RUN"

echo "Starting process launcher. Running $SCRIPT_TO_RUN every $INTERVAL seconds for $DURATION seconds..."

# Tạo tệp log để lưu thời gian
log_file="query_execution_times.csv"
> $log_file # Xóa nội dung tệp log trước khi bắt đầu

echo "CPU_time(ms), CPU_USAGE(%), GPU_time(ms), GPU_USAGE(%), RAM_time(ms), RAM_USED(Gb), VRAM_time(ms), VRAM_USED(Gb), POWER_time(ms), POWER_USE(W)">> $log_file

# Giới hạn thời gian chạy bằng timeout
timeout $DURATION bash -c '
while true; do
    '"$SCRIPT_TO_RUN"' &  # Chạy script gốc trong nền
    sleep '"$INTERVAL"'
done
'

echo "Launcher finished! All processes have been started."


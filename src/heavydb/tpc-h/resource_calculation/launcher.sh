#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"  # Đường dẫn tới thư mục
SCRIPT_TO_RUN="$SCRIPT_DIR/script.sh"
DURATION=50                  # Thời gian chạy (giây)
INTERVAL=0.05                # Khoảng thời gian giữa các tiến trình

chmod +x "$SCRIPT_TO_RUN"

echo "Starting process launcher. Running $SCRIPT_TO_RUN every $INTERVAL seconds for $DURATION seconds..."

# Giới hạn thời gian chạy bằng timeout
timeout $DURATION bash -c '
while true; do
    '"$SCRIPT_TO_RUN"' &  # Chạy script gốc trong nền
    sleep '"$INTERVAL"'
done
'

echo "Launcher finished! All processes have been started."


#!/bin/bash

set -e  # Stop script if any command fails

# Check if both arguments are provided
if [ $# -ne 2 ]; then
    echo "Usage: $0 <scale_factor> <run_number>"
    echo "Allowed scale factors: 1, 2, 5, 10, 20, 50, 100"
    echo "Run number: Positive integer (1, 2, 3, ...)"
    exit 1
fi

SCALE_FACTOR=$1
NUMBER_TIME=$2

# Validate scale factor
if [[ ! "$SCALE_FACTOR" =~ ^(1|2|5|10|20|50|100)$ ]]; then
    echo "Error: Scale factor must be 1, 2, 5, 10, 20, 50, or 100"
    echo "Usage: $0 <scale_factor> <run_number>"
    exit 1
fi

# Validate run number is a positive integer
if ! [[ "$NUMBER_TIME" =~ ^[1-9][0-9]*$ ]]; then
    echo "Error: Run number must be a positive integer"
    echo "Usage: $0 <scale_factor> <run_number>"
    exit 1
fi

# Define paths based on scale factor
DB_PATH="../tpc-ds_nckh.duckdb"
QUERY_DIR="../sql/query${SCALE_FACTOR}/splited"
LOG_DIR="../result_log/result_log_${SCALE_FACTOR}GB/time_${NUMBER_TIME}"
CSV_FILE="${LOG_DIR}/query_sys_params.csv"
TIME_CSV_FILE="${LOG_DIR}/query_times.csv"

# Tạo thư mục log nếu chưa tồn tại
mkdir -p "$LOG_DIR"

# Tạo file CSV với header
echo "query_id, cpu_used(%), ram_used(gb)" > "$CSV_FILE"
echo "query_id, real_time(s), user_time(s), sys_time(s)" > "$TIME_CSV_FILE"

# Hàm lấy CPU usage
get_cpu_usage() {
    # Change from comma to dot decimal separator
    top -bn1 | grep "Cpu(s)" | awk '{print $2}' | sed 's/,/./g' || echo "0"
}

# Hàm lấy RAM usage (GB)
get_ram_usage() {
    free -m | awk '/Mem:/ {printf "%.2f", $3/1024}' | sed 's/,/./g' || echo "0"
}

# Chạy 22 truy vấn tuần tự
echo "### Running TPC-H benchmark with ${SCALE_FACTOR}GB data..."

for i in $(seq 1 99); do
    # Đặt tên file truy vấn
    QUERY_ID="$(printf "%02d" $i)"
    QUERY_FILE="${QUERY_DIR}/query-${QUERY_ID}.sql"

    if [ -f "$QUERY_FILE" ]; then
        echo "Running query $i..."
        
        # Chạy truy vấn và xử lý đầu ra trực tiếp
        {
            # Lưu đầu ra vào biến
            output=$(echo -e ".timer on\n$(cat "$QUERY_FILE")" | duckdb "$DB_PATH" 2>&1)
            exit_status=$?
            if [ $exit_status -ne 0 ]; then
                echo "Query $QUERY_ID failed with exit status $exit_status. Error output:"
                echo "$output"
                echo "$QUERY_ID, 0, 0" >> "$CSV_FILE"
                echo "$QUERY_ID, 0, 0, 0" >> "$TIME_CSV_FILE"
            else
                # Kiểm tra và trích xuất thời gian từ đầu ra
                if echo "$output" | grep -q "Run Time (s)"; then
                    echo "$output" | grep "Run Time (s)" | awk -v qid="$QUERY_ID" '{
                        printf "%s, %s, %s, %s\n", qid, $5, $7, $9
                    }' >> "$TIME_CSV_FILE"
                else
                    echo "No timing data found for query $QUERY_ID. Output:"
                    echo "$output"
                    echo "$QUERY_ID, 0, 0, 0" >> "$TIME_CSV_FILE"
                fi
            fi
        } &
        query_pid=$!

        # Theo dõi hệ thống trong khi truy vấn chạy
        while kill -0 $query_pid 2>/dev/null; do
            cpu_usage=$(get_cpu_usage)
            ram_usage=$(get_ram_usage)
            echo "$QUERY_ID, $cpu_usage, $ram_usage" >> "$CSV_FILE"
            sleep 0.05
        done
        wait $query_pid || echo "Query $QUERY_ID process failed"
    else
        echo "Query file $QUERY_FILE does not exist"
        echo "$QUERY_ID, 0, 0" >> "$CSV_FILE"
        echo "$QUERY_ID, 0, 0, 0" >> "$TIME_CSV_FILE"
    fi
done

echo "### Benchmark completed! Results saved to $CSV_FILE and $TIME_CSV_FILE."
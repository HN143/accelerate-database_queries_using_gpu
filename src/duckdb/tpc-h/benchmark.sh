#!/bin/bash

set -e  # Stop script if any command fails

# Check if both arguments are provided
if [ $# -ne 2 ]; then
    echo "Usage: $0 <scale_factor> <run_number>"
    echo "Allowed scale factors: 1, 10, 50, 100"
    echo "Run number: Positive integer (1, 2, 3, ...)"
    exit 1
fi

SCALE_FACTOR=$1
NUMBER_TIME=$2

# Validate scale factor
if [[ ! "$SCALE_FACTOR" =~ ^(1|10|50|100)$ ]]; then
    echo "Error: Scale factor must be 1, 10, 50, or 100"
    echo "Usage: $0 <scale_factor> <run_number>"
    exit 1
fi

# Validate run number is a positive integer
if ! [[ "$NUMBER_TIME" =~ ^[1-9][0-9]*$ ]]; then
    echo "Error: Run number must be a positive integer"
    echo "Usage: $0 <scale_factor> <run_number>"
    exit 1
fi

# Define suffix for run number (1st, 2nd, 3rd, etc.)
get_suffix() {
    case "$1" in
        *1[0-9]) echo "th";;
        *1) echo "st";;
        *2) echo "nd";;
        *3) echo "rd";;
        *) echo "th";;
    esac
}

SUFFIX=$(get_suffix $NUMBER_TIME)

# Define paths based on scale factor
DB_PATH="tpc-h_nckh.duckdb"
QUERY_DIR="../../heavydb/tpc-h/sql/queries_${SCALE_FACTOR}"
LOG_DIR="result_log/result_log_${SCALE_FACTOR}"
CSV_FILE="${LOG_DIR}/${NUMBER_TIME}${SUFFIX}_query_execution_times.csv"

# Create log directory if it doesn't exist
mkdir -p "$LOG_DIR"

# Create CSV file with headers using pipe separator, without numerical_order
echo "query_id | cpu_time(ms) | cpu_used(%) | ram_time(ms) | ram_used(gb)" > "$CSV_FILE"

# Function to get current timestamp in desired format
get_timestamp() {
    date '+%Y-%m-%d %H:%M:%S.%3N'
}

# Function to get CPU usage
get_cpu_usage() {
    top -bn1 | grep "Cpu(s)" | awk '{print $2}' | cut -d. -f1
}

# Function to get RAM usage in GB
get_ram_usage() {
    free -m | awk '/Mem:/ {printf "%.2f", $3/1024}'
}

# Run 22 queries sequentially starting from 1
echo "### Running TPC-H benchmark with ${SCALE_FACTOR}GB data..."

for i in $(seq 1 22); do
    # Update query file name: no leading zero for 1-9, keep as is for 10-22
    if [ $i -lt 10 ]; then
        QUERY_FILE="${QUERY_DIR}/${i}.sql"
        QUERY_ID="$i"
    else
        QUERY_FILE="${QUERY_DIR}/${i}.sql"
        QUERY_ID="$(printf "%02d" $i)"
    fi

    if [ -f "$QUERY_FILE" ]; then
        echo "Running query $i..."
        
        # Get system metrics every 0.05s during query execution
        (
            # Start query execution in background
            {
                duckdb "$DB_PATH" < "$QUERY_FILE" 2>/dev/null
                exit_status=$?
                if [ $exit_status -ne 0 ]; then
                    echo "$QUERY_ID | $(get_timestamp) | 0 | $(get_timestamp) | 0" >> "$CSV_FILE"
                    exit 1
                fi
            } &
            query_pid=$!

            # Monitor system while query runs
            while kill -0 $query_pid 2>/dev/null; do
                cpu_time=$(get_timestamp)
                cpu_usage=$(get_cpu_usage)
                ram_time=$(get_timestamp)
                ram_usage=$(get_ram_usage)
                echo "$QUERY_ID | $cpu_time | $cpu_usage | $ram_time | $ram_usage" >> "$CSV_FILE"
                sleep 0.05
            done
        ) || {
            # If query fails, log zeros
            echo "$QUERY_ID | $(get_timestamp) | 0 | $(get_timestamp) | 0" >> "$CSV_FILE"
        }
    else
        # If query file doesn't exist, log zeros
        echo "$QUERY_ID | $(get_timestamp) | 0 | $(get_timestamp) | 0" >> "$CSV_FILE"
    fi
done

echo "### Benchmark completed! Results saved to $CSV_FILE."
#!/bin/bash
# filepath: /home/tuyen/accelerate-database_queries_using_gpu/src/duckdb/process/benchmark.sh

set -e  # Stop script if any command fails

# Assume validation is done in main.sh
TYPE=$1
SCALE_FACTOR=$2
NUMBER_TIME=$3

# Set variables based on type
if [ "$TYPE" -eq 1 ]; then
    # TPC-H
    BENCHMARK="TPC-H"
    DB_PATH="/mnt/data/storage/tpch/${SCALE_FACTOR}GB.duckdb"
    QUERY_DIR="tpc-h/sql/queries_${SCALE_FACTOR}"
    
    # Check if query directory exists, fallback to scale_factor=1 if not
    if [ ! -d "$QUERY_DIR" ]; then
        echo "Warning: Directory $QUERY_DIR not found, falling back to scale_factor=1"
        QUERY_DIR="tpc-h/sql/queries_1"
    fi
    
    MAX_QUERIES=22
    LOG_DIR="../benchmark_result/on_c7a_8xlarge/duckdb/tpc-h/result_log/result_log_${SCALE_FACTOR}GB/time_${NUMBER_TIME}"
else
    # TPC-DS
    BENCHMARK="TPC-DS"
    DB_PATH="/mnt/data/storage/tpcds/${SCALE_FACTOR}.duckdb"
    QUERY_DIR="tpc-ds/sql/query${SCALE_FACTOR}/splited"
    
    # Check if query directory exists, fallback to scale_factor=1 if not
    if [ ! -d "$QUERY_DIR" ]; then
        echo "Warning: Directory $QUERY_DIR not found, falling back to scale_factor=1"
        QUERY_DIR="tpc-ds/sql/query1/splited"
    fi
    
    MAX_QUERIES=99
    LOG_DIR="../benchmark_result/on_c7a_8xlarge/duckdb/tpc-ds/result_log/result_log_${SCALE_FACTOR}GB/time_${NUMBER_TIME}"
fi

# Define common paths
# CSV_FILE="${LOG_DIR}/query_sys_params.csv"
TIME_CSV_FILE="${LOG_DIR}/query_times.csv"

# Create log directory if it doesn't exist
mkdir -p "$LOG_DIR"

# Create CSV files with headers
# echo "query_id, cpu_used(%), ram_used(gb)" > "$CSV_FILE"
echo "query_id, real_time(s), user_time(s), sys_time(s)" > "$TIME_CSV_FILE"

# Function to get CPU usage
# get_cpu_usage() {
#     # Change from comma to dot decimal separator
#     top -bn1 | grep "Cpu(s)" | awk '{print $2}' | sed 's/,/./g' || echo "0"
# }

# Function to get RAM usage (GB)
# get_ram_usage() {
#     free -m | awk '/Mem:/ {printf "%.2f", $3/1024}' | sed 's/,/./g' || echo "0"
# }

echo "### Running $BENCHMARK benchmark with ${SCALE_FACTOR}GB data..."

for i in $(seq 1 $MAX_QUERIES); do
    # Set query file path based on benchmark type
    if [ "$TYPE" -eq 1 ]; then
        # TPC-H
        if [ $i -lt 10 ]; then
            QUERY_FILE="${QUERY_DIR}/${i}.sql"
            QUERY_ID="$i"
        else
            QUERY_FILE="${QUERY_DIR}/${i}.sql"
            QUERY_ID="$(printf "%02d" $i)"
        fi
    else
        # TPC-DS
        QUERY_ID="$(printf "%02d" $i)"
        QUERY_FILE="${QUERY_DIR}/query-${QUERY_ID}.sql"
    fi

    if [ -f "$QUERY_FILE" ]; then
        echo "Running query $i..."
        
        # Run query and process output
        {
            # Save output to variable
            output=$(echo -e ".timer on\n$(cat "$QUERY_FILE")" | duckdb "$DB_PATH" 2>&1)
            exit_status=$?
            if [ $exit_status -ne 0 ]; then
                echo "Query $QUERY_ID failed with exit status $exit_status. Error output:"
                echo "$output"
                # echo "$QUERY_ID, 0, 0" >> "$CSV_FILE"
                echo "$QUERY_ID, 0, 0, 0" >> "$TIME_CSV_FILE"
            else
                # Check and extract time from output
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

        # Monitor system while query is running
        # while kill -0 $query_pid 2>/dev/null; do
        #     cpu_usage=$(get_cpu_usage)
        #     ram_usage=$(get_ram_usage)
        #     echo "$QUERY_ID, $cpu_usage, $ram_usage" >> "$CSV_FILE"
        #     sleep 0.1
        # done
        wait $query_pid || echo "Query $QUERY_ID process failed"
    else
        echo "Query file $QUERY_FILE does not exist"
        # echo "$QUERY_ID, 0, 0" >> "$CSV_FILE"
        echo "$QUERY_ID, 0, 0, 0" >> "$TIME_CSV_FILE"
    fi
done

echo "### Benchmark completed! Results saved to $CSV_FILE and $TIME_CSV_FILE."
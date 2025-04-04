#!/bin/bash

set -e  # Stop script if any command fails

# Define paths
DB_PATH="./tpc-ds_nckh.duckdb"  # Cùng cấp với script này
QUERY_DIR="../../heavydb/with_tpcds/sql/queries"
RESULTS_FILE="runtime_results.txt"

# Create or clear results file
echo "### Running TPC-DS benchmark and saving results to $RESULTS_FILE..."
> "$RESULTS_FILE"

# Run each query multiple times (e.g., 5 times per query)
RUNS=5
runtime_counter=1

for i in {1..99}; do
    query_file="$QUERY_DIR/query-$(printf "%02d" $i).sql"
    
    if [[ -f "$query_file" ]]; then
        echo "Running query $i..."
        for ((run=1; run<=RUNS; run++)); do
            echo "Runtime $runtime_counter - Query $i" >> "$RESULTS_FILE"
            start_time=$(date +%s%3N)  # Lấy thời gian trước khi chạy
            duckdb "$DB_PATH" < "$query_file" | grep "Run Time (s):" >> "$RESULTS_FILE"
            end_time=$(date +%s%3N)  # Lấy thời gian sau khi chạy
            echo "Runtime $runtime_counter completed in $((end_time - start_time)) ms" >> "$RESULTS_FILE"
            ((runtime_counter++))
        done
    else
        echo "Query file $query_file does not exist, skipping..."
    fi
done

echo "### Benchmark completed! Results saved to $RESULTS_FILE."

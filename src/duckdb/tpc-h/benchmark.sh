#!/bin/bash

set -e  # Stop script if any command fails

# Check if scale factor argument is provided
if [ $# -ne 1 ]; then
    echo "Usage: $0 <scale_factor>"
    echo "Allowed scale factors: 1, 10, 50, 100"
    exit 1
fi

SCALE_FACTOR=$1

# Validate scale factor
if [[ ! "$SCALE_FACTOR" =~ ^(1|10|50|100)$ ]]; then
    echo "Error: Scale factor must be 1, 10, 50, or 100"
    echo "Usage: $0 <scale_factor>"
    exit 1
fi

# Define paths based on scale factor
DB_PATH="tpc-h_nckh.duckdb"
QUERY_DIR="../../heavydb/tpc-h/sql/queries_${SCALE_FACTOR}"
LOG_DIR="result_log/result_log_${SCALE_FACTOR}"
BENCHMARK_LOG="${LOG_DIR}/duckdb_output.log"
RESULTS_FILE="${LOG_DIR}/runtime_results.txt"

# Create log directory if it doesn't exist
mkdir -p "$LOG_DIR"

# Create benchmark log file
echo "### Running TPC-H benchmark with ${SCALE_FACTOR}GB data and saving results to $BENCHMARK_LOG..."

# Run queries and log execution time
{
  echo ".timer on"
  for query_file in "$QUERY_DIR"/*.sql; do
    cat "$query_file"
  done
} | duckdb "$DB_PATH" | tee "$BENCHMARK_LOG"

# Extract execution time from log
echo "Extracting execution time from $BENCHMARK_LOG into $RESULTS_FILE..."
grep "Run Time (s):" "$BENCHMARK_LOG" > "$RESULTS_FILE"

echo "### Benchmark completed! Results saved to $RESULTS_FILE."
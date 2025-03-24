#!/bin/bash

set -e  # Stop script if any command fails

# Define paths
DB_PATH="$HOME/nckh.duckdb"
QUERY_DIR="$HOME/accelerate-database_queries_using_gpu/src/tpcds/results/test_queries"
BENCHMARK_LOG="duckdb_output.log"
RESULTS_FILE="runtime_results.txt"

# Create benchmark log file
echo "### Running TPC-DS benchmark and saving results to $BENCHMARK_LOG..."

# Run queries and log execution time
{
  echo ".timer on"
  for query_file in "$QUERY_DIR"/query_*.sql; do
    cat "$query_file"
  done
} | duckdb "$DB_PATH" | tee "$BENCHMARK_LOG"

# Extract execution time from log
echo "Extracting execution time from $BENCHMARK_LOG into $RESULTS_FILE..."
grep "Run Time (s):" "$BENCHMARK_LOG" > "$RESULTS_FILE"

echo "### Benchmark completed! Results saved to $RESULTS_FILE."

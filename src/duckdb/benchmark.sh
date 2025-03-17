#!/bin/bash

set -e  # Stop script if any command fails

# Create benchmark log file

BENCHMARK_LOG="duckdb_output.log"
RESULTS_FILE="runtime_results.txt"
OUTPUT_IMAGE="runtime_plot.png"

echo "### Running TPC-H benchmark and saving results to $BENCHMARK_LOG..."
{
  echo ".timer on"
  for i in {1..22}; do
    echo "PRAGMA tpch($i);"
  done
} | duckdb tpch.duckdb | tee "$BENCHMARK_LOG"

# Extract execution time from log
echo "Extracting execution time from $BENCHMARK_LOG into $RESULTS_FILE..."
grep "Run Time (s):" "$BENCHMARK_LOG" > "$RESULTS_FILE"

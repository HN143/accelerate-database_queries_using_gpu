#!/bin/bash
# filepath: /home/tuyen/accelerate-database_queries_using_gpu/src/duckdb/main.sh

set -e  # Stop script if any command fails

# Check if arguments are provided
if [ $# -ne 3 ]; then
    echo "Usage: $0 <type> <scale_factor> <num_runs>"
    echo "  type: 1 for TPC-H, 2 for TPC-DS"
    echo "  scale_factor: benchmark size"
    echo "    TPC-H allowed scale factors: 1, 10, 50, 100"
    echo "    TPC-DS allowed scale factors: 1, 2, 5, 10, 20, 50, 100"
    echo "  num_runs: number of benchmark runs to perform"
    exit 1
fi

TYPE=$1
SCALE_FACTOR=$2
NUM_RUNS=$3

# Validate benchmark type
if [[ ! "$TYPE" =~ ^(1|2)$ ]]; then
    echo "Error: Type must be 1 (TPC-H) or 2 (TPC-DS)"
    exit 1
fi

# Validate scale factor based on benchmark type
if [ "$TYPE" -eq 1 ]; then
    # Validate scale factor for TPC-H
    if [[ ! "$SCALE_FACTOR" =~ ^(1|10|50|100)$ ]]; then
        echo "Error: For TPC-H, scale factor must be 1, 10, 50, or 100"
        exit 1
    fi
    # Set TPC-H specific variables
    BENCHMARK_NAME="TPC-H"
    DUCKDB_DB="tpc-h/tpc-h_nckh.duckdb"
else
    # Validate scale factor for TPC-DS
    if [[ ! "$SCALE_FACTOR" =~ ^(1|2|5|10|20|50|100)$ ]]; then
        echo "Error: For TPC-DS, scale factor must be 1, 2, 5, 10, 20, 50, or 100"
        exit 1
    fi
    # Set TPC-DS specific variables
    BENCHMARK_NAME="TPC-DS"
    DUCKDB_DB="tpc-ds/tpc-ds_nckh.duckdb"
fi

# Validate num_runs is a positive integer
if ! [[ "$NUM_RUNS" =~ ^[1-9][0-9]*$ ]]; then
    echo "Error: Number of runs must be a positive integer"
    exit 1
fi

echo "======================================================"
echo "Starting $BENCHMARK_NAME benchmark with scale factor $SCALE_FACTOR"
echo "Will perform $NUM_RUNS benchmark runs"
echo "======================================================"

# Step 1: Generate the data
echo "[1/2] Generating data..."
./process/generate_data.sh $TYPE $SCALE_FACTOR

if [ $? -ne 0 ]; then
    echo "Error: Data generation failed. Exiting."
    exit 1
fi

echo "Data generation completed successfully."
echo

# Step 2: Run benchmarks multiple times
echo "[2/2] Running benchmark tests..."

for run in $(seq 1 $NUM_RUNS); do
    echo "----------------------------------------------------"
    echo "Starting benchmark run $run of $NUM_RUNS"
    echo "----------------------------------------------------"
    
    ./process/benchmark.sh $TYPE $SCALE_FACTOR $run
    
    if [ $? -ne 0 ]; then
        echo "Warning: Benchmark run $run failed."
    else
        echo "Benchmark run $run completed successfully."
    fi
    
    echo
done

# Step 3: Clean up the database file
echo "[3/3] Cleaning up..."

if [ -f "$DUCKDB_DB" ]; then
    echo "Removing database file '$DUCKDB_DB'..."
    rm "$DUCKDB_DB"
    echo "Database file removed."
else
    echo "Database file '$DUCKDB_DB' not found. No cleanup needed."
fi

echo "======================================================"
echo "All benchmark tasks completed."
echo "======================================================"
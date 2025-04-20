#!/bin/bash

set -e

# sudo apt update -y

# # Install DuckDB
# echo "### Installing DuckDB..."
# sudo apt install -y curl
# curl https://install.duckdb.org | sh
# chmod +x $HOME/.duckdb/cli/latest/duckdb
# sudo ln -sf $HOME/.duckdb/cli/latest/duckdb /usr/local/bin/duckdb

# echo "DuckDB has completed execution. Data exported to: $TARGET_DIR"

SCALE_FACTORS=(1 5 10 20 30 50 100)
DUCKDB_CMD="duckdb"

echo "Render data for TPC-H benchmark"
echo "======================================================"

for SF in "${SCALE_FACTORS[@]}"; do
    echo "Starting TPC-H benchmark with scale factors: ${SF}GB"
    echo "======================================================"
    DB_PATH="storage/tpch/${SF}GB.duckdb"
    mkdir -p "$(dirname "$DB_PATH")"

    start_time=$(date +%s)
    # Generate TPC-H data and load into DuckDB
    $DUCKDB_CMD "$DB_PATH" <<EOF
INSTALL tpch;
LOAD tpch;
CALL dbgen(sf=$SF);
EOF
    end_time=$(date +%s)
    elapsed=$((end_time - start_time))
    echo "Finished generating TPC-H ${SF}GB in ${elapsed} seconds"
done

echo "Render data successfully for TPC-H benchmark"
echo "======================================================"

echo "Render data for TPC-DS benchmark"
echo "======================================================"

for SF in "${SCALE_FACTORS[@]}"; do
    echo "Starting TPC-DS benchmark with scale factors: ${SF}GB"
    echo "======================================================"
    DB_PATH="storage/tpcds/${SF}GB.duckdb"
    mkdir -p "$(dirname "$DB_PATH")"

    start_time=$(date +%s)
    # Generate TPC-DS data and load into DuckDB
    $DUCKDB_CMD "$DB_PATH" <<EOF
INSTALL tpcds;
LOAD tpcds;
CALL dsdgen(sf=$SF);
EOF
    end_time=$(date +%s)
    elapsed=$((end_time - start_time))
    echo "Finished generating TPC-DS ${SF}GB in ${elapsed} seconds"
done
echo "Render data successfully for TPC-DS benchmark"
echo "======================================================"

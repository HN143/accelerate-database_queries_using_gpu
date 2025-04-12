#!/bin/bash
# filepath: /home/tuyen/accelerate-database_queries_using_gpu/src/duckdb/process/generate_data.sh

set -e  # Stop script if any command fails

# Assume validation is done in main.sh
TYPE=$1
SCALE_FACTOR=$2

# Set variables based on type
if [ "$TYPE" -eq 1 ]; then
    # TPC-H
    BENCHMARK="TPC-H"
    EXTENSION="tpch"
    GEN_FUNCTION="dbgen"
    DUCKDB_DB="tpc-h/tpc-h_nckh.duckdb"
else
    # TPC-DS
    BENCHMARK="TPC-DS"
    EXTENSION="tpcds"
    GEN_FUNCTION="dsdgen"
    DUCKDB_DB="tpc-ds/tpc-ds_nckh.duckdb"
fi

# Check if database file exists and delete it
if [ -f "$DUCKDB_DB" ]; then
    echo "Database file '$DUCKDB_DB' exists. Removing it..."
    rm "$DUCKDB_DB"
fi

echo "Generating $BENCHMARK data with scale factor $SCALE_FACTOR..."

# Run DuckDB and execute SQL commands
duckdb "$DUCKDB_DB" <<EOF
INSTALL $EXTENSION;
LOAD $EXTENSION;
SELECT * FROM $GEN_FUNCTION(sf=$SCALE_FACTOR);
EOF

echo "Running DuckDB with database '$DUCKDB_DB'..."
echo "Process completed successfully."
#!/bin/bash

set -e  # Stop script if any command fails

# Define paths for SQL files
CREATE_SQL="../../heavydb/with_tpcds/sql/create_table.sql"
LOAD_SQL="./load_data.sql"
DUCKDB_DB="tpc-ds_nckh.duckdb"

# Check if files exist
if [ ! -f "$CREATE_SQL" ]; then
    echo "Error: File '$CREATE_SQL' does not exist."
    exit 1
fi

if [ ! -f "$LOAD_SQL" ]; then
    echo "Error: File '$LOAD_SQL' does not exist."
    exit 1
fi

echo "Running DuckDB with database '$DUCKDB_DB'..."

# Execute SQL scripts in DuckDB
duckdb "$DUCKDB_DB" < "$CREATE_SQL"
duckdb "$DUCKDB_DB" < "$LOAD_SQL"

echo "Process completed successfully."

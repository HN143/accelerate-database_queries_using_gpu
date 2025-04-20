#!/bin/bash

set -e

DUCKDB_CMD="duckdb"
SCALE_FACTORS=(1 5 10 20 30 50)

# Export TPC-H
for SF in "${SCALE_FACTORS[@]}"; do
    DB_FILE="/mnt/data/storage/tpch/${SF}GB.duckdb"
    EXPORT_DIR="export/tpch/${SF}"
    if [ -f "$DB_FILE" ]; then
        mkdir -p "$EXPORT_DIR"
        echo "Exporting $DB_FILE to $EXPORT_DIR"
        $DUCKDB_CMD "$DB_FILE" <<EOF
EXPORT DATABASE '$EXPORT_DIR' (FORMAT CSV, DELIMITER '|');
EOF
    else
        echo "File $DB_FILE does not exist, skipping."
    fi
done

# Export TPC-DS
for SF in "${SCALE_FACTORS[@]}"; do
    DB_FILE="/mnt/data/storage/tpcds/${SF}GB.duckdb"
    EXPORT_DIR="export/tpcds/${SF}"
    if [ -f "$DB_FILE" ]; then
        mkdir -p "$EXPORT_DIR"
        echo "Exporting $DB_FILE to $EXPORT_DIR"
        $DUCKDB_CMD "$DB_FILE" <<EOF
EXPORT DATABASE '$EXPORT_DIR' (FORMAT CSV, DELIMITER '|');
EOF
    else
        echo "File $DB_FILE does not exist, skipping."
    fi
done

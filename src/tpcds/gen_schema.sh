#!/bin/bash

set -eu

OUTPUT_DIR="$HOME/heavyai/tpcds"

# Create directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"

# Copy the SQL file
cp "tools/tpcds.sql" "$OUTPUT_DIR/tpcds.sql"

# Remove primary key definitions
python3 remove_primary_key.py

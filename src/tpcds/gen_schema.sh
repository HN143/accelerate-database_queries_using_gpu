#!/bin/bash

set -eu

# Create directory if it doesn't exist
mkdir -p "$HOME/heavyai/tpcds"

# Copy the SQL file
cp "tools/tpcds.sql" "$HOME/heavyai/tpcds/tpcds.sql"

# Remove primary key definitions
python3 remove_primary_key.py

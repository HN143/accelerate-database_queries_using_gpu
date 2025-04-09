#!/bin/bash

# Script to remove primary key definitions from the TPC-DS schema file

# Define the input and output files
INPUT_FILE="results/tpcds.sql"
TEMP_FILE="results/tpcds_no_pk.sql"

# Check if the input file exists
if [ ! -f "$INPUT_FILE" ]; then
    echo "Error: Input file $INPUT_FILE not found."
    exit 1
fi

# Remove lines containing primary key definitions
grep -v "    primary key" "$INPUT_FILE" > "$TEMP_FILE"

# Replace the original file with the modified one
mv "$TEMP_FILE" "$INPUT_FILE"

echo "Primary key definitions have been removed from $INPUT_FILE"

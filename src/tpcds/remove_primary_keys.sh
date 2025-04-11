#!/bin/bash

# Define input and output file paths
INPUT_FILE="results/tpcds.sql"
TEMP_FILE="results/tpcds_no_pk.sql"

# Check if the input file exists
[ ! -f "$INPUT_FILE" ] && echo "Error: Input file $INPUT_FILE not found." && exit 1

# Remove all lines containing primary key definitions
grep -v "    primary key" "$INPUT_FILE" > "$TEMP_FILE"

# Fix trailing commas before closing parentheses
# This replaces patterns like ",\n)" with "\n)" to ensure valid SQL syntax
sed 'N; s/,\n)/\n)/g' "$TEMP_FILE" > "$TEMP_FILE.tmp" && mv "$TEMP_FILE.tmp" "$TEMP_FILE"

# Replace the original file with the modified version
mv "$TEMP_FILE" "$INPUT_FILE"

# Print success message
echo "Primary key definitions have been removed in $INPUT_FILE"

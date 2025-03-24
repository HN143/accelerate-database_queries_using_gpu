#!/bin/bash

set -e  # Stop script if any command fails

echo "Updating the system..."
sudo apt update -y

# Install PostgreSQL
echo "### Installing PostgreSQL..."
sudo apt install -y postgresql postgresql-contrib

# Install Git
echo "### Installing Git..."
sudo apt install -y git
git clone https://github.com/HN143/accelerate-database_queries_using_gpu.git

# Install DuckDB
echo "### Installing DuckDB..."
sudo apt install -y curl
curl https://install.duckdb.org | sh
chmod +x $HOME/.duckdb/cli/latest/duckdb
sudo ln -sf $HOME/.duckdb/cli/latest/duckdb /usr/local/bin/duckdb

# Create tables
echo "### Creating tables in DuckDB..."

# Define DuckDB binary and database path
DUCKDB_BIN="duckdb"
DB_PATH="$HOME/nckh.duckdb"
SQL_FILE="$HOME/accelerate-database_queries_using_gpu/src/tpcds/results/tpcds_duckdb.sql"

# Execute the SQL script with DuckDB
$DUCKDB_BIN $DB_PATH < $SQL_FILE

if [ $? -eq 0 ]; then
    echo "SQL script executed successfully, data stored in $DB_PATH."
else
    echo "Error executing SQL script."
fi

echo "### Installation complete!"

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

# Install DuckDB
echo "### Installing DuckDB..."
sudo apt install -y curl
curl https://install.duckdb.org | sh
chmod +x $HOME/.duckdb/cli/latest/duckdb
sudo ln -sf $HOME/.duckdb/cli/latest/duckdb /usr/local/bin/duckdb

# Create DuckDB database and install TPC-H Extension
echo "### Installing and generating TPC-H data in DuckDB..."
duckdb tpch.duckdb <<EOF
INSTALL tpch;
LOAD tpch;
CALL dbgen(sf=1);  -- Generate 1GB of data
EOF

# Install Python3 and required libraries
# echo "### Installing Python3 and necessary libraries..."
#sudo apt install -y python3 python3-pip
# sudo apt install python3-matplotlib -y
# pip3 install matplotlib
# pip3 install numpy
# sudo apt install fim

echo "### Installation complete!"

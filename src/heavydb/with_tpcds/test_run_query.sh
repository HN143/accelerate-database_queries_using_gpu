#!/bin/bash

# Cài đặt sysstat nếu chưa có
sudo apt install sysstat -y

echo "Running DuckDB script..."
chmod +x duckdb_script/use_duckdb_generate_1gb_data.sh
./duckdb_script/use_duckdb_generate_1gb_data.sh

echo "Load data to heavydb..."
chmod +x heavydb/load_data.sh
./heavydb/load_data.sh

chmod +x resource_calculation/launcher.sh
./resource_calculation/launcher.sh &

sleep 0.5

echo "Run queries..."
chmod +x heavydb/run_queries.sh
./heavydb/run_queries.sh

echo "Process completed successfully!"

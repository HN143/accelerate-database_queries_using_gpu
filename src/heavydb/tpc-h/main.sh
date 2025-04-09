#!/bin/bash

# Bật chế độ dừng script nếu có lỗi xảy ra
set -e  

echo "Running DuckDB script..."
chmod +x grenerate_data/use_duckdb_generate_1gb_data.sh
./grenerate_data/use_duckdb_generate_1gb_data.sh

echo "Running load data script..."
chmod +x heavy_db/load_data.sh
./heavy_db/load_data.sh

# Cài đặt sysstat nếu chưa có
sudo apt install sysstat -y

chmod +x resource_calculation/launcher.sh
./resource_calculation/launcher.sh &

sleep 1

echo "Running query script..."
chmod +x heavy_db/run_queries.sh
./heavy_db/run_queries.sh

echo "grenerate data completed successfully!"


#!/bin/bash

# Bật chế độ dừng script nếu có lỗi xảy ra
set -e  

echo "Installing curl..."
sudo apt update -y
sudo apt install -y curl

echo "Installing card driver..."
# Kiểm tra card đồ họa
chmod +x graphic_card/check_and_install_card_driver.sh
./graphic_card/check_and_install_card_driver.sh

# Kiểm tra thư mục DuckDB
if [[ ! -d "duckdb_script" ]]; then
    echo "Error: Directory 'duckdb' not found!"
    exit 1
fi

echo "Installing DuckDB..."
chmod +x duckdb_script/install_duckdb.sh
./duckdb_script/install_duckdb.sh

echo "Running DuckDB script..."
chmod +x duckdb_script/use_duckdb_generate_1gb_data.sh
./duckdb_script/use_duckdb_generate_1gb_data.sh

# Kiểm tra thư mục HeavyDB
if [[ ! -d "heavydb" ]]; then
    echo "Error: Directory 'heavydb' not found!"
    exit 1
fi

# Kiểm tra main_reboot.sh có tồn tại không trước khi cấp quyền chạy
if [[ -f "main_reboot.sh" ]]; then
    chmod +x main_reboot.sh
fi

echo "Running install heavydb..."
chmod +x heavydb/install_heavydb.sh
./heavydb/install_heavydb.sh


echo "Installation and setup completed successfully!"


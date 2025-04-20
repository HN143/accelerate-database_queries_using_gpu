#!/bin/bash

# Bật chế độ dừng script nếu có lỗi xảy ra
set -e  

echo "Running install heavydb..."
chmod +x heavydb/install_heavydb_p2.sh
./heavydb/install_heavydb_p2.sh

echo "Update config heavydb..."
chmod +x heavydb/update_heavyai_conf.sh
./heavydb/update_heavyai_conf.sh

echo "ALTER USER admin (password = 'vien');" | heavysql -t -p HyperInteractive


chmod +x benchmark.sh

echo "Process completed successfully!"


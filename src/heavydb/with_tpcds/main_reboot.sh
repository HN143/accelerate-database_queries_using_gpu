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


chmod +x run_query.sh

#echo "Load data to heavydb..."
#chmod +x heavydb/load_data.sh
#./heavydb/load_data.sh


# Cài đặt sysstat nếu chưa có
#sudo apt install sysstat -y

#chmod +x resource_calculation/launcher.sh
#./resource_calculation/launcher.sh &

#echo "Run queries..."
#chmod +x heavydb/run_queries.sh
#./heavydb/run_queries.sh

echo "Process completed successfully!"


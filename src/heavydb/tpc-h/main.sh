#!/bin/bash


# Kiểm tra đầu vào
if [ $# -ne 3 ]; then
  echo "Usage: $0 <data_size> <query_number> <log_directory>"
  exit 1
fi

DATA_SIZE=$1
QUERY_NUM=$2
LOG_DIR=$3

# Cài đặt sysstat nếu chưa có
echo "Installing sysstat if not already installed..."
sudo apt install sysstat -y


# Tạo dữ liệu bằng DuckDB
echo "drop_table on heavydb"
chmod +x drop_table.sh
./drop_table.sh

# Tạo dữ liệu bằng DuckDB
echo "Generating data with DuckDB..."
chmod +x grenerate_data/use_duckdb_generate_1gb_data.sh
./grenerate_data/use_duckdb_generate_1gb_data.sh "$DATA_SIZE" || { echo "Failed to generate data."; exit 1; }

# Load vào HeavyDB
echo "Loading data to HeavyDB..."
chmod +x heavydb/load_data.sh
./heavydb/load_data.sh || { echo "Failed to load data."; exit 1; }

# Lặp 3 lần với 3 thư mục con log riêng biệt
for run in {1..3}; do
    CURRENT_LOG_DIR="$LOG_DIR/run$run"
    mkdir -p "$CURRENT_LOG_DIR"

    echo "========== Run $run =========="
    echo "Logging to: $CURRENT_LOG_DIR"

    # Ghi log sử dụng tài nguyên
    echo "Starting resource usage logging..."
    chmod +x resource_calculation/launcher.sh
#    ./resource_calculation/launcher.sh "$CURRENT_LOG_DIR" &

    sleep 0.5

    # Chạy truy vấn
    echo "Running queries..."	
    chmod +x heavydb/run_queries.sh
    ./heavydb/run_queries.sh "$QUERY_NUM" "$CURRENT_LOG_DIR" || { echo "Failed to run queries in run$run."; exit 1; }

    wait  # Đợi tiến trình background từ launcher.sh hoàn tất nếu cần
    sleep 5
done

echo "✅ All 3 runs completed successfully."


echo "✅ Process completed successfully!"


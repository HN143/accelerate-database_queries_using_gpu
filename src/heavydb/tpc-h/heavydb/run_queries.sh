#!/bin/bash

# Nhận tham số từ dòng lệnh
QUERY_NUM=$1
LOG_DIR=$2

# Kiểm tra đầu vào
if [ -z "$QUERY_NUM" ] || [ -z "$LOG_DIR" ]; then
  echo "Usage: $0 <query_number> <log_directory>"
  exit 1
fi

# Đường dẫn thư mục query và file log
QUERY_PATH="sql/query/query${QUERY_NUM}/splited"
LOG_FILE="${LOG_DIR}/query${QUERY_NUM}_execution_times.csv"

# Tạo thư mục log nếu chưa có
mkdir -p "$LOG_DIR"

# Khởi tạo file log
> "$LOG_FILE"
echo "query, start at (ms), end at (ms), time (ms)" >> "$LOG_FILE"

# Chạy các truy vấn từ 1 đến 22
for i in {1..22}
do
    # Đọc nội dung của từng query từ file và chạy với heavysql
    query_file="${QUERY_PATH}/$i.sql"
    
    if [[ -f "$query_file" ]]; then
        echo "Running query $i..."
	start_time=$(date +"%Y-%m-%d %H:%M:%S.%3N")
        # Ghi lại thời gian thực thi vào log
        execution_time=$(cat $query_file | heavysql -t -p vien | grep "Execution time" | awk '{print $3}')

        # Ghi lại thời gian vào tệp log
        echo "query $i, $start_time, $(date +"%Y-%m-%d %H:%M:%S.%3N"), $execution_time" >> $LOG_FILE
    else
        echo "Query file $query_file does not exist"
    fi
done

echo "All queries executed. Time log saved in $LOG_FILE"


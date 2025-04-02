#!/bin/bash

# Tạo tệp log để lưu thời gian
log_file="query_execution_times.log"
> $log_file # Xóa nội dung tệp log trước khi bắt đầu

# Chạy các truy vấn từ 1 đến 99
for i in {1..22}
do
    # Đọc nội dung của từng query từ file và chạy với heavysql
    query_file="sql/queries_1/$i.sql"
    
    if [[ -f "$query_file" ]]; then
        echo "Running query $i..."

        # Ghi lại thời gian thực thi vào log
        execution_time=$(cat $query_file | heavysql -t -p vien | grep "Execution time" | awk '{print $3}')

        # Ghi lại thời gian vào tệp log
        echo "Query $i - Time: $execution_time ms" >> $log_file
    else
        echo "Query file $query_file does not exist"
    fi
done

echo "All queries executed. Time log saved in $log_file"


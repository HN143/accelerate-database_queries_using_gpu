#!/bin/bash

# Đầu vào là file chứa các truy vấn SQL
input_file="query_0.sql"
# Thư mục đầu ra để lưu từng truy vấn riêng biệt
output_dir="./splited"

# Tạo thư mục nếu chưa có
mkdir -p "$output_dir"

# Biến đếm số truy vấn
query_number=0
# Biến cờ để xác định đang ở trong đoạn truy vấn
inside_query=false
# Biến chứa tên file hiện tại
current_file=""

# Đọc từng dòng trong file đầu vào
while IFS= read -r line; do
    # Kiểm tra dòng bắt đầu truy vấn
    if [[ $line == --\ start\ query* ]]; then
        ((query_number++))
        printf -v current_file "$output_dir/query-%02d.sql" "$query_number"
        inside_query=true
        continue
    fi

    # Kiểm tra dòng kết thúc truy vấn
    if [[ $line == --\ end\ query* ]]; then
        inside_query=false
        current_file=""
        continue
    fi

    # Nếu đang trong truy vấn và dòng không phải comment, ghi ra file
    if $inside_query && [[ ! $line =~ ^-- ]]; then
        echo "$line" >> "$current_file"
    fi
done < "$input_file"

echo "✅ Đã tách $query_number câu truy vấn vào thư mục '$output_dir'."


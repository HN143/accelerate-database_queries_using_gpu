#!/bin/bash

# đường dẫn tệp
schema_sql="sql/create_table.sql"
load_data="sql/load_data.sql"

# Tạo bảng
cat $schema_sql | heavysql -t -p vien
echo "Create tables successful..........."

# thêm dữ liệu
SCRIPT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
cat "$load_data" | sed "s|exported_data/|$SCRIPT_DIR/exported_data/|g" | heavysql -t -p vien
echo "Load data successful.........."




#!/bin/bash

# đường dẫn tệp
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
drop_table_sql="$SCRIPT_DIR/sql/drop_tables.sql"

# Tạo bảng
cat $drop_table_sql | heavysql -t -p vien

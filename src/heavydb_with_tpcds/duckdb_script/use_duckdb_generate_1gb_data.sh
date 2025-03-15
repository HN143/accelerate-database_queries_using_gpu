#!/bin/bash

# Đường dẫn đến DuckDB (đảm bảo đã cài DuckDB vào thư mục hiện tại)
DUCKDB_BIN="duckdb"  # Nếu duckdb đã có trong hệ thống, thay bằng `duckdb`
TARGET_DIR="exported_data"  # Thư mục lưu dữ liệu xuất ra

# Tạo thư mục lưu trữ nếu chưa có
mkdir -p "$TARGET_DIR"

# Chạy DuckDB và thực thi các lệnh SQL
./$DUCKDB_BIN <<EOF
INSTALL tpcds;
LOAD tpcds;
SELECT * FROM dsdgen(sf=1);
EXPORT DATABASE '$TARGET_DIR' (FORMAT CSV, DELIMITER '|');
EOF

echo "DuckDB has completed execution. Data exported to: $TARGET_DIR"

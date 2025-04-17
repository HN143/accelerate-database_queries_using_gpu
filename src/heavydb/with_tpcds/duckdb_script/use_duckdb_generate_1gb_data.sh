#!/bin/bash

# Kiểm tra tham số đầu vào
if [ -z "$1" ]; then
  echo "Usage: $0 <DATA_SIZE>"
  exit 1
fi

DATA_SIZE=$1  # Giá trị scale factor, ví dụ: 1, 5, 10, v.v.
DUCKDB_BIN="duckdb"  # Có thể là ./duckdb nếu bạn dùng file local
TARGET_DIR="exported_data"  # Thư mục lưu dữ liệu
#DATA_DIR="data.duckdb"  # Thư mục lưu dữ liệu
DATA_DIR="mnt/data/storage/tpcds/${DATA_SIZE}GB.duckdb"

# Xóa thư mục nếu đã tồn tại, sau đó tạo mới
if [ -d "$TARGET_DIR" ]; then
  echo "Directory $TARGET_DIR already exists. Removing..."
  rm -rf "$TARGET_DIR"
fi

mkdir -p "$TARGET_DIR"

# Chạy DuckDB với scale factor được truyền vào
./$DUCKDB_BIN $DATA_DIR<<EOF
INSTALL tpcds;
LOAD tpcds;
SELECT * FROM dsdgen(sf=${DATA_SIZE});
EXPORT DATABASE '$TARGET_DIR' (FORMAT CSV, DELIMITER '|');
EOF

rm -f -v $DATA_DIR

echo "DuckDB has completed execution with sf=${DATA_SIZE}. Data exported to: $TARGET_DIR"

